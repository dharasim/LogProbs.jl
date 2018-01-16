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
