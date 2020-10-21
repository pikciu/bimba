import Foundation

@propertyWrapper
public final class Inject<T> {
    
    private lazy var value: T = Container.resolve()
    
    public init() {
        
    }
    
    public var wrappedValue: T {
        value
    }
}
