import Foundation

public let log = Logger()

public final class Logger {
    
    private var destinations: [LogDestination]
    
    init(destinations: LogDestination...) {
        self.destinations = destinations
    }
    
    public func add(destination: LogDestination) {
        destinations.append(destination)
    }
    
    public var logLevel: LogLevel?
    
    func log(
        _ object: @autoclosure @escaping () -> Any,
        level: LogLevel,
        filename: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        guard let logLevel = logLevel, level.rawValue >= logLevel.rawValue else {
            return
        }
        
        destinations.forEach { (destination) in
            destination.log(object, level: level, filename: filename, line: line, function: function)
        }
    }
    
    public func verbose(_ object: @autoclosure @escaping () -> Any, filename: String = #file, line: Int = #line, function: String = #function) {
        log(object, level: .verbose, filename: filename, line: line, function: function)
    }
    
    public func debug(_ object: @autoclosure @escaping () -> Any, filename: String = #file, line: Int = #line, function: String = #function) {
        log(object, level: .debug, filename: filename, line: line, function: function)
    }
    
    public func info(_ object: @autoclosure @escaping () -> Any, filename: String = #file, line: Int = #line, function: String = #function) {
        log(object, level: .info, filename: filename, line: line, function: function)
    }
    
    public func warning(_ object: @autoclosure @escaping () -> Any, filename: String = #file, line: Int = #line, function: String = #function) {
        log(object, level: .warning, filename: filename, line: line, function: function)
    }
    
    public func error(_ object: @autoclosure @escaping () -> Any, filename: String = #file, line: Int = #line, function: String = #function) {
        log(object, level: .error, filename: filename, line: line, function: function)
    }
}
