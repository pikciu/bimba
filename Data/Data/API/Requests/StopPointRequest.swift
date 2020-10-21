import Foundation

struct StopPointRequest: Encodable, URLEncodedFormRequestType {
    enum Method: String, Encodable {
        case times = "getTimes"
        case message = "findMessagesForBollard"
    }
    
    enum CodingKeys: String, CodingKey {
        case parameter = "p0"
        case method
    }
    
    let parameter: String
    let method: Method
    
    init(stopPointID: String, method: Method) {
        self.parameter = "{\"symbol\":\"\(stopPointID)\"}"
        self.method = method
    }
    
    func build() throws -> Request {
        try Request(endpoint: VMEndpoint(), httpMethod: .POST, body: body(), headers: [])
    }
}
