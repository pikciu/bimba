import Foundation

struct NameRequest: Encodable, URLEncodedFormRequestType {
    enum Method: String, Encodable {
        case stopPointsByName = "getBollardsByStopPoint"
        case stopPointsByStreet = "getBollardsByStreet"
        case directionsByLine = "getBollardsByLine"
    }
    
    enum CodingKeys: String, CodingKey {
        case parameter = "p0"
        case method
    }
    
    let parameter: String
    let method: Method
    
    init(name: String, method: Method) {
        self.parameter = "{\"name\":\"\(name)\"}"
        self.method = method
    }
    
    func build() throws -> Request {
        try Request(endpoint: VMEndpoint(), httpMethod: .POST, body: body(), headers: [])
    }
}
