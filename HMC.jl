# See e.g. https://gregorygundersen.com/blog/2020/07/05/hmc/#neal2011mcmc
function hmc_step(log_prob, q_i, leapfrog_steps, ϵ, mass_matrix)

    energy_dist = MvNormal(mass_matrix)

    p = zeros(leapfrog_steps + 1, length(q_i))
    q = zeros(leapfrog_steps + 1, length(q_i))

    p[1,:] = rand(energy_dist)
    q[1,:] = q_i

    for i in 1:leapfrog_steps
        q[i + 1, :], p[i + 1, :] = leapfrog_step(log_prob, q[i,:], p[i,:], mass_matrix, ϵ)
    end

    return q, p
end

function hmc_sample(log_prob, n_samples, init, leapfrog_steps, ϵ, mass_matrix) 
    samples = zeros(n_samples, length(init))
    samples[1, :] = init

    for i in 2:n_samples
        traj, _ = hmc_step(log_prob, samples[i-1, :], leapfrog_steps, ϵ, mass_matrix)

        samples[i, :] = traj[end,:]
    end

    return samples
end


function hmc_step_1d(log_prob, q_i, leapfrog_steps, ϵ, proposal_dist_sd)

    energy_dist = Normal(proposal_dist_sd)

    p = zeros(leapfrog_steps + 1, 1)
    q = zeros(leapfrog_steps + 1, 1)

    p[1] = rand(energy_dist)
    q[1] = q_i


    for i in 1:leapfrog_steps
        p_new_partial = p[i] - (ϵ/2) * gradient(log_prob, q[i])[1]
        q_new = q[i] + ϵ .* (proposal_dist_sd * p_new_partial)
        p_new = p_new_partial - (ϵ/2) * gradient(neg_logpdf, q_new)[1]

        q[i+1] = q_new
        p[i+1] = p_new
    end

    return q, p
end
