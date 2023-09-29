using DataDeps
using HashCode2019Final
using Test

ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"

@testset "HashCode2019Final.jl" begin
    for instance_name in INSTANCES[1:5]
        @info instance_name

        instance = download_and_read_instance(instance_name)
        instance_str = String(instance)
        instance_partial_path = "HashCode2019Final/$instance_name"
        instance_path = @datadep_str instance_partial_path
        instance_str_ref = open(instance_path, "r") do f
            read(f, String)
        end
        @test instance_str == instance_str_ref
    end
end
