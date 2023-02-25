using Zygote

function hardcoded_1d_euler_neal_2011_step(q_i, p_i, ϵ)
    q_new = q_i + ϵ*p_i
    p_new = p_i - ϵ*q_i
    return q_new, p_new
end

function hardcoded_1d_modified_euler_neal_2011_step(q_i, p_i, ϵ)
    p_new = p_i - ϵ*q_i
    q_new = q_i + ϵ*p_new
    return q_new, p_new
end

function hardcoded_1d_leapfrog_neal_2011_step(q_i, p_i, ϵ)
    p_new_partial = p_i - (ϵ/2) * q_i
    q_new = q_i + ϵ*p_new_partial
    p_new = p_new_partial - (ϵ/2) * q_new

    return q_new, p_new
end

function leapfrog_step_hardcoded_gaussian(q_i, p_i, Σ, ϵ)
    p_new_partial = p_i - (ϵ/2) * gradient(x -> -logpdf(dist, x), (q_i))[1]
    q_new = q_i + ϵ .* (Σ' * p_new_partial)
    p_new = p_new_partial - (ϵ/2) * gradient(x -> -logpdf(dist, x), (q_new))[1]

    return q_new, p_new
end

function leapfrog_step(neg_logpdf, q_i, p_i, Σ, ϵ)
    p_new_partial = p_i - (ϵ/2) * gradient(neg_logpdf, q_i)[1]
    q_new = q_i + ϵ .* (Σ' * p_new_partial)
    p_new = p_new_partial - (ϵ/2) * gradient(neg_logpdf, q_new)[1]
    return q_new, p_new
end

