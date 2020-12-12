import UIKit
import Domain

final class LineStopPointCell: TableViewCell<StopPoint> {
    
    override func configure(with model: StopPoint) {
        textLabel?.text = model.name
    }
}
