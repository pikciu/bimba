import UIKit
import Domain
import RxSwift
import RxCocoa

final class SearchViewController: ViewController<SearchUI>, SearchView {

    private lazy var presenter = SearchPresenter(view: self)
    private let searchController = UISearchController(searchResultsController: nil)
    
    var results: AnyObserver<[SearchResult]> {
        ui.tableView.rx.cells(type: SearchResultCell.self).disposed(by: disposeBag)
    }
    
    var searchQuery: Observable<String> {
        searchController.searchBar.rx.text.filterNil()
    }
    
    var isBusy: AnyObserver<Bool> {
        ui.tableView.apply(FooterLoader()).asObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.initialize()
        
        ui.tableView.register(cellType: SearchResultCell.self)
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.apply(SearchBarStyle())
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        ui.tableView.rx.modelSelected(SearchResult.self)
            .subscribe(with: self, onNext: { (context, searchResult) in
                context.showDetails(searchResult: searchResult)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchController.searchBar.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchController.searchBar.placeholderLabel?.textColor = Asset.secondaryColor.color.withAlphaComponent(0.5)
    }
    
    private func showDetails(searchResult: SearchResult) {
        let searchResultDetailsViewController = SearchResultDetailsViewController(searchResult: searchResult)
        show(searchResultDetailsViewController, sender: nil)
    }
}

extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        } else {
            return value(forKey: "searchField") as? UITextField
        }
    }
    
    var placeholderLabel: UILabel? {
        textField?.value(forKey: "placeholderLabel") as? UILabel
    }
    
    var clearButton: UIButton? {
        textField?.value(forKey: "_clearButton") as? UIButton
    }
}


struct SearchBarStyle: Decorator {
    
    func apply(on object: UISearchBar) {
        object.apply(AppNavigationStyle())
        object.searchBarStyle = .minimal
        object.backgroundImage = UIImage(color: .clear)
        object.scopeBarBackgroundImage = UIImage(color: .clear)
    }
}
