func solveOpcode(index: Int, opcodeSequence: [Int]) -> [Int] {

    let opcodeTupleLength = 4

    var opcode = opcodeSequence[index]

    var swapValue: Int = 0

    switch opcode {
        case 1:
            swapValue = opcodeSequence[opcodeSequence[index + 1]] + opcodeSequence[opcodeSequence[index + 2]]
        case 2:
            swapValue = opcodeSequence[opcodeSequence[index + 1]] * opcodeSequence[opcodeSequence[index + 2]]
        case 99:
            // print("Encountered code 99 at index \(index)")
            return opcodeSequence
        default:
            preconditionFailure("Error: Unknown Opcode")
    }
    let swapIndex = opcodeSequence[index + 3]

    var mutableSequence = opcodeSequence
    mutableSequence[swapIndex] = swapValue
    return solveOpcode(index: index + opcodeTupleLength, opcodeSequence: mutableSequence)
}

func calculate(_ noun: Int, _ verb: Int) -> [Int] {
    let opcodeSequence = [1,noun,verb,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,1,6,19,23,2,23,6,27,2,6,27,31,2,13,31,35,1,10,35,39,2,39,13,43,1,43,13,47,1,6,47,51,1,10,51,55,2,55,6,59,1,5,59,63,2,9,63,67,1,6,67,71,2,9,71,75,1,6,75,79,2,79,13,83,1,83,10,87,1,13,87,91,1,91,10,95,2,9,95,99,1,5,99,103,2,10,103,107,1,107,2,111,1,111,5,0,99,2,14,0,0]
    return solveOpcode(index: 0, opcodeSequence: opcodeSequence)
}

func seek(_ value: Int, _ nounLimit: Int, _ verbLimit: Int) -> (Int, Int)  {
    for i in 0...nounLimit {
        for j in 0...verbLimit {
            if (value == calculate(i, j)[0]) {
                return (i, j)
            }
        }
    }
    return (0, 0)
}

func test() {

    let addTestSequence = [1,0,0,0,99]
    let multiplicationTestSequence = [2,3,0,3,99]
    let terminatingSequence = [1,1,1,4,99,5,6,0,99]

    assert(solveOpcode(index: 0, opcodeSequence: addTestSequence) == [2,0,0,0,99])
    assert(solveOpcode(index: 0, opcodeSequence: multiplicationTestSequence) == [2,3,0,6,99])
    assert(solveOpcode(index: 0, opcodeSequence: terminatingSequence) == [30,1,1,4,2,5,6,0,99])

    print("Test Sucessful")
}

test()
print(calculate(12, 2))

let (noun, verb) =  seek(19690720, 99, 99)
print("noun: \(noun), verb: \(verb) answer: \(100 * noun + verb)")
