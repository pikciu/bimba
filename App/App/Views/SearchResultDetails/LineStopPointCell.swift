import UIKit
import Domain

final class LineStopPointCell: TableViewCell<StopPoint> {
    
    let rootView = UIView()
    let nameLabel = UILabel()
    
    override func setupAppearance() {
        selectionStyle = .none
        backgroundColor = Asset.backgroundColor.color
        rootView.backgroundColor = .white
        rootView.layer.cornerRadius = Constants.UI.cornerRadius
        
        nameLabel.font = AppFont.titleFont
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
        
        if highlighted {
            rootView.backgroundColor = .lightGray
        } else {
            rootView.backgroundColor = .white
        }
    }
    
    override func configure(with model: StopPoint) {
        nameLabel.text = model.name
    }
}
