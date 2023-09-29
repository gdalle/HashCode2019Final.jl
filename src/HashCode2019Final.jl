module HashCode2019Final

using DataDeps: register, DataDep, @datadep_str

export read_instance, write_instance
export read_solution, write_solution
export download_and_read_instance
export INSTANCES
export CompiledFile, TargetFile, Instance, CompilationStep, Solution

const INSTANCES = [
    "a_example.in",
    "b_narrow.in",
    "c_urgent.in",
    "d_typical.in",
    "e_intriguing.in",
    "f_big.in",
]

include("types.jl")
include("read_write.jl")
include("check.jl")
include("solve.jl")

function __init__()
    return register(
        DataDep(
            # folder name
            "HashCode2019Final",
            # message
            """Instances A through F for the Google HashCode 2019 final round
            Description: https://github.com/google/coding-competitions-archive/blob/main/hashcode/hashcode_2019_final_round.pdf""",
            # URL
            [
                "https://raw.githubusercontent.com/google/coding-competitions-archive/main/hashcode/hashcode_2019_final_round/a_example.in",
                "https://raw.githubusercontent.com/google/coding-competitions-archive/main/hashcode/hashcode_2019_final_round/b_narrow.in",
                "https://raw.githubusercontent.com/google/coding-competitions-archive/main/hashcode/hashcode_2019_final_round/c_urgent.in",
                "https://raw.githubusercontent.com/google/coding-competitions-archive/main/hashcode/hashcode_2019_final_round/d_typical.in",
                "https://raw.githubusercontent.com/google/coding-competitions-archive/main/hashcode/hashcode_2019_final_round/e_intriguing.in",
                "https://raw.githubusercontent.com/google/coding-competitions-archive/main/hashcode/hashcode_2019_final_round/f_big.in",
            ],
        ),
    )
end

end
