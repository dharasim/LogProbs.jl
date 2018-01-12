module LogProbs

using StatsFuns: logsumexp, log1mexp
import Base: show, exp, zero, one, rand, +, -, *, /, <, promote_rule, convert
export LogProb

struct LogProb <: Number
    value :: Float64
    LogProb(number) = number <= 0 ? new(number) : new(log(number))
end

show(io::IO, x::LogProb) = print(io, "LogProb($(x.value))")
exp(x::LogProb) = exp(x.value)
information(p::LogProb) = - p.value / log(2)

*(x::LogProb, y::LogProb) = LogProb(x.value + y.value)
/(x::LogProb, y::LogProb) = LogProb(x.value - y.value)

+(x::LogProb, y::LogProb) = LogProb(logsumexp(x.value, y.value))
-(x::LogProb, y::LogProb) = LogProb(x.value + log1mexp(y.value-x.value))

<(x::LogProb, y::LogProb) = x.value < y.value

promote_rule(::Type{LogProb}, ::Type{Float64}) = LogProb
convert(::Type{LogProb}, x::Float64) = LogProb(x)

dist(x::LogProb, y::LogProb) = abs(x.value-y.value)
isapprox(x::LogProb, y::LogProb) = isapprox(x.value, y.value)

one(::Type{LogProb}) = LogProb(1.0)
zero(::Type{LogProb}) = LogProb(nextfloat(typemin(Float64)))

rand(::Type{LogProb}) = LogProb(rand())

end # Module
