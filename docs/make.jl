using Documenter, ControlSimTools

makedocs(;
    modules=[ControlSimTools],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/jonniedie/ControlSimTools.jl/blob/{commit}{path}#L{line}",
    sitename="ControlSimTools.jl",
    authors="Jonnie Diegelman",
    assets=String[],
)

deploydocs(;
    repo="github.com/jonniedie/ControlSimTools.jl",
)
