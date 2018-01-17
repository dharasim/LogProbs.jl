using LogProbs
using Base.Test

p = LogProb(.2)
q = LogProb(.5)
r = LogProb(.1)

@test p * q ≈ r
@test exp(p+q) ≈ 0.7
@test information(q) ≈ 1
@test r * 2 ≈ p
@test q - p ≈ LogProb(.3)
@test p / q ≈ LogProb(.4)
@test p + zero(LogProb) ≈ p
@test p *  one(LogProb) ≈ p
