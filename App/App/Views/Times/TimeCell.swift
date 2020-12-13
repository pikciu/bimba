import UIKit
import Domain

final class TimeCell: TableViewCell<DepartureTime> {
    
    let lineLabel = UILabel()
    let directionLabel = UILabel()
    let minutesLabel = UILabel()
    let departureTimeLabel = UILabel()
    let rootView = UIView()
    
    override func setupAppearance() {
        backgroundColor = Asset.backgroundColor.color
        rootView.backgroundColor = .white
        
        lineLabel.textAlignment = .center
        
        lineLabel.font = AppFont.heavy(size: .big)
        directionLabel.font = AppFont.titleFont
        minutesLabel.font = AppFont.titleFont
        departureTimeLabel.font = AppFont.subtitleFont
        
        rootView.layer.cornerRadius = Constants.UI.cornerRadius
    }
    
    override func setupAutoLayout() {
        contentView.add(subviews: rootView)
        rootView.add(subviews: lineLabel, directionLabel, minutesLabel, departureTimeLabel)
        
        let spacing = Constants.UI.defaultSpacing
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing / 2),
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing / 2),
            
            lineLabel.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            lineLabel.topAnchor.constraint(equalTo: rootView.topAnchor, constant: spacing),
            lineLabel.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -spacing),
            lineLabel.widthAnchor.constraint(equalToConstant: 80),
            
            directionLabel.leadingAnchor.constraint(equalTo: lineLabel.trailingAnchor),
            directionLabel.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            
            minutesLabel.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -spacing),
            minutesLabel.bottomAnchor.constraint(equalTo: rootView.centerYAnchor),
            
            departureTimeLabel.trailingAnchor.constraint(equalTo: minutesLabel.trailingAnchor),
            departureTimeLabel.topAnchor.constraint(equalTo: rootView.centerYAnchor)
        ])
    }
    
    override func configure(with model: DepartureTime) {
        lineLabel.text = model.line
        directionLabel.text = model.direction
        minutesLabel.text = String(model.minutesToDeparture)
        departureTimeLabel.text = DateTimeFormatter.current.string(from: model.departure, dateFormat: "H:mm")
    }
}
