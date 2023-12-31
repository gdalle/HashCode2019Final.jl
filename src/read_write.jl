function download_and_read_instance(instance_name::String)
    name = "HashCode2019Final/$instance_name"
    path = @datadep_str name
    return read_instance(path)
end

function read_instance(path::String)
    lines = open(path, "r") do f
        split.(readlines(f))
    end

    k = 1
    l = lines[k]
    C = parse(Int, l[1])
    T = parse(Int, l[2])
    S = parse(Int, l[3])

    compiled_files = Vector{CompiledFile}(undef, C)
    target_files = Vector{TargetFile}(undef, T)

    for i in 1:C
        k += 1
        l = lines[k]
        name = l[1]
        c = parse(Int, l[2])
        r = parse(Int, l[3])

        k += 1
        l = lines[k]
        n = parse(Int, l[1])
        dependencies = l[2:end]

        compiled_file = CompiledFile(name, c, r, dependencies)
        compiled_files[i] = compiled_file
    end

    for i in 1:T
        k += 1
        l = lines[k]
        name = l[1]
        d = parse(Int, l[2])
        g = parse(Int, l[3])

        target_file = TargetFile(name, d, g)
        target_files[i] = target_file
    end

    instance = Instance(S, compiled_files, target_files)
    return instance
end

function Base.String(instance::Instance)
    C = length(instance.compiled_files)
    T = length(instance.target_files)
    s = "$C $T $(instance.S)"
    for i in 1:C
        compiled_file = instance.compiled_files[i]
        (; name, c, r, dependencies) = compiled_file
        n = length(dependencies)
        if n > 0
            dependencies_joined = join(dependencies, " ")
            s *= "\n$name $c $r\n$n $dependencies_joined"
        else
            s *= "\n$name $c $r\n$n"
        end
    end
    for i in 1:T
        target_file = instance.target_files[i]
        (; name, d, g) = target_file
        s *= "\n$name $d $g"
    end
    s *= "\n"
    return s
end

function write_instance(path::String, instance::Instance)
    s = String(instance)
    open(path, "w") do f
        write(f, s)
    end
end

function read_solution(path::String, solution)
    lines = open(path, "r") do f
        split.(readlines(f))
    end

    l = lines[1]
    E = parse(Int, l[1])

    solution = Vector{CompilationStep}(undef, E)

    for i in 1:E
        l = lines[1 + i]
        name = l[1]
        s = parse(Int, l[2]) + 1  # 0-indexing
        cs = CompilationStep(name, s)
        solution[i] = cs
    end

    return solution
end

function Base.String(solution::Solution)
    E = length(solution)
    s = string(E)
    for i in 1:E
        cs = solution[i]
        s *= "\n$(cs.name) $(cs.s - 1)"  # 0-indexing
    end
    s *= "\n"
    return s
end

function write_solution(path::String, solution::Solution)
    s = String(solution)
    open(path, "w") do f
        write(f, s)
    end
end
