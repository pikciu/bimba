import Foundation

struct StopPointsEndpoint: EndpointType {
    func resolve() throws -> String {
        "http://www.poznan.pl/mim/plan/map_service.html?mtype=pub_transport&co=cluster"
    }
}
