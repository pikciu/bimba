import UIKit
import Domain

final class SearchResultCell: TableViewCell<SearchResult> {
    
    let rootView = UIView()
    let nameLabel = UILabel()
    let iconView = UIImageView()
    
    override func setupAppearance() {
        selectionStyle = .none
        backgroundColor = Asset.backgroundColor.color
        rootView.backgroundColor = .white
        rootView.layer.cornerRadius = Constants.UI.cornerRadius
        
        nameLabel.font = AppFont.titleFont
        iconView.contentMode = .center
    }
    
    override func setupAutoLayout() {
        contentView.add(subviews: rootView)
        rootView.add(subviews: iconView, nameLabel)
        
        let spacing = Constants.UI.defaultSpacing
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing / 2),
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing / 2),
            
            iconView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            iconView.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: rootView.topAnchor, constant: spacing),
            nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor),
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
    
    override func configure(with model: SearchResult) {
        nameLabel.text = model.text
        iconView.image = model.image
    }
}

extension SearchResult {
    var text: String {
        switch self {
        case .line(let line):
            return line
        case .street(let street):
            return street.name
        case .stopPoint(let stopPoint):
            return stopPoint.name
        }
    }
    
    var image: UIImage {
        switch self {
        case .line:
            return Asset.tram.image
        case .stopPoint:
            return Asset.stopPoint.image
        case .street:
            return Asset.street.image
        }
    }
}
