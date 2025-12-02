import Algorithms

struct Day02: AdventDay {
    let idRanges: [ClosedRange<Int>]
    
    init(data: String) {
        idRanges = data.trimmingCharacters(in: .newlines).split(separator: ",").map { range in
            let parts = range.split(separator: "-").map { Int($0)! }
            return parts[0]...parts[1]
        }
    }
    
    private func isInvalid1(_ id: Int) -> Bool {
        let digits = String(id)
        let mid = digits.index(digits.startIndex, offsetBy: digits.count/2)
        let firstHalf = digits[..<mid]
        let secondHalf = digits[mid...]
        return firstHalf == secondHalf
    }
    
    func part1() -> Any {
        var answer = 0
        for range in idRanges {
            for id in range {
                if isInvalid1(id) {
                    answer += id
                }
            }
        }
        return answer
    }

    private func isInvalid2(_ id: Int) -> Bool {
        let digits = String(id)
        for patLen in 1..<digits.count {
            let parts = digits.chunks(ofCount: patLen)
            if parts.count > 1 && parts.allSatisfy({ parts.first == $0 }) {
                return true
            }
        }
        return false
    }
    
    func part2() -> Any {
        var answer = 0
        for range in idRanges {
            for id in range {
                if isInvalid2(id) {
                    answer += id
                }
            }
        }
        return answer
    }
}
