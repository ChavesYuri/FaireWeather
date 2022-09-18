//
//  NetworkRequest.swift
//  FaireWeather
//
//  Created by Yuri Chaves on 18/09/22.
//

import Foundation
enum HTTPMethod: String {
    case get = "GET"
}

protocol NetworkRequest {
    var baseStringUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}
