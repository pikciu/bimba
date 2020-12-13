//
//  ToggleFavorite.swift
//  Domain
//
//  Created by Tomasz Pikć on 13/12/2020.
//

import Foundation
import Foundation
import RxSwift

struct ToggleFavorite: UseCase {
    @Inject
    private var repository: StopPointLocalRepository
    
    let id: String
    
    func execute() -> Completable {
        StopPointIsFavorite(id: id)
            .execute()
            .take(1)
            .asSingle()
            .flatMapCompletable({ (isFavorite) in
                if isFavorite {
                    return repository.removeFavorite(stopPointID: id)
                } else {
                    return repository.addFavorite(stopPointID: id)
                }
            })
    }
}
