import Foundation

struct VMEndpoint: EndpointType {
    func resolve() throws -> String {
        "https://www.peka.poznan.pl/vm/method.vm"
    }
}
