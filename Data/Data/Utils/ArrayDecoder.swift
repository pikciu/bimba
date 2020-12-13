import Foundation
import Domain
import RxSwift

struct ArrayDecoder<Mapper: Domain.Mapper> where Mapper.From: Decodable {
    
    typealias From = Data
    typealias To = [Mapper.To]
    
    let mapper: Mapper
    
    init(_ mapper: Mapper) {
        self.mapper = mapper
    }
    
    func transform(from: Single<Data>) -> Single<To> {
        let dtos = from.map(JSONMapper<[Mapper.From]>().map(from:))
        return dtos.map({ (array) -> To in
            try array.map(self.mapper.map)
        }).do(onError: { (error) in
            log.error(error)
        })
    }
}
