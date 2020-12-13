import UIKit
import Domain

final class StopPointCell: TableViewCell<StopPointDirections> {
    
    let rootView = UIView()
    let nameLabel = UILabel()
    let directionsLabel = UILabel()
    
    override func setupAppearance() {
        selectionStyle = .none
        backgroundColor = Asset.backgroundColor.color
        rootView.backgroundColor = .white
        rootView.layer.cornerRadius = Constants.UI.cornerRadius
        
        nameLabel.font = AppFont.titleFont
        directionsLabel.font = AppFont.subtitleFont
        
        directionsLabel.numberOfLines = 0
    }
    
    override func setupAutoLayout() {
        contentView.add(subviews: rootView)
        rootView.add(subviews: nameLabel, directionsLabel)
        
        let spacing = Constants.UI.defaultSpacing
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing / 2),
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing / 2),
            
            nameLabel.topAnchor.constraint(equalTo: rootView.topAnchor, constant: spacing),
            nameLabel.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: spacing),
            nameLabel.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -spacing),
            
            directionsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            directionsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            directionsLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            directionsLabel.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -spacing)
        ])
    }
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            rootView.backgroundColor = .lightGray
        } else {
            rootView.backgroundColor = .white
        }
    }
    
    override func configure(with model: StopPointDirections) {
        nameLabel.text = model.stopPoint.name
        directionsLabel.text = model.directions.map({ (direction) -> String in
            "\(direction.line) -> \(direction.name)"
        }).joined(separator: "\n")
    }
}
