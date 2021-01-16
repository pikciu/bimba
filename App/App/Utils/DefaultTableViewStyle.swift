import UIKit
import Domain

struct DefaultTableViewStyle: Decorator {
    
    func apply(on object: UITableView) {
        object.backgroundColor = Asset.backgroundColor.color
        let size = CGSize(width: 0, height: Constants.UI.defaultSpacing / 2)
        let frame = CGRect(origin: .zero, size: size)
        object.tableFooterView = UIView(frame: frame)
        object.tableHeaderView = UIView(frame: frame)
        object.separatorStyle = .none
    }
}

