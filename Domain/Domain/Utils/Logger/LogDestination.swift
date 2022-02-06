import Foundation

public protocol LogDestination {
    
    func log(_ object: @autoclosure @escaping () -> Any, level: LogLevel, filename: String, line: Int, function: String)
}
