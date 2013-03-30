pinky = require '../lib'

(require 'mocha-as-promised')!
o     = it

chai = require 'chai'
chai.use (require 'chai-as-promised')
chai.use (require 'chai-interface')
{expect} = chai


delay = (n, f) -> set-timeout f, n

Promise = do
          then      : Function
          always    : Function
          otherwise : Function
          fulfill   : Function
          reject    : Function
  

describe 'Promises/A+ Tests' ->
  (require 'promises-aplus-tests').mocha do
    fulfilled: (value) -> pinky!fulfill value
    rejected:  (value) -> pinky!reject value
    pending:           -> do
                          p = pinky!
                          promise: p
                          fulfill: p.fulfill
                          reject:  p.reject

describe 'Pinky Tests' ->
  describe 'λ pinky-promise(Thenable)' ->
    [p, p2] = []
    before-each (done) ->
      p  := pinky!
      p2 := pinky p
      done!
  
    o 'Should lift the Thenable into a Promise.' (done) ->
       expect p2 .to.have.interface(Promise)
       done!

    o 'Should be fulfilled when the Thenable is.' ->
       p.fulfill 'a'
       expect p .to.become 'a'
       expect p2 .to.become 'a'

    o 'Should be rejected when the Thenable is.' ->
       p.reject (new Error 'no u')
       expect p .to.be.rejected.with /no u/
       expect p2 .to.be.rejected.with /no u/

  describe 'λ always(Function)' ->
    o 'Should be called when promise is fulfilled.' ->
       p = pinky!fulfill 'a'
       p2 = p.always (+ 'b')
       expect p .to.become 'ab'
       expect p2 .to.become 'ab'
       
    o 'Should be called when promise is rejected.' ->
       p = pinky!fulfill 'a'
       p2 = p.always (+ 'b')
       expect p .to.become 'ab'
       expect p2 .to.become 'ab'


  describe 'λ otherwise(Function)' ->
    o 'Should not be called when the promise is fulfilled.' (done) ->
       s = -> s.called = true
       p = pinky!fulfill 'a'
       p2 = p.otherwise s
       delay 100 -> do
                    expect p .to.become 'a'
                    expect s.called .to.equal void
                    done!

    o 'Should be called when the promise is rejected.' ->
       p = pinky!reject (new Error 'no u')
       p2 = p.otherwise -> ':3'
       expect p .to.be.rejected.with /no u/
       expect p2 .to.become ':3'


