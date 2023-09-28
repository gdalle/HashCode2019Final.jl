using HashCode2019Final
using Documenter

DocMeta.setdocmeta!(
    HashCode2019Final, :DocTestSetup, :(using HashCode2019Final); recursive=true
)

makedocs(;
    modules=[HashCode2019Final],
    authors="Guillaume Dalle",
    repo="https://github.com/gdalle/HashCode2019Final.jl/blob/{commit}{path}#{line}",
    sitename="HashCode2019Final.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://gdalle.github.io/HashCode2019Final.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=["Home" => "index.md"],
)

deploydocs(; repo="github.com/gdalle/HashCode2019Final.jl", devbranch="main")
