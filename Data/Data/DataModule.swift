import Foundation
import Domain

public struct DataModule: Module {
    
    public static func register(in container: SwinjectContainer) {
        container.register(URLSession.self) { _ in URLSession(configuration: .default) }
            .inObjectScope(.container)
        
        container.register(Domain.VMRepository.self) { _ in VMRepository() }
        container.register(Domain.StopPointRemoteRepository.self) { _ in StopPointRemoteRepository() }
        container.register(Domain.StopPointLocalRepository.self) { _ in StopPointLocalRepository() }
        
        container.register(RealmContext.self) { _ in RealmContext() }
            .inObjectScope(.weak)
        
    }
}
