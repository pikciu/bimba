import UIKit

final class SearchUI: View {
    let tableView = UITableView()
    
    override func setupAutoLayout() {
        add(subviews: tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func setupAppearance() {
        backgroundColor = Asset.backgroundColor.color
        tableView.backgroundColor = Asset.backgroundColor.color
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.keyboardDismissMode = .interactive
    }
}
