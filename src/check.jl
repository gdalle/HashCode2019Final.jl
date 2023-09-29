function score(solution::Solution, instance::Instance)
    (; S, compiled_files, target_files) = instance
    C, T = length(compiled_files), length(target_files)

    compilation_times = Dict{String,Int}()
    availability_times = Dict{Tuple{String,Int},Int}()
    server_current_times = zeros(Int, S)

    for compilation_step in solution.compilation_steps
        (; name, s) = compilation_step
        compiled_file = only(filter(cf -> cf.name == name, compiled_files))
        (; c, r, dependencies) = compiled_file
        t_deps = maximum(
            get(availability_times, (dep_name, s), typemax(Int)) for
            dep_name in dependencies
        )
        if t_deps == typemax(Int)
            @warn "File $name cannot be compiled because a dependency is missing"
            return Inf
        else
            t_server = server_current_times[s]
            t = max(t_deps, t_server)
            compilation_times[name] = t + c
            server_current_times[s] = t + c
            availability_times[name, s] = t + c
            for other_s in 1:S
                if other_s != s
                    availability_times[name, other_s] = t + c + r
                end
            end
        end
    end

    total_score = 0
    for target_file in target_files
        (; name, d, g) = target_file
        t = compilation_times[name]
        if t <= d
            total_score += g + (d - t)
        end
    end

    return total_score
end
