import Foundation

struct GetDepartureTimesRequest: Encodable, URLEncodedFormRequestType {
    let parameter: String
    let method = "getTimes"
    
    enum CodingKeys: String, CodingKey {
        case parameter = "p0"
        case method
    }
    
    init(stopPointID: String) {
        self.parameter = "{\"symbol\":\"\(stopPointID)\"}"
    }
    
    func build() throws -> Request {
        try Request(endpoint: VMEndpoint(), httpMethod: .POST, body: body(), headers: [])
    }
}
