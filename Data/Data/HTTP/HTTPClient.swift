import DependencyContainer
import RxSwift
import Domain

final class HTTPClient {
    
    func execute(request: Request) -> Single<Response> {
        guard let urlRequest = createRequest(from: request) else {
            return Single.error(HTTPError.invalidRequest)
        }
        
        let observable: Single<Response> = Single.create { (observer) in
            let session = Container.resolve(URLSession.self)
            let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
                
                log.verbose(request.resource)
                
                if let error = error {
                    observer(.failure(HTTPError.networkError(error)))
                    return
                }
                
                guard
                    let httpResponse = urlResponse as? HTTPURLResponse,
                    let data = data
                else {
                    observer(.failure(HTTPError.noResponse))
                    return
                }
          
                guard 200..<300 ~= httpResponse.statusCode else {
                    let json = String(bytes: data, encoding: .utf8) ?? ""
                    log.verbose(json)
                    observer(.failure(HTTPError.httpError(status: httpResponse.statusCode, data: data)))
                    return
                }
                
                let response = Response(
                    body: data,
                    httpResponse: httpResponse
                )
                observer(.success(response))
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
        
        return observable.observe(on: MainScheduler.instance)
            .do(onError: { (error) in
                log.error(error)
            })
    }
    
    private func createRequest(from request: Request) -> URLRequest? {
        guard let resource = request.resource.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            return nil
        }
        guard let url = URL(string: resource) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.body
        for header in request.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        return urlRequest
    }
}
