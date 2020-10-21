import Foundation

public enum SearchResult {
    case stopPoint(StopPointGroup)
    case line(String)
    case street(Street)
}
