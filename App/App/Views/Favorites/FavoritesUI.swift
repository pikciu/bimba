import UIKit

final class FavoritesUI: View {
    let segmentedControl = UISegmentedControl()
    let tableView = UITableView()
    
    override func setupAutoLayout() {
        add(subviews: segmentedControl, tableView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.UI.defaultSpacing),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.UI.defaultSpacing),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.UI.defaultSpacing),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: Constants.UI.defaultSpacing / 2),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func setupAppearance() {
        backgroundColor = Asset.backgroundColor.color
        tableView.apply(DefaultTableViewStyle())
        segmentedControl.apply(SegmentedControlStyle())
    }
    
    override func localizeInterface() {
        segmentedControl.insertSegment(withTitle: L10n.favorite, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: L10n.nearby, at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
    }
}
