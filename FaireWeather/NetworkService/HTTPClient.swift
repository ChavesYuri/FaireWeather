import Foundation

enum ErrorResponse: String, Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case decode
}

protocol HTTPClientProtocol {
    func get<T: Decodable>(request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void)
}

final class HTTPClient: HTTPClientProtocol {
    let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func get<T: Decodable>(request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) {


        guard let url = URL(string: request.baseStringUrl + request.path) else {
            completion(.failure(ErrorResponse.invalidURL))
            return
        }


        session.dataTask(with: url) { (data, response, error) in
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


