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
            case .failedWithError(let error):
                Text(error.localizedDescription)
            case .loadedWeather(let weather):
                WeatherHeaderView(weather: weather)
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
