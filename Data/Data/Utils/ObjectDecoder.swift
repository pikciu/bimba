import Foundation
import Domain
import RxSwift

struct ObjectDecoder<Mapper: Domain.Mapper> where Mapper.From: Decodable {
    
    typealias From = Data
    typealias To = Mapper.To
    
    let mapper: Mapper
    
    init(_ mapper: Mapper) {
        self.mapper = mapper
    }
    
    func transform(from: Single<Data>) -> Single<Mapper.To> {
        from.map(JSONMapper<Mapper.From>().map(from:))
            .map(mapper.map(from:))
            .do(onError: { (error) in
                log.error(error)
            })
    }
}
