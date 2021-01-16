import UIKit
import Domain

final class LineStopPointCell: TableViewCell<StopPoint> {
    
    let rootView = RoundedRectView()
    let nameLabel = UILabel()
    
    override func setupAppearance() {
        selectionStyle = .none
        backgroundColor = Asset.backgroundColor.color
        
        nameLabel.font = AppFont.titleFont
        nameLabel.textColor = Asset.primaryColor.color
    }
    
    override func setupAutoLayout() {
        contentView.add(subviews: rootView)
        rootView.add(subviews: nameLabel)
        
        let spacing = Constants.UI.defaultSpacing
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing / 2),
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing / 2),
            
            nameLabel.topAnchor.constraint(equalTo: rootView.topAnchor, constant: spacing),
            nameLabel.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: spacing),
            nameLabel.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -spacing),
        ])
    }
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        rootView.setSelected(highlighted, animated: true)
    }
    
    override func configure(with model: StopPoint) {
        nameLabel.text = model.name
    }
}
