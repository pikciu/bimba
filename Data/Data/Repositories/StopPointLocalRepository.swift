import Foundation
import Domain
import RxSwift
import RxRealm
import RealmSwift

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

final class RealmContext {
    
    private func create() -> Single<Realm> {
        .create { (observer) -> Disposable in
            do {
                guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.pikciu.bimba") else {
                    throw AppError.descriptive("Could not create realm file for App Group ID")
                }
                var configuration = Realm.Configuration(fileURL: url.appendingPathComponent("db.realm"))
                configuration.deleteRealmIfMigrationNeeded = true
                observer(.success(try Realm(configuration: configuration)))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    func objects<M: Mapper>(_ mapper: M) -> Observable<[M.To]> where M.From: Object {
        create()
            .asObservable()
            .flatMap({ (realm) -> Observable<[M.To]> in
                let objects = realm.objects(M.From.self)
                return Observable.array(from: objects)
                    .map(ArrayMapper(mapper).map(from:))
            })
    }
    
    func write(block: @escaping (Realm) throws -> Void) -> Completable {
        create()
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
