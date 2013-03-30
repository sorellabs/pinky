# Pinky [![Build Status](https://travis-ci.org/killdream/xavier.png)](https://travis-ci.org/killdream/xavier)

Sweetly small promises/a+ implementation.


### Platform support

Should work fine in ES3.

[![browser support](http://ci.testling.com/killdream/xavier.png)](http://ci.testling.com/killdream/xavier)


### Example

```js
var pinky = require('pinky')

var eventual = pinky()
var eventual2 = eventual.then( function(a){ return a + 1 }
                             , function(a){ return a - 1 })

eventual.fulfill(10)
eventual2.then( console.log.bind(console, 'ok:')
              , console.log.bind(console, 'failed:'))
// => ok: 11
```


### Installing

Just grab it from NPM:

    $ npm install xavier


### Documentation

A quick reference of the API can be built using [Calliope][]:

    $ npm install -g calliope
    $ calliope build


### Tests

You can run all tests using Mocha:

    $ npm test


### Licence

MIT/X11. ie.: do whatever you want.

[Calliope]: https://github.com/killdream/calliope
[es5-shim]: https://github.com/kriskowal/es5-shim
