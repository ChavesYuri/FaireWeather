import Foundation
@testable import FaireWeather

final class HTTPClientSpy: HTTPClientProtocol {
    private(set) var lastRequest: NetworkRequest?
    var resultToReturn: Any?

    func get<T>(request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        lastRequest = request

        if let result = resultToReturn as? Result<T, Error> {
            completion(result)
        }
    }
}
