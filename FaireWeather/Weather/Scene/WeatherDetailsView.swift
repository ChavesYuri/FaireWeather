//
//  WeatherHeaderView.swift
//  FaireWeather
//
//  Created by Yuri Chaves on 17/09/22.
//

import SwiftUI

struct WeatherDetailsView: View {
    let weather: WeatherModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 1) {
                    ZStack {
                        AsyncImage(url: URL(string: weather.imageStringUrl), scale: 2) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.red)
                        }
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    Text(weather.temperature)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                }

                Text(weather.weatherState)

                HStack(spacing: 15) {
                    HStack(spacing: 1) {
                        Text("L:")
                            .font(.title)

                        Text(weather.minimumTemperature)
                            .font(.title)
                    }

                    HStack(spacing: 1) {
                        Text("H:")
                            .font(.title)

                        Text(weather.maximumTemperature)
                            .font(.title)
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle(weather.city)
        }
    }
}

struct WeatherHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(
            weather: .init(
                city: "Toronto",
                temperature: "16°",
                weatherState: "Light Rain",
                minimumTemperature: "10°",
                maximumTemperature: "22°",
                imageStringUrl: "https://cdn.faire.com/static/mobile-take-home/icons/weather_state_abbr.png"
            )
        )
    }
}
