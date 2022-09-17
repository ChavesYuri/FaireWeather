import Foundation
@testable import FaireWeather

extension ConsolidatedWeather {
    static func fixture(
        id: Int = 0,
        weatherStateName: String = "",
        weatherStateAbbr: String = "",
        minTemp: Double = 0,
        maxTemp: Double = 0,
        theTemp: Double = 0
    ) -> Self {
        .init(
            id: id,
            weatherStateName: weatherStateName,
            weatherStateAbbr: weatherStateAbbr,
            minTemp: minTemp,
            maxTemp: maxTemp,
            theTemp: theTemp
        )
    }
}
