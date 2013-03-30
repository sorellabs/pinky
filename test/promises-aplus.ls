pinky = require '../lib'

describe 'Promises/A+ Tests' ->
  (require 'promises-aplus-tests').mocha do
    fulfilled: (value) -> pinky!fulfill value
    rejected:  (value) -> pinky!reject value
    pending:           -> do
                          p = pinky!
                          promise: p
                          fulfill: p.fulfill
                          reject:  p.reject

