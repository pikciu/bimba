import DependencyContainer

@propertyWrapper
public final class Inject<T> {
    
    private lazy var value = Container.resolve(T.self)
    
    public init() {
        
    }
    
    public var wrappedValue: T {
        value
    }
}
