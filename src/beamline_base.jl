# struct Beamline

mutable struct Beamline
	apps_pos::Vector{Float64}
	apps_w::Vector{Float64}
	det_pos::Float64
	det_span::Vector{Float64}
	apps_maxpos::Float64
	eps::Float64
end

function beamline(
	apps_pos::Vector{Float64},
	apps_w::Vector{Float64},
	det_pos::Float64,
	det_span::Vector{Float64} = Vector{Float64}(-0.1:0.001:0.1),
	eps::Float64=0.1,
	apps_maxpos::Float64 = det_pos - eps,
)
	Beamline(
		apps_pos,
		apps_w,
		det_pos,
		det_span,
		apps_maxpos,
		eps,
	)
end


Base.copy(bl::Beamline) = Beamline(
	bl.apps_pos,
	bl.apps_w,
	bl.det_pos,
	bl.det_span,
	bl.apps_maxpos,
	bl.eps,
)


function random_beamline(
	n_app::Int64 = 2,
	det_pos::Float64 = 10.0,
	dist_det_beam::Float64 = 1.0,
	eps::Float64 = 0.1,
	w_min::Float64 = 0.01,
	w_spread::Float64 = 0.03,
)
	max_pos = det_pos - eps - dist_det_beam
	x_aperture = [
		eps,
		min.((rand(n_app - 2).* (det_pos - eps)), det_pos - eps - dist_det_beam)...,
		det_pos - eps - dist_det_beam,
	]
	aperture_w = max.(rand(n_app) * w_spread, w_min)
	
	beamline(
		x_aperture,
		aperture_w,
		det_pos,
	)
end
