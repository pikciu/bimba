import Foundation

struct GetStopPointsRequest: RequestType {
    
    func build() throws -> Request {
        try Request(endpoint: StopPointsEndpoint(), httpMethod: .GET)
    }
}
