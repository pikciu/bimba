import UIKit
import Domain

final class StopPointCell: TableViewCell<StopPointDirections> {
    
    override func configure(with model: StopPointDirections) {
        textLabel?.text = model.stopPoint.name
    }
}
