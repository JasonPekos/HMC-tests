
include("integrators.jl")
N = 500
ϵ0 = 0.01
ϵ1 = 0.3
ϵ2 = 1.0
ϵ3 = 1.8
ϵ4 = 1.9


q_leapfrog_0 = zeros(10*N + 1)
p_leapfrog_0 = zeros(10*N + 1)

q_leapfrog_1 = zeros(N + 1)
p_leapfrog_1 = zeros(N + 1)

q_leapfrog_2 = zeros(N + 1)
p_leapfrog_2 = zeros(N + 1)

q_leapfrog_3 = zeros(N + 1)
p_leapfrog_3 = zeros(N + 1)

q_leapfrog_4 = zeros(N + 1)
p_leapfrog_4 = zeros(N + 1)


p_leapfrog_0[1] = 1
p_leapfrog_1[1] = 1
p_leapfrog_2[1] = 1
p_leapfrog_3[1] = 1
p_leapfrog_4[1] = 1



for i in 1:10*N
    q_leapfrog_0[i + 1], p_leapfrog_0[i + 1] = hardcoded_1d_leapfrog_neal_2011_step(q_leapfrog_0[i], p_leapfrog_0[i], ϵ0)
end

for i in 1:N
    q_leapfrog_1[i + 1], p_leapfrog_1[i + 1] = hardcoded_1d_leapfrog_neal_2011_step(q_leapfrog_1[i], p_leapfrog_1[i], ϵ1)
    q_leapfrog_2[i + 1], p_leapfrog_2[i + 1] = hardcoded_1d_leapfrog_neal_2011_step(q_leapfrog_2[i], p_leapfrog_2[i], ϵ2)
    q_leapfrog_3[i + 1], p_leapfrog_3[i + 1] = hardcoded_1d_leapfrog_neal_2011_step(q_leapfrog_3[i], p_leapfrog_3[i], ϵ3)
    q_leapfrog_4[i + 1], p_leapfrog_4[i + 1] = hardcoded_1d_leapfrog_neal_2011_step(q_leapfrog_4[i], p_leapfrog_4[i], ϵ4)
end



# anim = @animate for i in 1:length(q_euler)
#     plot(layout = (4), plot_title = "Neal 2011 Integrators")

#     c1 = c_dark_highlight
#     c2 = c_mid

#     plot!(q_leapfrog_1[1:i], p_leapfrog_1[1:i], linewith = 0.4, color = c2, label = "Leapfrog, ϵ = $ϵ1", xlim = (-2, 2), ylim = (-2, 2), subplot = 1);
#     plot!(q_leapfrog_1[1:i], p_leapfrog_1[1:i], seriestype = :scatter, color = c1, xlim = (-2, 2), ylim = (-2, 2), subplot = 1);
#     plot!(q_leapfrog_2[1:i], p_leapfrog_2[1:i], linewith = 0.4, color = c2, label = "Leapfrog, ϵ = $ϵ2", xlim = (-2, 2), ylim = (-2, 2), subplot = 2);
#     plot!(q_leapfrog_2[1:i], p_leapfrog_2[1:i], seriestype = :scatter, color = c1, xlim = (-2, 2), ylim = (-2, 2), subplot = 2);
#     plot!(q_leapfrog_3[1:i], p_leapfrog_3[1:i], linewith = 0.4, color = c2, label = "Leapfrog, ϵ = $ϵ3", xlim = (-2, 2), ylim = (-2, 2), subplot = 3);
#     plot!(q_leapfrog_3[1:i], p_leapfrog_3[1:i], seriestype = :scatter, color = c1, xlim = (-2, 2), ylim = (-2, 2), subplot = 3);

#     plot!(q_leapfrog_4[1:i], p_leapfrog_4[1:i], linewith = 0.4, color = c2, label = "Leapfrog, ϵ = $ϵ4", xlim = (-2, 2), ylim = (-2, 2), subplot = 4);
#     plot!(q_leapfrog_4[1:i], p_leapfrog_4[1:i], seriestype = :scatter, color = c1, xlim = (-2, 2), ylim = (-2, 2), subplot = 4);
# end
# gif(anim)


p = plot(layout = (1,4), plot_title = "Leapfrog Integrator at Different Stepsizes", size = (2000, 500));
plot!(q_leapfrog_0, p_leapfrog_0, linewith = 0.4, color = 2, label = "", xlim = (-2, 2), ylim = (-2, 2), subplot = 1);
plot!(q_leapfrog_0, p_leapfrog_0, linewith = 0.4, color = 2, label = "True Levelset", xlim = (-2, 2), ylim = (-2, 2), subplot = 2);
plot!(q_leapfrog_0, p_leapfrog_0, linewith = 0.4, color = 2, label = "", xlim = (-2, 2), ylim = (-2, 2), subplot = 3);
plot!(q_leapfrog_0, p_leapfrog_0, linewith = 0.4, color = 2, label = "", xlim = (-2, 2), ylim = (-2, 2), subplot = 4);


plot!(q_leapfrog_1, p_leapfrog_1, linewith = 0.4, color = 3, label = "ϵ = $ϵ1", xlim = (-2, 2), ylim = (-2, 2), subplot = 1);
plot!(q_leapfrog_1, p_leapfrog_1, seriestype = :scatter, color = 1, xlim = (-2, 2), ylim = (-2, 2), subplot = 1);

plot!(q_leapfrog_2, p_leapfrog_2, linewith = 0.4, color = 3, label = "ϵ = $ϵ2", xlim = (-2, 2), ylim = (-2, 2), subplot = 2);
plot!(q_leapfrog_2, p_leapfrog_2, seriestype = :scatter, color = 1, xlim = (-2, 2), ylim = (-2, 2), subplot = 2);

plot!(q_leapfrog_3[1:1], p_leapfrog_3[1:1], linewith = 0.4, color = 3, label = "ϵ = $ϵ3", xlim = (-2, 2), ylim = (-2, 2), subplot = 3);
plot!(q_leapfrog_3, p_leapfrog_3, seriestype = :scatter, color = 1, xlim = (-2, 2), ylim = (-2, 2), subplot = 3);

plot!(q_leapfrog_4[101:101], p_leapfrog_4[101:101], linewith = 0.4, color = 3, label = "ϵ = $ϵ4", xlim = (-2, 2), ylim = (-2, 2), subplot = 4);
plot!(q_leapfrog_4, p_leapfrog_4, seriestype = :scatter, color = 1, xlim = (-2, 2), ylim = (-2, 2), subplot = 4)

png(p, "leapfrog")
