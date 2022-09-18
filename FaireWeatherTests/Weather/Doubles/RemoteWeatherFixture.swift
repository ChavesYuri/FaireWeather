import Foundation
@testable import FaireWeather

extension RemoteWeatherModel {
    static func fixture(
        consolidatedWeather: [ConsolidatedWeather] = [],
        title: String = ""
    ) -> Self {
        .init(
            consolidatedWeather: consolidatedWeather,
            title: title
        )
    }
}
