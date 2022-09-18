import Foundation
struct WeatherRequest: NetworkRequest {
    var path: String {
        "/static/mobile-take-home/4418.json"
    }

    var baseStringUrl: String {
        Bundle.main.apiBaseUrl
    }
}
