# trig

using QuadGK
include("beamline_base.jl")

function theta_plus(
    x::Float64,
    bl::Beamline,
)
    diff = (bl.apps_w.- x)./ (-bl.apps_pos.+ bl.det_pos)
    min(atan.(diff)...)
end


function theta_minus(
    x::Float64,
    bl::Beamline,
)
    diff = (-bl.apps_w.- x)./ (-bl.apps_pos.+ bl.det_pos)
    max(atan.(diff)...)
end


function theta_plus(
    x,
    params,
    det_pos,
)
    n_app = Int64(length(params) * 0.5)
    apps_pos = params[1:n_app]
    apps_w = params[n_app + 1: 2*n_app]
    
    diff = (apps_w.- x)./ (-apps_pos.+ det_pos)
    min(atan.(diff)...)
end


function theta_minus(
    x,
    params,
    det_pos,
)
    n_app = Int64(length(params) * 0.5)
    apps_pos = params[1:n_app]
    apps_w = params[n_app + 1: 2*n_app]
    
    diff = (-apps_w.- x)./ (-apps_pos.+ det_pos)
    min(atan.(diff)...)
end


function lambda_pdf(
    lam::Float64
)
    lambda_hat = 0.5
    lambda_diff = 0.055
    norm_tria = lambda_diff^2
    if abs(lambda_hat - lam) < lambda_diff
        (lambda_diff - abs(lambda_hat - lam)) / norm_tria
    else
        0.0
    end
end


function theta_func(
    theta::Float64,
    lambda::Float64,
    kappa::Float64 = 0.02,
)
    if abs(theta) < (kappa * lambda) 
        lambda_pdf(lambda) / (2. * (kappa * lambda)) 
    else
        0.
    end
end


function theta_dist(
    theta::Float64
)
    lambda_hat = 0.5
    lambda_diff = 0.055

    quadgk(
        lam -> theta_func(theta, lam),
        lambda_hat - lambda_diff,
        lambda_hat + lambda_diff,
    )[1]
end	