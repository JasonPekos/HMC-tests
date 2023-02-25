
include("integrators.jl")
N = 1000
ϵ = 0.3
q_euler = zeros(N + 1)
p_euler = zeros(N + 1)
q_modified = zeros(N + 1)
p_modified = zeros(N + 1)
q_leapfrog = zeros(N + 1)
p_leapfrog = zeros(N + 1)

q_euler[1] = 0
p_euler[1] = 1

q_modified[1] = 0
p_modified[1] = 1


q_leapfrog[1] = 0
p_leapfrog[1] = 1


for i in 1:N
    q_euler[i + 1], p_euler[i + 1] = hardcoded_1d_euler_neal_2011_step(q_euler[i], p_euler[i], ϵ)
    q_modified[i + 1], p_modified[i + 1] = hardcoded_1d_modified_euler_neal_2011_step(q_modified[i], p_modified[i], ϵ)
    q_leapfrog[i + 1], p_leapfrog[i + 1] = hardcoded_1d_leapfrog_neal_2011_step(q_leapfrog[i], p_leapfrog[i], ϵ)
end

plot(q_euler, p_euler, seriestype = :scatter, color = :blue);
plot!(q_euler, p_euler, linewith = 0.4, color = :blue, label = "Euler, analytic gradients");
plot!(q_modified, p_modified, seriestype = :scatter, color = :green);
plot!(q_modified, p_modified, linewith = 0.4, color = :green, label = "Modified Euler, analytic gradients");
plot!(q_leapfrog, p_leapfrog, seriestype = :scatter, color = :red);
plot!(q_leapfrog, p_leapfrog, linewith = 0.4, color = :red, label = "Leapfrog, analytic gradients")
title!("Recreating Integration Results for Neal 2011", fmt = :png)


anim = @animate for i in 1:length(q_euler)
    plot(q_euler[1:i], p_euler[1:i], linewith = 0.4, color = c_mid, label = "Euler, analytic gradients", xlim = (-3, 3), ylim = (-3, 3));
    plot!(q_euler[1:i], p_euler[1:i], seriestype = :scatter, color = c_mid, xlim = (-3, 3), ylim = (-3, 3));


    plot!(q_modified[1:i], p_modified[1:i], linewith = 0.4, color = c_light, label = "Modified Euler, analytic gradients", xlim = (-3, 3), ylim = (-3, 3));
    plot!(q_modified[1:i], p_modified[1:i], seriestype = :scatter, color = c_light, xlim = (-3, 3), ylim = (-3, 3));

    plot!(q_leapfrog[1:i], p_leapfrog[1:i], linewith = 0.4, color = c_dark, label = "Leapfrog, analytic gradients", xlim = (-3, 3), ylim = (-3, 3));
    plot!(q_leapfrog[1:i], p_leapfrog[1:i], seriestype = :scatter, color = c_dark, xlim = (-3, 3), ylim = (-3, 3));
    title!("Neal 2011 Integrators")
end


p = plot(q_leapfrog, p_leapfrog, linewith = 0.4, color = c_dark, label = "True Levelset", xlim = (-3, 3), ylim = (-3, 3), fmt = :PDF)
plot!(q_euler, p_euler, linewith = 0.4, color = c_mid, label = "Euler, analytic gradients", xlim = (-3, 3), ylim = (-3, 3))
plot!(q_euler, p_euler, seriestype = :scatter, color = c_mid, xlim = (-3, 3), ylim = (-3, 3))


anim = @animate for i in 1:length(q_euler)
    plot(q_euler[1:i], p_euler[1:i], linewith = 0.4, color = c_mid, label = "Euler, analytic gradients", xlim = (-3, 3), ylim = (-3, 3));
    plot!(q_euler[1:i], p_euler[1:i], seriestype = :scatter, color = c_mid, xlim = (-3, 3), ylim = (-3, 3));

    title!("Euler's Method Blows Up")
end


gif(anim)