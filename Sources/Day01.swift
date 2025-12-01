struct Day01: AdventDay {
    let turns: [Int]
    
    init(data: String) {
        turns = data.split(separator: "\n").map { line in
            let dir = line.hasPrefix("L") ? -1 : 1
            let val = Int(line.dropFirst().description) ?? 0
            return dir * val
        }
    }
    
    func part1() -> Any {
        var pos = 50
        var count = 0
        for turn in turns {
            pos = (pos + turn) % 100
            if pos == 0 {
                count += 1
            }
        }
        return count
    }
    
    func part2() -> Any {
        var pos = 50
        var count = 0
        for turn in turns {
            let opos = pos
            pos = pos + turn
            var pass = pos / 100
            if pos < 0 {
                pass = -pass
                if opos != 0 {
                    pass += 1
                }
                pos = (pos + (pass + 1) * 100) % 100
            }
            pos %= 100
            count += pass
            if pos == 0 && pass == 0 {
                count += 1
            }
        }
        return count
    }
}
