//
//  ApiRequest.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import Foundation
import Alamofire

struct ApiRequest {
    var method: Alamofire.HTTPMethod
    var path: String
    var parameters: Parameters?
    var encoding: ParameterEncoding
    var headers: HTTPHeaders?

    init(method: Alamofire.HTTPMethod = .get, path: String, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding(), headers: HTTPHeaders? = nil) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers ?? ["Content-Type": "application/json"]
    }
}
