import UIKit

final class SearchResultDetailsUI: View {
    let stackView = UIStackView()
    let tableView = UITableView()
    let segmentedControlContainer = UIView()
    let segmentedControl = UISegmentedControl()
    
    override func setupAppearance() {
        segmentedControlContainer.backgroundColor = Asset.backgroundColor.color
        stackView.axis = .vertical
        tableView.apply(DefaultTableViewStyle())
        
        segmentedControl.tintColor = .white
        
        segmentedControl.setTitleTextAttributes([.foregroundColor: Asset.secondaryColor.color], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: Asset.primaryColor.color], for: .selected)
    }
    
    override func setupAutoLayout() {
        stackView.addArrangedSubview(segmentedControlContainer)
        stackView.addArrangedSubview(tableView)
        segmentedControlContainer.add(subviews: segmentedControl)
        add(subviews: stackView)
        
        let spacing = Constants.UI.defaultSpacing
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: segmentedControlContainer.topAnchor, constant: spacing),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlContainer.leadingAnchor, constant: spacing),
            segmentedControl.trailingAnchor.constraint(equalTo: segmentedControlContainer.trailingAnchor, constant: -spacing),
            segmentedControl.bottomAnchor.constraint(equalTo: segmentedControlContainer.bottomAnchor, constant: -spacing / 2)
        ])
    }
}
