using Distributions, StatsPlots, LinearAlgebra, Zygote
include("plot_defaults.jl")
include("helperfunctions.jl")
include("integrators.jl")
include("HMC.jl")


# Target distribution
cv = 0.1
Σ = [1 cv; cv 1]
dist = MvNormal(Σ)
neg_logpdf(x) = -logpdf(dist, x)


#= 
HAMILTONIAN DYNAMICS
=#

q_i = [1,1]

q, p = hmc_step(neg_logpdf, q_i, 20, 0.1, [1 0; 0 1])

x = hmc_sample(neg_logpdf, 100, [1, 1], 10, 0.1, [1 0; 0 1])


plot(x[:,1], x[:,2], seriestype = :scatter)
#=
 true dist
=#


heatmapplot(dist);
plot!(q[:,1], q[:,2], color = c_mid_highlight);
plot!(q[:,1], q[:,2], seriestype = :scatter, color = c_mid_highlight);

plot!([q[1,1]], [q[1,2]], seriestype = :scatter, color = :darkgreen)
