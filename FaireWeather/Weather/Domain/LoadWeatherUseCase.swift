import Foundation
protocol LoadWeatherUseCase {
    typealias Result = Swift.Result<WeatherModel, Error>

    func execute(completion: @escaping (Result) -> Void)
}

