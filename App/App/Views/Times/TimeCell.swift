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
        
        lineLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        directionLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        minutesLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        departureTimeLabel.font = .systemFont(ofSize: 12)
        
        rootView.layer.cornerRadius = 8
    }
    
    override func setupAutoLayout() {
        contentView.add(subviews: rootView)
        rootView.add(subviews: lineLabel, directionLabel, minutesLabel, departureTimeLabel)
        
        let spacing = CGFloat(12)
        
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
