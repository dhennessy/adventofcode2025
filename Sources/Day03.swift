struct Day03: AdventDay {
    let banks: [String]
    
    init(data: String) {
        banks = data.split(separator: "\n").map { String($0) }
    }
    
    func compute(bank: String, count: Int) -> Int {
        let bankJolts: [Int] = bank.compactMap({ Int(String($0)) })
        var answer = 0
        var left = 0
        var right = bankJolts.count - count
        for _ in 0..<count {
            let slice = bankJolts[left...right]
            let maxVal = slice.max()!
            let iMax = slice.firstIndex(of: maxVal)!
            answer = answer*10 + maxVal
            left = iMax + 1
            right += 1
        }
        return answer
    }
    
    func part1() -> Any {
        var answer = 0
        for bank in banks {
            answer += compute(bank: bank, count: 2)
        }
        return answer
    }
    
    func part2() -> Any {
        var answer = 0
        for bank in banks {
            answer += compute(bank: bank, count: 12)
        }
        return answer
    }
}
