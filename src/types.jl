@kwdef struct CompiledFile
    name::String
    c::Int
    r::Int
    dependencies::Vector{String}
end

@kwdef struct TargetFile
    name::String
    d::Int
    g::Int
end

@kwdef struct Instance
    S::Int
    compiled_files::Vector{CompiledFile}
    target_files::Vector{TargetFile}
end

@kwdef struct CompilationStep
    name::String
    s::Int
end

const Solution = Vector{CompilationStep}
