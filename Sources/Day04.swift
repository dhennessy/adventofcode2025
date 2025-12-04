struct Day04: AdventDay {
    let grid: Grid
    let moves: [(Int, Int)] = [(-1, 0), (0, -1), (1, 0), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)]
    
    init(data: String) {
        grid = Grid(data)
    }
    
    func movable(_ grid: Grid) -> [(Int, Int)] {
        var answer: [(Int, Int)] = []
        
        for y in 0..<grid.width {
            for x in 0..<grid.width {
                if grid[x, y] != "@" {
                    continue
                }
                var rolls = 0
                for (dx, dy) in moves {
                    if grid[x + dx, y + dy] == "@" {
                        rolls += 1
                    }
                }
                if rolls < 4 {
                    answer.append((x, y))
                }
            }
        }
        return answer
    }
    
    func part1() -> Any {
        movable(grid).count
    }
    
    func part2() -> Any {
        var answer = 0
        var grid = self.grid
        while true {
            let rolls = movable(grid)
            if rolls.isEmpty {
                break
            }
            for (x, y) in rolls {
                grid[x, y] = "."
                answer += 1
            }
        }
        return answer
    }
}
