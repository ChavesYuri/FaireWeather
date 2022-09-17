import Foundation
@testable import FaireWeather
import XCTest
final class RemoteLoadWeatherTests: XCTestCase {

    func test_init_shouldHaveNoRequest() throws {
        let (_, client) = makeSUT(url: try baseURLTest())

        XCTAssertNil(client.resultToReturn)
        XCTAssertNil(client.lastURL)
    }

    func test_execute_whenCompletesWithSuccess_shouldMapToWeather() throws {
        let (sut, client) = makeSUT(url: try baseURLTest())

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

    func test_execute_whenCompletesWithSuccessWithEmptyWeathers_shouldMapToError() throws {
        let (sut, client) = makeSUT(url: try baseURLTest())

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

    func test_execute_whenCompletesWithError_shouldReturnError() throws {
        let (sut, client) = makeSUT(url: try baseURLTest())

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
    private func makeSUT(url: URL) -> (sut: RemoteLoadWeather, client: HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        let sut = RemoteLoadWeather(remoteClient: httpClient, url: url)

        return (sut, httpClient)
    }

    private func baseURLTest() throws -> URL  {
        return try XCTUnwrap(URL(string: "https//:www.fairetest.com.br"))
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
