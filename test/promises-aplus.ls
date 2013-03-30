pinky = require '../lib'

describe 'Promises/A+ Tests' ->
  (require 'promises-aplus-tests').mocha do
    fulfilled: (value) -> do
                          p = pinky!
                          p.fulfill value
                          p
    rejected:  (value) -> do
                          p = pinky!
                          p.reject value
                          p
    pending:   -> do
                  p = pinky!
                  promise: p
                  fulfill: p.fulfill
                  reject:  p.reject

