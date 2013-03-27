# Xavier [![Build Status](https://travis-ci.org/killdream/xavier.png)](https://travis-ci.org/killdream/xavier)

Small, psychographed promises/a+ implementation from outta this world. Yo.


### Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :3

[![browser support](http://ci.testling.com/killdream/xavier.png)](http://ci.testling.com/killdream/xavier)


### Example

```js
var promise = require('xavier')

var eventual = promise()
var eventual2 = eventual.then( function(a){ return a + 1 }
                             , function(a){ return a - 1 })

resolve(10, eventual)
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
