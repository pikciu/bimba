//
//  BodyRequestBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol BodyRequestBuilder {
    var url: String { get }
    var httpMethod: HttpMethod { get }
    func add(json json: JSON?) -> BodyRequestBuilder
    func add(headers headers: [String: String]) -> BodyRequestBuilder
    func getRequest() -> NSMutableURLRequest
    func setMethod(method: HttpMethod) -> BodyRequestBuilder
}