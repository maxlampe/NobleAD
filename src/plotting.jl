#

include("beamline_base.jl")

function plot_beamdist(bl::Beamline)
	plot(bl.det_span, beam(bl), label="beam dist", xticks=-0.10:0.02:0.1,)
	title!("Beam distribution")
	xlabel!("x [m]")
	ylabel!("pdf [ ]")
end


function plot_setup(bl::Beamline)
	scatter([0., bl.det_pos], [0., 0.], ylims=(-0.05, 0.05), label=false)
	plot!([0., bl.det_pos], [0., 0.], color=(:blue), label=false)

	perm = sortperm(bl.apps_pos)
	
	plot!(
		bl.apps_pos[perm],
		zeros(length(perm)),
		yerror=bl.apps_w[perm],
		markersize=3,
		markerstrokewidth = 1,
		label=false,
	)
	scatter!(
		bl.apps_pos[perm],
		zeros(length(perm)),
		yerror=bl.apps_w[perm],
		markersize=3,
		markerstrokewidth = 1,
		label=false,
	)
	max_app = max(bl.apps_w...) * 1.2
	for (ind, i) in enumerate(perm)
		annotate!(bl.apps_pos[i], max_app * (-1)^ind, text("A$i", 10))
	end
	current()
	# title!("Beam line setup")
	xlabel!("Beam axis [m]")
	ylabel!("x [m]")
	
	savefig("setup.pdf")
end


function plot_indidist(bl::Beamline)
	for (i, x_pos) in enumerate(bl.apps_pos)
		bl_temp = beamline(
			[x_pos],
			[bl.apps_w[i]],
			bl.det_pos,
			bl.det_span,
			bl.apps_maxpos,
			bl.eps,
		)
		y_temp = beam(bl_temp)

		if i == 1
			plot(bl.det_span, y_temp, label="aperture $i", xticks=-0.10:0.02:0.1,)
		else
			plot!(bl.det_span, y_temp, label="aperture $i")
		end
	end
	title!("Individual aperture distributions")
	xlabel!("spread [m]")
	ylabel!("pdf [ ]")
	current()
end
