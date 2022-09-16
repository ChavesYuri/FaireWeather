//
//  ContentView.swift
//  FaireWeather
//
//  Created by Yuri Chaves on 16/09/22.
//

import SwiftUI

struct WeatherView: View {

    let city: String
    let temperature: String
    let weatherDescription: String
    let maximumTemperature: String
    let minimumTemperature: String

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(temperature)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text(weatherDescription)

                HStack(spacing: 15) {
                    HStack(spacing: 1) {
                        Text("L:")
                        Text(minimumTemperature)
                    }

                    HStack(spacing: 1) {
                        Text("H:")
                        Text(maximumTemperature)
                    }

                }

                Spacer()
            }
            .navigationTitle(city)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(city: "Toronto", temperature: "16", weatherDescription: "Cloudy", maximumTemperature: "23", minimumTemperature: "10")
            .preferredColorScheme(.dark)

        WeatherView(city: "Toronto", temperature: "16", weatherDescription: "Cloudy", maximumTemperature: "23", minimumTemperature: "10")
    }
}
