//
//  FaireWeatherApp.swift
//  FaireWeather
//
//  Created by Yuri Chaves on 16/09/22.
//

import SwiftUI

@main
struct FaireWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            Composer.makeWeatherView()
        }
    }
}

final class Composer {
    static func makeWeatherView() -> WeatherView {
        let httpClient = HTTPClient(session: URLSession.shared)
        let remoteWeatherUseCase = RemoteLoadWeather(remoteClient: httpClient)
        let weatherViewModel = WeatherViewModel(loadWeatherUseCase: remoteWeatherUseCase)

        return WeatherView(viewModel: weatherViewModel)
    }
}
