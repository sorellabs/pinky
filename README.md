# Pinky [![Build Status](https://travis-ci.org/killdream/pinky.png)](https://travis-ci.org/killdream/pinky) ![Dependencies Status](https://david-dm.org/killdream/pinky.png)

Sweetly small promises/a+ implementation.


### Platform support

Should work fine in ES3.

[![browser support](http://ci.testling.com/killdream/pinky.png)](http://ci.testling.com/killdream/pinky)


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


### Why? WHY?

Most promise implementations I've seen plainly do way too much. OTOH Minimal
promise implementations (like [PinkySwear][]) provide a terrible API, which
really sucks.

So, I wrote Pinky to be a minimal and fast baseline for extensions to
promises/a+. Some implementation ideas are taken straight out from [avow][],
btw, but I might revisit this in the future and try to optimise things.



[Calliope]: https://github.com/killdream/calliope
[es5-shim]: https://github.com/kriskowal/es5-shim
[PinkySwear]: https://github.com/timjansen/PinkySwear.js
[avow]: https://github.com/briancavalier/avow
