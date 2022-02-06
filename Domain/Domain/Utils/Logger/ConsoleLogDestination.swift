import Foundation

public struct ConsoleLogDestination: LogDestination {
    
    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSS"
       return formatter
    }()
    
    public init() {
        
    }
    
    public func log(_ object: @autoclosure @escaping () -> Any, level: LogLevel, filename: String, line: Int, function: String) {
        let date = dateFormatter.string(from: Date())
        let file = filename.components(separatedBy: "/").last ?? ""

        let message = "\(date) [\(level.label)] \(file):\(line) \(function)\n\(object())"
        
        print(message)
        
    }
}
