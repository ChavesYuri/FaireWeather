import SwiftUI

struct WeatherView: View {

    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear(perform: viewModel.loadWeather)
            case .loading:
                ProgressView()
                    .tint(.red)
            case .failed:
                ErrorView(onTryAgain: {
                    viewModel.loadWeather()
                })
            case .loadedWeather(let weather):
                WeatherDetailsView(weather: weather)
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Composer.makeWeatherView()
            .preferredColorScheme(.dark)

        Composer.makeWeatherView()
    }
}

