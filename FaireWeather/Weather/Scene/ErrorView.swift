//
//  ErrorView.swift
//  FaireWeather
//
//  Created by Yuri Chaves on 18/09/22.
//

import SwiftUI

struct ErrorView: View {
    let onTryAgain: (() -> Void)

    var body: some View {
        VStack(spacing: 10) {
            Text("Sorry")
                .font(.title)
            Text("We had a problem fetching the information\n😢")
                .multilineTextAlignment(.center)
            Button {
                onTryAgain()
            } label: {
                Text("Try Again")
                Image(systemName: "arrow.clockwise")
            }
            .buttonStyle(.bordered)
            .background(.clear)
            .tint(.red)
            .padding()

            Spacer()
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(onTryAgain: {})
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)

        ErrorView(onTryAgain: {})
            .previewLayout(.sizeThatFits)

    }
}
