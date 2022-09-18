import Foundation
@testable import FaireWeather
import XCTest
final class RemoteLoadWeatherTests: XCTestCase {

    func test_init_shouldHaveNoRequest() {
        let (_, client) = makeSUT()

        XCTAssertNil(client.resultToReturn)
        XCTAssertNil(client.lastRequest)
    }

    func test_execute_whenCompletesWithSuccess_shouldMapToWeather() {
        let (sut, client) = makeSUT()

        client.resultToReturn = makeSuccessWeatherResult(with:
                .fixture(
                    consolidatedWeather: [.fixture(weatherStateName: "Light Rain")],
                    title: "Toronto"
                )
        )

        let exp = expectation(description: "wait for network completion")
        sut.execute { result in
            switch result {
            case .success(let weather):
                XCTAssertEqual(weather.city, "Toronto")
                XCTAssertEqual(weather.weatherState, "Light Rain")
            case .failure(let error):
                XCTFail("Expected success got failure with error: \(error)")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    func test_execute_whenCompletesWithSuccessWithEmptyWeathers_shouldMapToError() {
        let (sut, client) = makeSUT()

        client.resultToReturn = makeSuccessWeatherResult(with: .fixture())

        let exp = expectation(description: "wait for network completion")
        sut.execute { result in
            switch result {
            case .failure(let error as ConversionError):
                XCTAssertEqual(error, .emptyData)
            default:
                XCTFail("Expected failure got \(result)")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    func test_execute_whenCompletesWithError_shouldReturnError() {
        let (sut, client) = makeSUT()

        let error = anyNSError()
        client.resultToReturn = makeFailureWeatherResult(with: error)

        let exp = expectation(description: "wait for network completion")
        sut.execute { result in
            switch result {
            case .failure(let receivedError as NSError):
                XCTAssertEqual(receivedError, error)
            default:
                XCTFail("Expected failure got \(result)")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)

    }

    // MARK: - Helpers
    private func makeSUT() -> (sut: RemoteLoadWeather, client: HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        let sut = RemoteLoadWeather(remoteClient: httpClient)

        return (sut, httpClient)
    }

    private func makeSuccessWeatherResult(with remoteWeather: RemoteWeatherModel) -> Result<RemoteWeatherModel, Error> {
        .success(remoteWeather)
    }

    private func makeFailureWeatherResult(with error: Error) -> Result<RemoteWeatherModel, Error> {
        .failure(error)
    }

    private func anyNSError() -> NSError {
        NSError(domain: "", code: -1)
    }
}
