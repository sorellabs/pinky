## Module pinky
#
# Sweetly small promises/a+ implementation.
#
# 
# Copyright (c) 2013 Quildreen "Sorella" Motta <quildreen@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

### λ defer
# Defers the evaluation of a function to the next event loop.
#
# :: Fun -> ()
defer =
  | process?       => process.next-tick
  | set-immediate? => set-immediate
  | otherwise      => (-> set-timeout it, 0)

### type State
# The various states a Promise can be at.
#
# :: Pending | Fulfilled | Rejected
s-pending   = ['pending']
s-fulfilled = ['fulfilled']
s-rejected  = ['rejected']


### {} Promise a
# The Promise object.
#
# :: { "state": State, "value": a, "pending": [Fun] }
class Promise
  ->
    @state = s-pending
    @value = null
    @pending = []

  #### λ then
  # Adds a transformation to this promise's eventual value.
  #
  # :: Fun, Fun -> Promise a
  then: (ok, failed) ->
    p = new Promise
    if @state is s-pending => bind-handler ok, failed, p, this
    else                   => defer (~> apply-promise @value, ok, failed, p, this)
    p


### λ bind-handler
# Creates a bound handler for handling the eventual value of a promise.
#
# :: Fun, Fun, Promise a, Promise a -> ()
bind-handler = (ok, failed, promise, parent) ->
  parent.pending.push (value) -> apply-promise value, ok, failed, promise, parent


### λ transformers-for
# Returns the transformers for applying a promise.
#
# :: Promise, Fun, Fun -> { "handler": Fun, "fallback": Fun }
choose-function = (promise, ok, failed) ->
  if promise.state is s-fulfilled => handler: ok, fallback: resolve
  else                            => handler: failed, fallback: reject


### λ is-promise
# Checks if something is a promise.
#
# :: a -> Bool
is-promise = (a) -> typeof a?.then is 'function'

### λ apply-promise
# Applies a promise.
#
# :: a, Fun, Fun, Promise, Promise -> ()
apply-promise = (value, ok, failed, promise, parent) ->
  f = choose-function parent, ok, failed
  try
    if typeof f.handler is 'function'
      result = f.handler value
      if is-promise result => result.then (-> resolve it, promise), (-> reject it, promise)
      else                 => resolve result, promise
    else
      f.fallback value, promise
  catch e
    reject e, promise

### λ transition
# Transitions the promise to another state.
#
# :: State, a, Promise a -> Promise a
transition = (state, value, promise) -> if promise.state is s-pending
  promise.state = state
  promise.value = value
  defer -> for f in promise.pending => f value
  promise

### λ resolve
# Fulfills a promise.
#
# :: a, Promise a -> Promise a
resolve = (value, promise) -> transition s-fulfilled, value, promise

### λ reject
# Rejects a promise.
#
# :: a, Promise a -> Promise a
reject = (value, promise) -> transition s-rejected, value, promise


### -- Exports ---------------------------------------------------------
module.exports = { Promise, resolve, reject }
