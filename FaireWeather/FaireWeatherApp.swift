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
        let stringUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as! String
        let url = URL(string: stringUrl)!

        let remoteWeatherUseCase = RemoteLoadWeather(remoteClient: httpClient, url: url)
        let weatherViewModel = WeatherViewModel(loadWeatherUseCase: remoteWeatherUseCase)

        return WeatherView(viewModel: weatherViewModel)
    }
}
