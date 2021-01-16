import Foundation

struct GroupByDirectionName: Mapper {
    
    func map(from object: StopPointDirections) -> StopPointDirections {
        let directions = Dictionary(grouping: object.directions) { $0.name }
            .map({ (name, directions) -> Direction in
                let lines = directions.map({ $0.line }).joined(separator: ", ")
                return Direction(name: name, line: lines)
            })
            .sorted(by: GroupedDirectionComparator().compare(lhs:rhs:))
        return StopPointDirections(stopPoint: object.stopPoint, directions: directions)
    }
}
