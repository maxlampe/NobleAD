
using Plots

include("beamline_base.jl")
include("plotting.jl")

gr()

beam_line = beamline(
    [1.0718, 2.0261, 2.77995, 3.42535, 4.18225], # chopper at 4.4435
    [0.03, 0.0585 * 0.5, 0.03, 0.03, 0.03],
    5.895 + 2.7 * 0.5, # middle of central decay volume
    Vector{Float64}(-0.2:0.001:0.2),
)



plot_setup(beam_line)
plot_beamdist(beam_line)
gui() # ?
