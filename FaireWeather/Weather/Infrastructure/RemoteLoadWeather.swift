import Foundation

enum ConversionError: Error {
    case emptyData
}

final class RemoteLoadWeather: LoadWeatherUseCase {
    let remoteClient: HTTPClientProtocol
    let url: URL

    init(
        remoteClient: HTTPClientProtocol,
        url: URL
    ) {
        self.remoteClient = remoteClient
        self.url = url
    }
    
    func execute(completion: @escaping (LoadWeatherUseCase.Result) -> Void) {
        remoteClient.get(url: url) { (result: Swift.Result<RemoteWeatherModel, Error>) in
            switch result {
            case .success(let remoteModel):
                do {
                    completion(.success(try RemoteLoadWeather.map(remoteModel)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private static func map(
        _ remoteModel: RemoteWeatherModel
    ) throws -> WeatherModel {
        guard let firstItem = remoteModel.consolidatedWeather.first else {
            throw ConversionError.emptyData
        }

        return WeatherModel(city: remoteModel.title,
                            temperature: "\(firstItem.theTemp.rounded())°",
                            weatherState: firstItem.weatherStateName,
                            minimumTemperature: "\(firstItem.minTemp.rounded())",
                            maximumTemperature: "\(firstItem.maxTemp.rounded())",
                            weatherStateAbbr: firstItem.weatherStateAbbr
        )
    }
}
