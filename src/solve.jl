function trivial_solution(instance::Instance)
    solution = [CompilationStep(cf.name, 1) for cf in instance.compiled_files]
    return solution
end
