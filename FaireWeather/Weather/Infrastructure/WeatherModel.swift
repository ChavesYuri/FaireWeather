import Foundation

// MARK: - WeatherModel
struct RemoteWeatherModel: Decodable {
    let consolidatedWeather: [ConsolidatedWeather]
    let title: String

    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        case title
    }
}

// MARK: - ConsolidatedWeather
struct ConsolidatedWeather: Codable {
    let id: Int
    let weatherStateName, weatherStateAbbr: String
    let minTemp, maxTemp, theTemp: Double

    enum CodingKeys: String, CodingKey {
        case id
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
    }
}
