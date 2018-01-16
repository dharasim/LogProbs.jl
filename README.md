# LogProbs

[![Build Status](https://travis-ci.org/dharasim/LogProbs.jl.svg?branch=master)](https://travis-ci.org/dharasim/LogProbs.jl)
[![Coverage Status](https://coveralls.io/repos/dharasim/LogProbs.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/dharasim/LogProbs.jl?branch=master)
[![codecov.io](http://codecov.io/github/dharasim/LogProbs.jl/coverage.svg?branch=master)](http://codecov.io/github/dharasim/LogProbs.jl?branch=master)

This package provides the Type `LogProb` for calculations with [logspace probabilities](https://en.wikipedia.org/wiki/Log_probability).

## Usage
```julia
julia> using LogProbs

julia> p = LogProb(.2)
LogProb(-1.6094379124341003)

julia> q = LogProb(.5)
LogProb(-0.6931471805599453)

julia> p + q
LogProb(-0.35667494393873234)

julia> exp(p+q)
0.7

julia> exp(p*q)
0.10000000000000002

julia> p * q ≈ LogProb(.1)
true

julia> exp(p-q)
ERROR: DomainError:
log will only return a complex result if called with a complex argument. Try log(complex(x)).
Stacktrace:
 [1] nan_dom_err at ./math.jl:300 [inlined]
 [2] log at ./math.jl:419 [inlined]
 [3] log1mexp(::Float64) at /Users/daniel/.julia/v0.6/StatsFuns/src/basicfuns.jl:35
 [4] -(::LogProbs.LogProb, ::LogProbs.LogProb) at /Users/daniel/.julia/v0.6/LogProbs/src/LogProbs.jl:20

julia> exp(q-p)
0.30000000000000004

julia> exp(p/q)
0.4

julia> rand(LogProb)
LogProb(-0.09991078882457756)

julia> p < q, q < p
(true, false)

julia> information(p) # Shannon information content in bits
2.321928094887362
```
