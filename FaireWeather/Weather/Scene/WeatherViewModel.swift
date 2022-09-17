import Foundation

final class WeatherViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failedWithError(_ error: Error)
        case loadedWeather(_ weather: WeatherModel)
    }

    @Published private(set) var state = State.idle

    private let loadWeatherUseCase: LoadWeatherUseCase

    init(loadWeatherUseCase: LoadWeatherUseCase) {
        self.loadWeatherUseCase = loadWeatherUseCase
    }

    func loadWeather() {
        changeState(newState: .loading)

        loadWeatherUseCase.execute { [weak self] result in
            switch result {
            case .success(let weather):
                self?.changeState(newState: .loadedWeather(weather))
            case .failure(let error):
                self?.changeState(newState: .failedWithError(error))
            }
        }
    }

    private func changeState(newState: State) {
        DispatchQueue.main.async {
            self.state = newState
        }
    }
}
