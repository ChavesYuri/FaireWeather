import Foundation
@testable import FaireWeather

final class HTTPClientSpy: HTTPClientProtocol {
    private(set) var lastURL: URL?
    var resultToReturn: Any?

    func get<T>(url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        lastURL = url

        if let result = resultToReturn as? Result<T, Error> {
            completion(result)
        }
    }
}
