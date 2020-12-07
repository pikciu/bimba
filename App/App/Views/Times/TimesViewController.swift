import UIKit
import Domain
import RxSwift
import RxCocoa

final class TimesViewController: ViewController<TimesUI>, TimesView {

    private lazy var presenter = TimesPresenter(view: self)
    
    let stopPoint: StopPointType
    
    init(stopPoint: StopPointType) {
        self.stopPoint = stopPoint
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = stopPoint.name
        
        presenter.loadTimes()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
