import Foundation
import XCTest
@testable import FaireWeather

final class ViewModelTests: XCTestCase {

    func test_init_shouldStartWithIdleState() {
        let (sut, useCase) = makeSUT()

        XCTAssertEqual(useCase.executeCount, 0)
        XCTAssertEqual(sut.state, .idle)
    }

    func test_load_shouldLoadWeather() {
        let (sut, useCase) = makeSUT()
        let weatherModel: WeatherModel = .fixture(city: "Montreal")

        useCase.executeWeatherReceived = .success(weatherModel)
        
        sut.loadWeather()

        XCTAssertEqual(useCase.executeCount, 1)

        let exp = expectation(description: "wait for main thread")
        DispatchQueue.main.async {
            XCTAssertEqual(sut.state, .loadedWeather(weatherModel))
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }

    func test_load_shouldReturnError() {
        let (sut, useCase) = makeSUT()
        let error = anyNSError()

        useCase.executeWeatherReceived = .failure(error)

        sut.loadWeather()

        XCTAssertEqual(useCase.executeCount, 1)

        let exp = expectation(description: "wait for main thread")
        DispatchQueue.main.async {
            XCTAssertEqual(sut.state, .failed)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }


    // MARK: - Helpers
    private func makeSUT() -> (sut: WeatherViewModel, useCase: RemoteLoadWeatherSpy) {
        let useCaseSpy = RemoteLoadWeatherSpy()
        let sut = WeatherViewModel(loadWeatherUseCase: useCaseSpy)

        return (sut, useCaseSpy)
    }

    private func anyNSError() -> NSError {
        NSError(domain: "", code: -1)
    }
}


extension WeatherViewModel.State: Equatable {
    public static func == (lhs: WeatherViewModel.State, rhs: WeatherViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.failed, .failed):
            return true
        case (.loadedWeather(let lhsWeather), .loadedWeather(let rhsWeather)):
            return lhsWeather == rhsWeather
        default:
            return false
        }
    }
}

extension WeatherModel {
    static func fixture(
        city: String = "",
        temperature: String = "",
        weatherState: String = "",
        minimumTemperature: String = "",
        maximumTemperature: String = "",
        imageStringUrl: String = ""
    ) -> Self {
        .init(
            city: city,
            temperature: temperature,
            weatherState: weatherState,
            minimumTemperature: minimumTemperature,
            maximumTemperature: maximumTemperature,
            imageStringUrl: imageStringUrl
        )
    }
}
