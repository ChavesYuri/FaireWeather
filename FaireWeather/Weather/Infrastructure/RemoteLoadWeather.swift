import Foundation

enum ConversionError: Error {
    case emptyData
}

final class RemoteLoadWeather: LoadWeatherUseCase {
    let remoteClient: HTTPClientProtocol

    init(remoteClient: HTTPClientProtocol) {
        self.remoteClient = remoteClient
    }
    
    func execute(completion: @escaping (LoadWeatherUseCase.Result) -> Void) {
        let request: WeatherRequest = .init()

        remoteClient.get(request: request) { (result: Swift.Result<RemoteWeatherModel, Error>) in
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

        let imageStringUrl = "\(Bundle.main.apiImageUrl + firstItem.weatherStateAbbr).png"
        return WeatherModel(city: remoteModel.title,
                            temperature: "\(Int(firstItem.theTemp.rounded()))°",
                            weatherState: firstItem.weatherStateName,
                            minimumTemperature: "\(Int(firstItem.minTemp.rounded()))°",
                            maximumTemperature: "\(Int(firstItem.maxTemp.rounded()))°",
                            imageStringUrl: imageStringUrl
        )
    }
}
