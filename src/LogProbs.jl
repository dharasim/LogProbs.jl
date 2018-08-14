module LogProbs

import Base: show, promote_rule, convert, exp, rand, isapprox
import Base: ==, hash
import Base: zero, one, +, -, *, /, <

using StatsFuns: logaddexp, log1mexp

export LogProb, information

struct LogProb <: Number
    value :: Float64
    LogProb(number; islog::Bool=false) = islog ? new(number) : new(log(number))
end

==(x::LogProb, y::LogProb)       = x.value == y.value
hash(x::LogProb, y::LogProb)     = hash(LogProb, hash(x.value))
rand(::Type{LogProb})            = LogProb(rand())
isapprox(x::LogProb, y::LogProb) = isapprox(x.value, y.value)
show(io::IO, x::LogProb)         = print(io, "LogProb($(exp(x)))")
exp(x::LogProb)                  = exp(x.value)
information(x::LogProb)          = - x.value / log(2)

one(::Type{LogProb})      = LogProb(1)
zero(::Type{LogProb})     = LogProb(0)

*(x::LogProb, y::LogProb) = LogProb(x.value + y.value, islog=true)
/(x::LogProb, y::LogProb) = LogProb(x.value - y.value, islog=true)
+(x::LogProb, y::LogProb) = LogProb(logaddexp(x.value, y.value), islog=true)
-(x::LogProb, y::LogProb) = LogProb(x.value + log1mexp(y.value-x.value), islog=true)

<(x::LogProb, y::LogProb) = x.value < y.value

promote_rule(::Type{LogProb}, ::Type{Int})     = LogProb
promote_rule(::Type{LogProb}, ::Type{Float64}) = LogProb
convert(::Type{LogProb}, x::Real)              = LogProb(x)

end # Module
