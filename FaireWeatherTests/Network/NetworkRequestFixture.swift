import Foundation
@testable import FaireWeather

struct Request: NetworkRequest {
    var path: String
    var method: HTTPMethod
    var baseStringUrl: String
}

extension Request {
    static func fixture(
        path: String = "/path",
        method: HTTPMethod = .get,
        baseStringUrl: String = "www.google.com"
    ) -> Self {
        .init(path: path, method: method, baseStringUrl: baseStringUrl)
    }
}
