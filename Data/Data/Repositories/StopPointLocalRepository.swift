import Foundation
import Domain
import RxSwift
import RxRealm

struct StopPointLocalRepository: Domain.StopPointLocalRepository {
    @Inject
    private var context: RealmContext
    
    func saveStopPoints(stopPoints: [StopPointDetails]) -> Completable {
        context.write { (realm) in
            let old = realm.objects(StopPointRealm.self)
            let new = stopPoints.map(StopPointDetailsToRealmMapper().map(from:))
            try realm.write {
                realm.delete(old)
                realm.add(new)
            }
        }
    }
    
    func stopPoints() -> Observable<[StopPointDetails]> {
        context.objects(StopPointRealmMapper())
    }
    
    func favoriteStopPointIDs() -> Observable<[String]> {
        context.objects(FavoriteStopPointRealmMapper())
    }
    
    func addFavorite(stopPointID: String) -> Completable {
        context.write { (realm) in
            let favorite = FavoriteStopPointRealm.create(id: stopPointID)
            try realm.write {
                realm.add(favorite)
            }
        }
    }
    
    func removeFavorite(stopPointID: String) -> Completable {
        context.write { (realm) in
            guard let favorite = realm.object(ofType: FavoriteStopPointRealm.self, forPrimaryKey: stopPointID) else {
                throw AppError.descriptive("object not found")
            }
            try realm.write {
                realm.delete(favorite)
            }
        }
    }
}

import RealmSwift

final class RealmContext {
    let result: Result<Realm, Error>
    
    var realm: Realm? {
        guard case .success(let realm) = result else {
            return nil
        }
        return realm
    }
    
    init() {
        do {
            result = .success(try Realm())
        } catch {
            result = .failure(error)
        }
    }
    
    func asSingle() -> Single<Realm> {
        result.asSingle()
    }
    
    func objects<M: Mapper>(_ mapper: M) -> Observable<[M.To]> where M.From: Object {
        asSingle().asObservable()
            .flatMap({ (realm) -> Observable<[M.To]> in
                let objects = realm.objects(M.From.self)
                return Observable.array(from: objects)
                    .map(ArrayMapper(mapper).map(from:))
            })
    }
    
    func write(block: @escaping (Realm) throws -> Void) -> Completable {
        asSingle()
            .flatMapCompletable { (realm) in
                do {
                    try block(realm)
                    return .empty()
                } catch {
                    return .error(error)
                }
            }
    }
}

extension Result {
    func asSingle() -> Single<Success> {
        switch self {
        case .failure(let error):
            return .error(error)
        case .success(let success):
            return .just(success)
        }
    }
}
