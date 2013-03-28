{ Promise, resolve, reject } = require '../lib'

describe 'Promises/A+ Tests' ->
  (require 'promises-aplus-tests').mocha do
    fulfilled: (value) -> resolve value, new Promise
    rejected:  (value) -> reject value, new Promise
    pending:   -> do
                  p = new Promise
                  promise: p
                  fulfill: (-> resolve it, p)
                  reject: (-> reject it, p)

    
