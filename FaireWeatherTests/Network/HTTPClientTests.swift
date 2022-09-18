//
//  FaireWeatherTests.swift
//  FaireWeatherTests
//
//  Created by Yuri Chaves on 16/09/22.
//

import XCTest
@testable import FaireWeather

final class HTTPClientTests: XCTestCase {

    func test_request_shouldReturnSuccess() throws {
        let fakeURL = URL(string: "www.google.com/path")!
        let baseRequest: Request = .fixture()
        let jsonData = try XCTUnwrap("{\"dummyProperty\":\"property\"}".data(using: .utf8))

        let response = HTTPURLResponse(url: fakeURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockURLs = [fakeURL: (nil, jsonData, response)]

        let (sut, _) = makeSUT()

        let exp = expectation(description: "wait for network completion")
        sut.get(request: baseRequest) { (result: Swift.Result<DummyCodable, Error>) in
            switch result {
            case .success(let responseCodable):
                XCTAssertEqual(responseCodable.dummyProperty, "property")
            case .failure:
                XCTFail("Case not expected")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 4.0)
    }

    func test_request_shouldReturnDecodeError() throws {
        let fakeURL = URL(string: "www.google.com/path")!
        let baseRequest: Request = .fixture()
        let jsonData = try XCTUnwrap("{\"dummyPropert\":\"property\"}".data(using: .utf8))
        let response = HTTPURLResponse(url: fakeURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockURLs = [fakeURL: (nil, jsonData, response)]

        let (sut, _) = makeSUT()

        let exp = expectation(description: "wait for network completion")
        sut.get(request: baseRequest) { (result: Swift.Result<DummyCodable, Error>) in
            switch result {
            case .failure(let error as ErrorResponse):
                XCTAssertEqual(error, .decode)
            default:
                XCTFail("Case not expected")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    func test_request_shouldReturnInvalidResponse() throws {
        let fakeURL = URL(string: "www.google.com/path")!
        let baseRequest: Request = .fixture()
        let jsonData = try XCTUnwrap("{\"dummyProperty\":\"property\"}".data(using: .utf8))
        let response = HTTPURLResponse(url: fakeURL, statusCode: 400, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockURLs = [fakeURL: (nil, jsonData, response)]

        let (sut, _) = makeSUT()

        let exp = expectation(description: "wait for network completion")
        sut.get(request: baseRequest) { (result: Swift.Result<DummyCodable, Error>) in
            switch result {
            case .failure(let error as ErrorResponse):
                XCTAssertEqual(error, .invalidResponse)
            default:
                XCTFail("Case not expected")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    func test_request_shouldReturnInvalidData() {
        let fakeURL = URL(string: "www.google.com/path")!
        let baseRequest: Request = .fixture()
        let response = HTTPURLResponse(url: fakeURL, statusCode: 400, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockURLs = [fakeURL: (nil, nil, response)]

        let (sut, _) = makeSUT()

        let exp = expectation(description: "wait for network completion")
        sut.get(request: baseRequest) { (result: Swift.Result<DummyCodable, Error>) in
            switch result {
            case .failure(let error as ErrorResponse):
                XCTAssertEqual(error, .invalidResponse)
            default:
                XCTFail("Case not expected")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    private func makeSUT() -> (HTTPClient, URLSession)  {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: sessionConfiguration)

        let sut = HTTPClient(session: mockSession)

        return (sut, mockSession)
    }
}
