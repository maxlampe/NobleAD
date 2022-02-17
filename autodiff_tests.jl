### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# ╔═╡ 542d7730-f6ae-479b-ad25-d005a74f7ed7
 using ForwardDiff

# ╔═╡ a7193187-ce24-4d28-a926-90889b711bb2
using Zygote

# ╔═╡ b715cece-636d-48c4-985d-0eac134ec894
md"""
# ForwardDiff with scalar function
"""

# ╔═╡ b4bb3561-569b-41e7-ae45-bb8fc0639b27
y(x) = ((x * sqrt(12 * x - 36 )) / (2 * (x - 3)))

# ╔═╡ 5c4686b9-04c5-44bb-a8da-893d4318b790
L(x) = sqrt(x ^ 2 + y(x) ^ 2)

# ╔═╡ f7af3286-503d-4021-b4f1-4cf7701cf0b1
gradL = x -> ForwardDiff.derivative(L, x)

# ╔═╡ c4b2ce86-457f-4f8c-baab-df63c6fbaef2
gradgradL = x -> ForwardDiff.derivative(gradL, x)

# ╔═╡ e2ac163f-1d84-483e-bae6-ce01847d4159
gradL(3.5)

# ╔═╡ 62f4863e-2319-44a8-9ac5-d463f8cacb5f
minGD(x) = x - 0.01 * gradL(x)

# ╔═╡ 5a3d3f56-db62-4939-b5d5-6d66702222c6
minNewton(x) = x - gradL(x) / gradgradL(x)

# ╔═╡ fa318da8-9bdf-4762-a4d6-b6099ee5bf76
x_dom = 4.

# ╔═╡ 86e1703e-6225-4895-924b-994dcbf18f9e
minGD(minGD(x_dom))

# ╔═╡ 8a073f32-2b15-4447-9168-d9a4ecdcb959
let curr = x_dom
	map(1:500) do i
		curr = minGD(curr)
	end
	curr
end

# ╔═╡ 4a2e8b7b-3e48-497b-88aa-2df55667317c
let curr = x_dom
	map(1:5) do i
		curr = minNewton(curr)
	end
	curr
end

# ╔═╡ bf5b3855-26ad-444e-ae86-5501f493b54c
md"""
# ForwardDiff with vector
"""

# ╔═╡ 065d2df3-a9ff-4e36-a00d-2f0f138a26a9
obj_func(x::Vector) = (x[1] - 10.) ^ 2. + (x[2] - 12.) ^ 2.

# ╔═╡ 0ceb7b76-b7d3-47e6-bbff-42dc4dbf22aa
x_vec = [8., 7.]

# ╔═╡ 8d200936-ad7c-4ae8-b514-ea03bc08744b
obj_func(x_vec)

# ╔═╡ 4a56fa59-7a42-4a4a-af8c-1df4d557268f
grad_obj = x -> ForwardDiff.gradient(obj_func, x)

# ╔═╡ 21f9fd3f-339c-406c-bd73-eaf3a070f93d
min_obj(x) = x - 0.05 * grad_obj(x)

# ╔═╡ 7745167d-5746-45c7-abab-eb1f347b5d47
min_obj(x_vec)

# ╔═╡ 1804cacd-01e0-4c9a-8af9-206641a4b510
let curr = x_vec
	map(1:100) do i
		curr = min_obj(curr)
	end
	curr
end

# ╔═╡ 94d83d92-13b1-49f0-9ea1-9e61af326fd6
md"""
# ReverseDiff with vector
"""

# ╔═╡ d0bce1c0-3040-4d64-b17d-ff5132d08866
zyg_grad_obj = x -> gradient(obj_func, x)

# ╔═╡ e858482e-f826-4d1f-a4fd-e4fd46ff0725
zyg_grad_obj(x_vec)[1]

# ╔═╡ 8a30bc3f-d5f7-42e5-b488-4f546fd6d615
zyg_min_obj(x) = x - 0.05 * zyg_grad_obj(x)[1]

# ╔═╡ 2a14101a-5235-4f1a-a2f1-9ccdae5fd9f1
zyg_min_obj(x_vec)

# ╔═╡ 8c7a9f21-6adc-40aa-989d-7a879d454991
let curr = x_vec
	map(1:100) do i
		curr = zyg_min_obj(curr)
	end
	curr
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[compat]
ForwardDiff = "~0.10.21"
Zygote = "~0.6.29"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "485ee0867925449198280d4af84bdb46a2a404d0"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.0.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[ChainRules]]
deps = ["ChainRulesCore", "Compat", "LinearAlgebra", "Random", "RealDot", "Statistics"]
git-tree-sha1 = "035ef8a5382a614b2d8e3091b6fdbb1c2b050e11"
uuid = "082447d4-558c-5d27-93f4-14fc19e9eca2"
version = "1.12.1"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "f885e7e7c124f8c92650d61b9477b9ac2ee607dd"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.11.1"

[[CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "dce3e3fea680869eaa0b774b2e8343e9ff442313"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.40.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[DiffResults]]
deps = ["StaticArrays"]
git-tree-sha1 = "c18e98cba888c6c25d1c3b048e4b3380ca956805"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.0.3"

[[DiffRules]]
deps = ["NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "7220bc21c33e990c14f4a9a319b1d242ebc5b269"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.3.1"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "8756f9935b7ccc9064c6eef0bff0ad643df733a3"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.12.7"

[[ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "63777916efbcb0ab6173d09a658fb7f2783de485"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.21"

[[IRTools]]
deps = ["InteractiveUtils", "MacroTools", "Test"]
git-tree-sha1 = "95215cd0076a150ef46ff7928892bc341864c73c"
uuid = "7869d1d1-7146-5819-86e3-90919afe41df"
version = "0.4.3"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "f0c6489b12d28fb4c2103073ec7452f3423bd308"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.1"

[[IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[LogExpFunctions]]
deps = ["ChainRulesCore", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "6193c3815f13ba1b78a51ce391db8be016ae9214"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.4"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NaNMath]]
git-tree-sha1 = "bfe47e760d60b82b66b61d2d44128b62e3a369fb"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.5"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "f0bccf98e16759818ffc5d97ac3ebf87eb950150"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.8.1"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3c76dde64d03699e074ac02eb2e8ba8254d428da"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.13"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[Zygote]]
deps = ["AbstractFFTs", "ChainRules", "ChainRulesCore", "DiffRules", "Distributed", "FillArrays", "ForwardDiff", "IRTools", "InteractiveUtils", "LinearAlgebra", "MacroTools", "NaNMath", "Random", "Requires", "SpecialFunctions", "Statistics", "ZygoteRules"]
git-tree-sha1 = "0fc9959bcabc4668c403810b4e851f6b8962eac9"
uuid = "e88e6eb3-aa80-5325-afca-941959d7151f"
version = "0.6.29"

[[ZygoteRules]]
deps = ["MacroTools"]
git-tree-sha1 = "8c1a8e4dfacb1fd631745552c8db35d0deb09ea0"
uuid = "700de1a5-db45-46bc-99cf-38207098b444"
version = "0.2.2"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─b715cece-636d-48c4-985d-0eac134ec894
# ╠═b4bb3561-569b-41e7-ae45-bb8fc0639b27
# ╠═5c4686b9-04c5-44bb-a8da-893d4318b790
# ╠═542d7730-f6ae-479b-ad25-d005a74f7ed7
# ╠═f7af3286-503d-4021-b4f1-4cf7701cf0b1
# ╠═c4b2ce86-457f-4f8c-baab-df63c6fbaef2
# ╠═e2ac163f-1d84-483e-bae6-ce01847d4159
# ╠═62f4863e-2319-44a8-9ac5-d463f8cacb5f
# ╠═5a3d3f56-db62-4939-b5d5-6d66702222c6
# ╠═fa318da8-9bdf-4762-a4d6-b6099ee5bf76
# ╠═86e1703e-6225-4895-924b-994dcbf18f9e
# ╠═8a073f32-2b15-4447-9168-d9a4ecdcb959
# ╠═4a2e8b7b-3e48-497b-88aa-2df55667317c
# ╟─bf5b3855-26ad-444e-ae86-5501f493b54c
# ╠═065d2df3-a9ff-4e36-a00d-2f0f138a26a9
# ╠═0ceb7b76-b7d3-47e6-bbff-42dc4dbf22aa
# ╠═8d200936-ad7c-4ae8-b514-ea03bc08744b
# ╠═4a56fa59-7a42-4a4a-af8c-1df4d557268f
# ╠═21f9fd3f-339c-406c-bd73-eaf3a070f93d
# ╠═7745167d-5746-45c7-abab-eb1f347b5d47
# ╠═1804cacd-01e0-4c9a-8af9-206641a4b510
# ╟─94d83d92-13b1-49f0-9ea1-9e61af326fd6
# ╠═a7193187-ce24-4d28-a926-90889b711bb2
# ╠═d0bce1c0-3040-4d64-b17d-ff5132d08866
# ╠═e858482e-f826-4d1f-a4fd-e4fd46ff0725
# ╠═8a30bc3f-d5f7-42e5-b488-4f546fd6d615
# ╠═2a14101a-5235-4f1a-a2f1-9ccdae5fd9f1
# ╠═8c7a9f21-6adc-40aa-989d-7a879d454991
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
