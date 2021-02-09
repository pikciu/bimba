import Domain

struct DepartureTimeFactory {
    
    static func create() -> DepartureTime {
        let lines = ["2", "5", "9", "16", "18"]
        let direction = ["Górczyn", "Dębiec", "Franowo"]
        let minute = Int.random(in: 0..<10)
        
        return DepartureTime(
            departure: Date().byAdding(value: minute, component: .minute),
            direction: direction.shuffled().first ?? "",
            line: lines.shuffled().first ?? "",
            minutesToDeparture: minute,
            isOnStopPoint: false,
            isRealTime: true
        )
    }
    
    static func create(count: Int) -> [DepartureTime] {
        let range = 0..<count
        return range.map { _ in create() }
    }
}
