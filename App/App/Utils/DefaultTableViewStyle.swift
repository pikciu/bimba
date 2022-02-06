import UIKit
import Domain

struct DefaultTableViewStyle: Decorator {
    
    func apply(on object: UITableView) {
        object.backgroundColor = Asset.backgroundColor.color
        let frame = Constants.UI.spacingViewFrame
        object.tableFooterView = UIView(frame: frame)
        object.tableHeaderView = UIView(frame: frame)
        object.separatorStyle = .none
        object.indicatorStyle = .white
    }
}

