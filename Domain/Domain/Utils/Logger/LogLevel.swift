import Foundation

public enum LogLevel: Int {
    case verbose
    case debug
    case info
    case warning
    case error
    
    public var label: String {
        "\(self)".uppercased()
    }
}
