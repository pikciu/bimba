import UIKit
import Domain

final class StopPointCell: TableViewCell<StopPointDirections> {
    
    let rootView = RoundedRectView()
    let nameLabel = UILabel()
    let directionsLabel = UILabel()
    
    override func setupAppearance() {
        selectionStyle = .none
        backgroundColor = Asset.backgroundColor.color
        
        nameLabel.font = AppFont.titleFont
        directionsLabel.font = AppFont.subtitleFont
        
        nameLabel.textColor = Asset.primaryColor.color
        directionsLabel.textColor = Asset.primaryColor.color
        
        nameLabel.numberOfLines = 0
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
        rootView.setSelected(highlighted, animated: true)
    }
    
    override func configure(with model: StopPointDirections) {
        nameLabel.text = model.stopPoint.name
        directionsLabel.attributedText = model.directions.map(attributedString(direction:)).joined(with: "\n")
    }
    
    private func attributedString(direction: Direction) -> NSAttributedString {
        let string = NSMutableAttributedString(
            string: direction.line,
            attributes: [
                .font : AppFont.regular(size: .small)
            ]
        )
        
        let directionString = NSAttributedString(
            string: "\(Constants.noBreakChar)\(Constants.directionArrow)\(Constants.noBreakChar)\(direction.name)",
            attributes: [
                .font : AppFont.light(size: .small),
                .foregroundColor : Asset.secondaryColor.color
            ]
        )
        string.append(directionString)
        return string
    }
}
