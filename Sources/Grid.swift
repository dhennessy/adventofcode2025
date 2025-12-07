import Foundation

struct Grid {
    var storage: [[String]] = []
    var width: Int
    var height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        storage = Array(repeating: Array(repeating: "", count: width), count: height)
    }
    
    init(_ data: String) {
        width = 0
        height = 0
        storage = data.split(separator: "\n").map {
            width = $0.count
            return $0.map { String($0) }
        }
        height = storage.count
    }
    
    func find(_ value: String) -> (Int, Int)? {
        for (y, row) in storage.enumerated() {
            if let x = row.firstIndex(of: value) {
                return (x, y)
            }
        }
        return nil
    }

    func indexIsValid(y: Int, x: Int) -> Bool {
        x >= 0 && x < width && y >= 0 && y < height
    }
    
    func subgrid(x: Int, y: Int, width: Int, height: Int) -> Grid {
        var g = Grid(width: width, height: height)
        for dx in 0..<width {
            for dy in 0..<height {
                g[dx, dy] = self[x+dx, y+dy]
            }
        }
        return g
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
