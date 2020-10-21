import Foundation

protocol URLEncodedFormRequestType: EncodableRequestType {
    
}

extension URLEncodedFormRequestType {
    var defaultHeaders: [HTTPHeader] {
        [.contentType(.urlEncodedForm)]
    }
    
    var encoder: RequestBodyEncoder {
        URLEncodedFormEncoder()
    }
}
