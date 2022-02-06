import DependencyContainer
import Domain

public struct DataModule: Module {
    
    public static func register(in container: Container) {
        container.registerShared(URLSession.self) { _ in URLSession(configuration: .default) }
        container.registerUnique(Domain.VMRepository.self) { _ in VMRepository() }
        container.registerUnique(Domain.StopPointRemoteRepository.self) { _ in StopPointRemoteRepository() }
        container.registerUnique(Domain.StopPointLocalRepository.self) { _ in StopPointLocalRepository() }
        container.registerWeak(RealmContext.self) { _ in RealmContext() }
    }
}
