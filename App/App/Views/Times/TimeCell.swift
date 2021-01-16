import UIKit
import Domain

final class TimeCell: TableViewCell<DepartureTime> {
    
    let lineLabel = UILabel()
    let directionLabel = UILabel()
    let minutesLabel = UILabel()
    let departureTimeLabel = UILabel()
    let rootView = RoundedRectView()
    
    override func setupAppearance() {
        backgroundColor = Asset.backgroundColor.color
        
        lineLabel.textAlignment = .center
        
        lineLabel.font = AppFont.heavy(size: .big)
        directionLabel.font = AppFont.titleFont
        minutesLabel.font = AppFont.titleFont
        departureTimeLabel.font = AppFont.subtitleFont
        
        lineLabel.textColor = Asset.primaryColor.color
        directionLabel.textColor = Asset.secondaryColor.color
        departureTimeLabel.textColor = Asset.secondaryColor.color
        
        directionLabel.numberOfLines = 0
    }
    
    override func setupAutoLayout() {
        contentView.add(subviews: rootView)
        rootView.add(subviews: lineLabel, directionLabel, minutesLabel, departureTimeLabel)
        
        let spacing = Constants.UI.defaultSpacing
        
        directionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        directionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        minutesLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        minutesLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing / 2),
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing / 2),
            
            lineLabel.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            lineLabel.topAnchor.constraint(equalTo: rootView.topAnchor, constant: Constants.UI.systemSpacing),
            lineLabel.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -Constants.UI.systemSpacing),
            lineLabel.widthAnchor.constraint(equalToConstant: 110),
            
            directionLabel.leadingAnchor.constraint(equalTo: lineLabel.trailingAnchor),
            directionLabel.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            
            minutesLabel.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -spacing),
            minutesLabel.bottomAnchor.constraint(equalTo: rootView.centerYAnchor),
            minutesLabel.leadingAnchor.constraint(equalTo: directionLabel.trailingAnchor, constant: Constants.UI.systemSpacing),
            
            departureTimeLabel.trailingAnchor.constraint(equalTo: minutesLabel.trailingAnchor),
            departureTimeLabel.topAnchor.constraint(equalTo: rootView.centerYAnchor, constant: 2)
        ])
    }
    
    override func configure(with model: DepartureTime) {
        lineLabel.text = model.line
        directionLabel.text = model.direction
        if model.isOnStopPoint {
            minutesLabel.text = L10n.isDrivingAway
        } else {
            minutesLabel.text = L10n.minutesFormat(model.minutesToDeparture)
        }
        if model.minutesToDeparture < 3 {
            minutesLabel.textColor = Asset.alertColor.color
        } else {
            minutesLabel.textColor = Asset.primaryColor.color
        }
        departureTimeLabel.text = DateTimeFormatter.current.string(from: model.departure, dateFormat: "H:mm")
    }
}
