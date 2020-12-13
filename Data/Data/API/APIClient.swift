import Foundation
import Domain
import RxSwift
import RxSwiftExt

final class APIClient {
    private let httpClient = HTTPClient()
    
    func execute<M: Mapper>(request: RequestType, responseMapper: M) -> Single<M.To> where M.From: Decodable {
        do {
            return execute(request: try request.build(), responseMapper: responseMapper)
        } catch {
            return Single.error(error)
        }
    }
    
    func execute<M: Mapper>(request: RequestType, elementMapper: M) -> Single<[M.To]> where M.From: Decodable {
        do {
            return execute(request: try request.build(), elementMapper: elementMapper)
        } catch {
            return Single.error(error)
        }
    }
    
    func execute(request: RequestType) -> Single<Void> {
        do {
            return execute(request: try request.build())
        } catch {
            return Single.error(error)
        }
    }
    
    func execute<M: Mapper>(request: Request, responseMapper: M) -> Single<M.To> where M.From: Decodable {
        executeRaw(request: request)
            .map({ $0.body })
            .apply(ObjectDecoder(responseMapper).transform(from:))
    }
    
    func execute<M: Mapper>(request: Request, elementMapper: M) -> Single<[M.To]> where M.From: Decodable {
        executeRaw(request: request)
            .map({ $0.body })
            .apply(ArrayDecoder(elementMapper).transform(from:))
    }
    
    func execute(request: Request) -> Single<Void> {
        executeRaw(request: request).mapTo(())
    }
    
    func executeRaw(request: RequestType) -> Single<Response> {
        do {
            return executeRaw(request: try request.build())
        } catch {
            return Single.error(error)
        }
    }
    
    func executeRaw(request: Request) -> Single<Response> {
        httpClient.execute(request: request)
    }
}
