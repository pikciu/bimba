import UIKit
import Domain

final class SearchResultCell: TableViewCell<SearchResult> {
    
    override func configure(with model: SearchResult) {
        textLabel?.text = model.text
    }
}

extension SearchResult {
    var text: String {
        switch self {
        case .line(let line):
            return line
        case .street(let street):
            return street.name
        case .stopPoint(let stopPoint):
            return stopPoint.name
        }
    }
}
