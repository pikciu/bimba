import Foundation

public enum SearchResult {
    case stopPoint(StopPoint)
    case line(String)
    case street(Street)
}
