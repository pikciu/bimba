import Foundation
import Domain

struct DateTimeMapper: Mapper {
    private let formatter = DateTimeFormatter(
        timeZone: .current,
        locale: Locale(identifier: "en_US_POSIX")
    )
    
    let format = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    func map(from object: String) throws -> Date {
        guard let date = formatter.date(from: object, dateFormat: format) else {
            throw AppError.mappingError(AppError.descriptive("Invalid date"))
        }
        return date.convert(from: .current, to: .gmt)
    }
}
