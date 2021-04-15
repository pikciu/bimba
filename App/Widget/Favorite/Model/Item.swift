import Domain

struct Item: Hashable {
    let time: DepartureTime
    let index: Int
    let addSpacing: Bool
    
    static func items(from entry: FavoriteWidgetEntry, count: Int) -> [Item] {
        let lastIndex = count - 1
        return entry.times.prefix(count)
            .enumerated()
            .map({ (offset, element) in
                Item(time: element, index: offset, addSpacing: offset < lastIndex)
            })
    }
}
