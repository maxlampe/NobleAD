# distribution calculation Beamline

using QuadGK
include("beamline_base.jl")

function beam_dist(
	x_val::Float64,
	bl::Beamline,
)
	theta_m = theta_minus(x_val, bl) 
	theta_p = theta_plus(x_val, bl)
	
	if theta_m < theta_p 
		quadgk(
			thet -> theta_dist(thet),
			theta_m,
			theta_p,
		)[1]
	else
		0.0
	end
end


function beam_dist(
	x_val,
	params,
    det_pos,
)
	theta_m = theta_minus(x_val, params, det_pos) 
	theta_p = theta_plus(x_val, params, det_pos)
	
	if theta_m < theta_p 
		# quadgk(
		# 	thet -> theta_dist(thet),
		# 	theta_m,
		# 	theta_p,
		# )[1]
		quadgk(
			thet -> (
				theta_dist(thet)
				* 1.0 / (1. + exp(-500.0 * (-thet + theta_p)))
				* 1.0 / (1. + exp(-500.0 * (thet - theta_m)))
			),
			-1.,
			1.,
		)[1]
	else
		0.0
	end
end


function beam(
	bl::Beamline
)
	norm = quadgk(
		x -> beam_dist(x, bl),
		min(bl.det_span...),
		max(bl.det_span...),
		atol=0.001
	)[1]
	[beam_dist(x, bl)./ norm for x in bl.det_span]
end


function beam(
	params,
	eval_points,
    det_pos,
)
	norm = quadgk(
		x -> beam_dist(x, params, det_pos),
		min(eval_points...),
		max(eval_points...),
		atol=0.01
	)[1]
	[beam_dist(x, params, det_pos)./ norm for x in eval_points]
end
