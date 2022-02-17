### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# ╔═╡ 70cb4530-8f53-11ec-16cb-b72e45afedd6
begin
	using Pkg
	Pkg.add("Plots")
	using Plots
	Pkg.add("QuadGK")
	using QuadGK
	Pkg.add("Distributions")
	using Distributions
end

# ╔═╡ 6d29b581-46d6-469e-b6b2-2f742476b489
begin
	Pkg.add("ForwardDiff")
	using ForwardDiff
end

# ╔═╡ 5908b722-0c56-463c-9d02-d2976ac88114
gr()

# ╔═╡ 12bf416e-4edf-4808-8256-8b82c427ec6c
# function d_t(alpha::Float64, x_t::Float64, x_1::Float64, w_1::Float64)
function d_t(alpha, x_t, x_1, w_1)
	val = tan(alpha) * (x_t.- x_1) 
	val.+ w_1
end

# ╔═╡ 839e16da-a3c4-442f-8b7c-9fd001d68f6b
function int_d_t(x_t, x_1, w_1)
	thet_mean = 25. * 2. * pi / 360.
	thet_sig = 5.  * 2. * pi / 360.
	integral, err = quadgk(
		thet -> d_t(thet, x_t, x_1, w_1) * pdf.(Normal(thet_mean, thet_sig), thet),
		0,
		pi * 0.5,
		rtol=1e-8,
	)
	norm, n_err = quadgk(
		thet -> pdf.(Normal(thet_mean, thet_sig), thet),
		0,
		pi * 0.5,
		rtol=1e-8,
	)
	integral / norm
end

# ╔═╡ eda42b78-74a9-4ef0-8daa-536322f0408d
d_t(5. * 2. * pi / 360., 10., 1., 0.06)

# ╔═╡ ba02400a-9b0a-4bc8-83b6-7f60a0b98fa0
int_d_t(10., 1., 0.06)

# ╔═╡ b4e533a5-b09d-4720-95b6-bf6358d35451
begin
	alpha_fix = 25. * 2. * pi / 360.
	x_detector = 5.0
	apperture_w = 0.06
	x = 0:0.01:x_detector
	y = d_t(alpha_fix, x_detector, x, apperture_w)
	y_int = int_d_t(x_detector, x, apperture_w)
end

# ╔═╡ 04cb89f7-c16e-4b07-bc6b-2dbf2ab9415e
begin
	plot(x, y)
	plot!(x, zeros(length(x)).+ apperture_w)
end

# ╔═╡ a0fa940b-6b6f-475a-a4dd-0c25a83bbd99
begin
	plot(x, y_int)
	plot!(x, zeros(length(x)).+ apperture_w, label="apperture width")
end

# ╔═╡ 2cd80c1f-b14f-4746-aa51-add0f6cdd1b1
begin
	only_x_int_d_t = x -> int_d_t(x_detector, x, apperture_w)
	grad_t = x -> ForwardDiff.derivative(only_x_int_d_t, x)
end

# ╔═╡ 745b4c15-e950-42b0-a9b7-5e1c1605d4d1
grad_t(0.5)

# ╔═╡ Cell order:
# ╠═70cb4530-8f53-11ec-16cb-b72e45afedd6
# ╠═5908b722-0c56-463c-9d02-d2976ac88114
# ╠═12bf416e-4edf-4808-8256-8b82c427ec6c
# ╠═839e16da-a3c4-442f-8b7c-9fd001d68f6b
# ╠═eda42b78-74a9-4ef0-8daa-536322f0408d
# ╠═ba02400a-9b0a-4bc8-83b6-7f60a0b98fa0
# ╠═b4e533a5-b09d-4720-95b6-bf6358d35451
# ╠═04cb89f7-c16e-4b07-bc6b-2dbf2ab9415e
# ╠═a0fa940b-6b6f-475a-a4dd-0c25a83bbd99
# ╠═6d29b581-46d6-469e-b6b2-2f742476b489
# ╠═2cd80c1f-b14f-4746-aa51-add0f6cdd1b1
# ╠═745b4c15-e950-42b0-a9b7-5e1c1605d4d1
