import Foundation

enum ErrorResponse: String, Error {
    case invalidData
    case invalidResponse
    case decode
}

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithURL(_ url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

final class HTTPClient {
    let session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session
    }

    func get<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {

        session.dataTaskWithURL(url) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }

            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(ErrorResponse.invalidResponse))
            }

            guard let data = data else {
                return completion(.failure(ErrorResponse.invalidData))
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(ErrorResponse.decode))
            }
        }
        .resume()
    }
}


