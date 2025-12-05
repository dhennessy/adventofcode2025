struct Day05: AdventDay {
    let freshRanges: [ClosedRange<Int>]
    let ingredients: [Int]
    
    init(data: String) {
        let sections = data.split(separator: "\n\n")
        freshRanges = sections[0].split(separator: "\n").map { line in
            let parts = line.split(separator: "-").map { Int($0)! }
            return parts[0]...parts[1]
        }
        ingredients = sections[1].split(separator: "\n").map { Int($0)! }
    }
    
    func part1() -> Any {
        var answer = 0
        for ingredient in ingredients {
            for range in freshRanges {
                if range.contains(ingredient) {
                    answer += 1
                    break
                }
            }
        }
        return answer
    }
    
    func part2() -> Any {
        var distinctRanges: [ClosedRange<Int>] = []
        for range in freshRanges {
            distinctRanges.append(range)
            distinctRanges.sort(by: { $0.lowerBound < $1.lowerBound })
            while true {
                var foundOne = false
                for i in 0..<distinctRanges.count - 1 {
                    let left = distinctRanges[i]
                    let right = distinctRanges[i + 1]
                    if left.upperBound >= right.lowerBound {
                        distinctRanges.remove(at: i + 1)
                        distinctRanges[i] = left.lowerBound...max(left.upperBound, right.upperBound)
                        foundOne = true
                        break
                    }
                }
                if !foundOne {
                    break
                }
            }
        }
        return distinctRanges.reduce(0) { $0 + $1.count }
    }
}
