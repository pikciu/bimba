import Foundation

struct SearchRequest: Encodable, URLEncodedFormRequestType {
    enum Method: String, Encodable {
        case lines = "getLines"
        case stopPoints = "getStopPoints"
        case streets = "getStreets"
    }
    
    enum CodingKeys: String, CodingKey {
        case parameter = "p0"
        case method
    }
    
    let parameter: String
    let method: Method
    
    init(method: Method, query: String) {
        self.parameter = "{\"pattern\":\"\(query)\"}"
        self.method = method
    }
    
    func build() throws -> Request {
        try Request(endpoint: VMEndpoint(), httpMethod: .POST, body: body(), headers: [])
    }
}
