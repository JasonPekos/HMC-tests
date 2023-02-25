using Distributions, StatsPlots, LinearAlgebra, Zygote
include("plot_defaults.jl")
include("helperfunctions.jl")
include("integrators.jl")
include("HMC.jl")


cv = 0.95

log_rosen(x) =  log((1-x[1])^2 + 100*(x[2] - x[1]^2)^2)


Σ = [1 cv; cv 1]
dist = MvNormal(Σ)
neg_logpdf(x) = -logpdf(dist, x)


#= 
HAMILTONIAN DYNAMICS
=#
N = 100
ϵ = 0.01
q = zeros(N + 1, 2)
p = zeros(N + 1, 2)

q[1,:] = [0, 0]
p[1,:] = [-0.1, 0.1]


for i in 1:N
    q[i + 1,:], p[i + 1,:] = leapfrog_step(log_rosen, q[i,:], p[i,:], Σ, ϵ)
end

q_i = [1,1]

hmc_step(neg_logpdf, q_i, 10, 0.1, [1 0; 0 1])
#=
 true dist
=#
draws = rand(dist, 500)
heatmapplot(dist, cmap = :linear_blue_95_50_c20_n256)


xrange = -2:0.01:5
yrange = -2:0.01:5
heatmap(xrange,
        yrange,
        reshape(log_rosen.([[x,y] for x in xrange for y in yrange]),
               (length(xrange), length(yrange))),
        legend = false);

plot!(q[:,1], q[:,2], color = c_mid_highlight);
plot!(q[:,1], q[:,2], seriestype = :scatter, color = c_mid_highlight);

plot!([q[1,1]], [q[1,2]], seriestype = :scatter, color = :darkgreen)
