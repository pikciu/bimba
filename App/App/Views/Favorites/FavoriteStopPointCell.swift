import UIKit
import Domain

final class FavoriteStopPointCell: TableViewCell<StopPointDetails> {
    
    override func configure(with model: StopPointDetails) {
        textLabel?.text = model.name
    }
}
