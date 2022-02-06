import Domain
import Firebase

struct RemoteLogDestination: LogDestination {
    private let crashlytics = Crashlytics.crashlytics()
    
    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSS"
       return formatter
    }()
    
    func log(_ object: @autoclosure @escaping () -> Any, level: LogLevel, filename: String, line: Int, function: String) {
        let date = dateFormatter.string(from: Date())
        let file = filename.components(separatedBy: "/").last ?? ""
        let domain = "\(level.label) \(file):\(line) \(function)"

        let userInfo = [
            NSLocalizedDescriptionKey: "\(date) \(domain)",
            NSLocalizedFailureReasonErrorKey: "\(object())",
            "File": file,
            "Line": String(line),
            "Function": function
        ]

        let error = NSError(
            domain: domain,
            code: -1,
            userInfo: userInfo
        )

        crashlytics.record(error: error)
    }
}
