struct Day06: AdventDay {
    struct Puzzle {
        var values: [Int] = []
        var rvalues: [Int] = []
        var op: String = ""
    }
    var puzzles: [Puzzle] = []
    
    init(data: String) {
        let grid = Grid(data)
        let opRow = grid.height-1
        var startCol = 0
        while startCol < grid.width {
            var nextCol = grid.width
            for col in startCol..<grid.width {
                if grid.isBlankColumn(col) {
                    nextCol = col
                    break
                }
            }
            let pGrid = grid.subgrid(x: startCol, y: 0, width: nextCol-startCol, height: grid.height-1)
            var puzzle = Puzzle(op: grid[startCol, opRow]!)
            for y in 0..<pGrid.height {
                let sValue = pGrid.rowValues(for: y).joined(separator: "").trimmingCharacters(in: .whitespaces)
                puzzle.values.append(Int(sValue) ?? 0)
            }
            for x in 0..<pGrid.width {
                let sValue = pGrid.colValues(for: x).joined(separator: "").trimmingCharacters(in: .whitespaces)
                puzzle.rvalues.append(Int(sValue) ?? 0)
            }
            puzzles.append(puzzle)
            startCol = nextCol + 1
            
        }
    }
    
    func part1() -> Any {
        var answer = 0
        for puzzle in puzzles {
            switch puzzle.op {
            case "+":
                answer += puzzle.values.reduce(0) { $0 + $1 }
            case "*":
                answer += puzzle.values.reduce(1) { $0 * $1 }
            default:
                fatalError("Unexpected op: \(puzzle.op)")
            }
        }
        return answer
    }
    
    func part2() -> Any {
        var answer = 0
        for puzzle in puzzles {
            switch puzzle.op {
            case "+":
                answer += puzzle.rvalues.reduce(0) { $0 + $1 }
            case "*":
                answer += puzzle.rvalues.reduce(1) { $0 * $1 }
            default:
                fatalError("Unexpected op: \(puzzle.op)")
            }
        }
        return answer
    }
}

extension Grid {
    func isBlankColumn(_ col: Int) -> Bool {
        colValues(for: col).allSatisfy { $0 == " "}
    }
    
    func colValues(for x: Int) -> [String] {
        var values: [String] = []
        for y in 0..<height {
            values.append(self[x, y]!)
        }
        return values
    }

    func rowValues(for y: Int) -> [String] {
        var values: [String] = []
        for x in 0..<width {
            values.append(self[x, y]!)
        }
        return values
    }
}
