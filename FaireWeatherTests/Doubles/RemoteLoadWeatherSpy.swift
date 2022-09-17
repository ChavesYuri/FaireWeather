import Foundation
@testable import FaireWeather
final class RemoteLoadWeatherSpy: LoadWeatherUseCase {

    private(set) var executeCount: Int = 0
    var executeWeatherReceived: LoadWeatherUseCase.Result?

    func execute(completion: @escaping (LoadWeatherUseCase.Result) -> Void) {
        executeCount += 1
        if let completionHandler = executeWeatherReceived {
            completion(completionHandler)
        }
    }
}
