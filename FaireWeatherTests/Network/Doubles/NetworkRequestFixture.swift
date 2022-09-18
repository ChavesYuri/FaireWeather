import Foundation
@testable import FaireWeather

struct Request: NetworkRequest {
    var path: String
    var baseStringUrl: String
}

extension Request {
    static func fixture(
        path: String = "/path",
        baseStringUrl: String = "www.google.com"
    ) -> Self {
        .init(path: path, baseStringUrl: baseStringUrl)
    }
}
