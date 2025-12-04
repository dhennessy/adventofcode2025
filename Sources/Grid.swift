import Foundation

struct Grid {
    var storage: [[String]] = []
    var width: Int
    var height: Int
    
    init(_ data: String) {
        width = 0
        height = 0
        storage = data.split(separator: "\n").map {
            width = $0.count
            return $0.map { String($0) }
        }
        height = storage.count
    }
    
    func indexIsValid(y: Int, x: Int) -> Bool {
        x >= 0 && x < width && y >= 0 && y < height
    }
    
    subscript(x: Int, y: Int) -> String? {
        get {
            guard indexIsValid(y: y, x: x) else { return nil }
            return storage[y][x]
        }
        set {
            assert(indexIsValid(y: y, x: x), "Index out of range")
            storage[y][x] = newValue!
        }
    }
}
