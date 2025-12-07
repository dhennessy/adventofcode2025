struct Day07: AdventDay {
    let grid: Grid
    
    init(data: String) {
        grid = Grid(data)
    }
    
    func part1() -> Any {
        let start = grid.find("S")!
        var beams: Set<Int> = [start.0]
        var splits = 0
        for row in 1..<grid.height {
            for x in 0..<grid.width {
                if beams.contains(x) {
                    if grid[x, row] == "^" {
                        splits += 1
                        beams.remove(x)
                        if x > 0 {
                            beams.insert(x - 1)
                        }
                        if x < grid.width-1 {
                            beams.insert(x + 1)
                        }
                    }
                }
            }
        }
        
        return splits
    }
    
    func part2() -> Any {
        let start = grid.find("S")!
        var beams: [Int: Int] = [start.0: 1]
        for row in 1..<grid.height {
            for x in 0..<grid.width {
                if let parent = beams[x] {
                    if grid[x, row] == "^" {
                        beams[x] = nil
                        if x > 0 {
                            if let existing = beams[x-1] {
                                beams[x-1] = existing + parent
                            } else {
                                beams[x-1] = parent
                            }
                        }
                        if x < grid.width-1 {
                            if let existing = beams[x+1] {
                                beams[x+1] = existing + parent
                            } else {
                                beams[x+1] = parent
                            }
                        }
                    }
                }
            }
        }
        
        return beams.values.reduce(0) { $0 + $1 }
    }
}
