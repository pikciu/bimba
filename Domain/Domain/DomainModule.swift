//
//  DomainModule.swift
//  Domain
//
//  Created by Tomasz Pikć on 12/12/2020.
//

import Foundation
import RxSwiftUtilities

public struct DomainModule: Module {
    
    public static func register(in container: SwinjectContainer) {
        container.register(ActivityIndicator.self) { _ in ActivityIndicator() }
            .inObjectScope(.weak)
    }
}
