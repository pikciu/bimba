import UIKit
import Domain
import RxSwift
import RxCocoa

final class TimesViewController: ViewController<TimesUI>, TimesView {

    private lazy var presenter = TimesPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
