import UIKit
import Domain
import RxSwift
import RxCocoa

final class SearchViewController: ViewController<SearchUI>, SearchView {

    private lazy var presenter = SearchPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
