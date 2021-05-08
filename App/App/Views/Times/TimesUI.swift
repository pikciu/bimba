import UIKit

final class TimesUI: View {
    let tableView = UITableView()
    let favoriteButton = UIBarButtonItem()
    
    override func setupAutoLayout() {
        add(subviews: tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    override func setupAppearance() {
        tableView.apply(DefaultTableViewStyle())
        tableView.allowsSelection = false
    }
    
    override func localizeInterface() {
        favoriteButton.accessibilityLabel = L10n.star
    }
}
