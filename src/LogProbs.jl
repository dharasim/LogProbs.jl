module LogProbs

import Base:
    show, promote_rule, convert,
    zero, one, +, -, *, /, <,
    exp, rand, norm, isapprox
using StatsFuns:
    logsumexp, log1mexp

export LogProb, information

struct LogProb <: Number
    value :: Float64
    LogProb(number) = number <= 0 ? new(number) : new(log(number))
end

show(io::IO, x::LogProb) = print(io, "LogProb($(x.value))")
exp(x::LogProb) = exp(x.value)
information(p::LogProb) = - p.value / log(2)

*(x::LogProb, y::LogProb) = LogProb(x.value + y.value)
/(x::LogProb, y::LogProb) = if x.value > y.value
    LogProb(x.value - y.value)
else
    @assert(
        x.value ≈ y.value,
        str(
            "LogProb subtraction impossible, would yield negative probability "
            x, " ", y
        )
    )
    LogProb(0.0)
end

+(x::LogProb, y::LogProb) = LogProb(logsumexp(x.value, y.value))
-(x::LogProb, y::LogProb) = LogProb(x.value + log1mexp(y.value-x.value))

<(x::LogProb, y::LogProb) = x.value < y.value

promote_rule(::Type{LogProb}, ::Type{Int}) = LogProb
promote_rule(::Type{LogProb}, ::Type{Float64}) = LogProb
convert(::Type{LogProb}, x::Real) = LogProb(x)

norm(x::LogProb) = exp(x)
isapprox(x::LogProb, y::LogProb) = isapprox(exp(x), exp(y))

one(::Type{LogProb}) = LogProb(1.0)
zero(::Type{LogProb}) = LogProb(nextfloat(typemin(Float64)))

rand(::Type{LogProb}) = LogProb(rand())

end # Module
