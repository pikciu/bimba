import Foundation

struct VMEndpoint: EndpointType {
    func resolve() throws -> String {
        "http://www.peka.poznan.pl/vm/method.vm"
    }
}
