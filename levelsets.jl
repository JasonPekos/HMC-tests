using Distributions, StatsPlots, LinearAlgebra, Zygote
include("plot_defaults.jl")
include("helperfunctions.jl")
include("integrators.jl")
include("HMC.jl")


# Target distribution
dist = Normal(0, 4)
neg_logpdf(x) = -logpdf(dist, x)

#= 
HAMILTONIAN DYNAMICS
=#

q_i = 1

q, p = hmc_step_1d(neg_logpdf, q_i, 200, 0.1, 1)
plot!(q,p);
plot!([q[end] , q[end]], [p[end], 0], color = :grey);
plot!([q[end]], [0], seriestype = :scatter)
q_i = q[end]

qs = zeros(10, length(q))
ps = zeros(10, length(q))

qs[1,:] = q
ps[1,:] = p

for i in 2:length(qs[:,1])
    qs[i-1,:][end]
    qs[i,:], ps[i,:] = hmc_step_1d(neg_logpdf, qs[i-1,:][end], 200, 0.1, 1)
end

anim = @animate for i in 1:600
    plot(vec(qs)[1:i], vec(ps)[1:i])
end

gif(anim, fps = 30)