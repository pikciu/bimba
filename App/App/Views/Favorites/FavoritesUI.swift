import UIKit

final class FavoritesUI: View {
    let tableView = UITableView()
    
    override func setupAutoLayout() {
        add(subviews: tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func setupAppearance() {
        backgroundColor = Asset.backgroundColor.color
        tableView.backgroundColor = Asset.backgroundColor.color
        tableView.tableFooterView = UIView()
    }
}
