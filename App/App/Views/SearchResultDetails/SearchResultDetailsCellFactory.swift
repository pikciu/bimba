import UIKit
import RxCells
import Domain

struct SearchResultDetailsCellFactory: TableViewCellFactory {
    
    func create(tableView: UITableView, indexPath: IndexPath, model: SearchResultDetailsPresenter.Item) -> UITableViewCell {
        switch model {
        case .lineStopPoint(let stopPoint):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LineStopPointCell.self)
            cell.configure(with: stopPoint)
            return cell
        case .stopPoint(let stopPoint):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: StopPointCell.self)
            cell.configure(with: stopPoint)
            return cell
        }
    }
}
