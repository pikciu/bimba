//
//  Convertible.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

protocol Convertible {
    associatedtype TIn
    associatedtype TOut
    func convert(_ value: TIn) -> TOut
}
