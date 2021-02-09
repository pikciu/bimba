import Foundation

private let SCHEME = "bimba"
private let STOP = "stop"

public enum DeepLink {
    
    case stop(StopPointType)
    
    public init?(url: URL) {
        guard url.scheme == SCHEME else {
            return nil
        }
        switch (url.host, url.pathComponents.count) {
        case (STOP, 3):
            let name = url.pathComponents[1]
            let id = url.pathComponents[2]
            self = .stop(StopPoint(id: id, name: name))
        default:
            return nil
        }
    }
    
    public var url: URL? {
        guard let path = path else {
            return nil
        }
        return URL(string: "\(SCHEME)://\(path)")
    }
    
    var path: String? {
        switch self {
        case .stop(let stop):
            return "\(STOP)/\(stop.name)/\(stop.id)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        }
    }
}
