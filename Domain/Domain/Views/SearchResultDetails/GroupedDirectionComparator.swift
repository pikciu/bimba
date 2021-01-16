import Foundation

struct GroupedDirectionComparator {
    
    func compare(lhs: Direction, rhs: Direction) -> Bool {
        let lLines = lines(direction: lhs)
        let rLines = lines(direction: rhs)
        
        for (l, r) in zip(lLines, rLines) {
            if l < r {
                return true
            }
        }
        return lhs.line < rhs.line
    }
    
    private func lines(direction: Direction) -> [Int] {
        direction.line.split(separator: ",")
            .compactMap({ Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) })
    }
}
