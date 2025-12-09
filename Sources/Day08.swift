import Foundation

struct Day08: AdventDay {
    struct Position: Hashable {
        let x: Int
        let y: Int
        let z: Int
    }
    var boxes: [Position]
    struct Connection {
        let a: Position
        let b: Position
        let distance: Int
    }
    var connections: [Connection] = []

    init(data: String) {
        boxes = data.split(separator: "\n").map { line in
            let coords = line.split(separator: ",")
            return Position(x: Int(coords[0])!, y: Int(coords[1])!, z: Int(coords[2])!)
        }
        for i in 0..<(boxes.count-1) {
            for j in (i+1)..<boxes.count {
                let dx = boxes[i].x - boxes[j].x
                let dy = boxes[i].y - boxes[j].y
                let dz = boxes[i].z - boxes[j].z
                let distance = dx*dx + dy*dy + dz*dz
                let c = Connection(a: boxes[i], b: boxes[j], distance: distance)
                connections.append(c)
            }
        }
        connections.sort(by: { $0.distance < $1.distance })
    }
    
    func part1() -> Any {
        var circuits: [Set<Position>] = []
        let connectionLimit = (boxes.count == 20 ? 10 : 1000)
        for i in 0..<connectionLimit {
            let connection = connections[i]
            let indexA = circuits.firstIndex(where: { $0.contains(connection.a) })
            let indexB = circuits.firstIndex(where: { $0.contains(connection.b) })
            if indexA == nil && indexB == nil {
                circuits.append([connection.a, connection.b])
            } else if let indexA, indexB == nil {
                circuits[indexA].insert(connection.b)
            } else if let indexB, indexA == nil {
                circuits[indexB].insert(connection.a)
            } else if let indexA, let indexB, indexA != indexB {
                circuits[indexA].formUnion(circuits[indexB])
                circuits.remove(at: indexB)
            }
        }
        
        circuits.sort(by: { $0.count > $1.count })
        return circuits[0].count * circuits[1].count * circuits[2].count
    }
    
    func part2() -> Any {
        var seq: [Position] = []
        for c in connections {
            if !seq.contains(c.a) {
                seq.append(c.a)
            }
            if !seq.contains(c.b) {
                seq.append(c.b)
            }
            if seq.count == boxes.count {
                return c.a.x * c.b.x
            }
        }
        fatalError()
    }
}
