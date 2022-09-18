# FaireWeather
FaireWeather is an app to show the current weather in Toronto CA. 

This project was deleveloped using MVVM architecture with SwiftUI and without any third-party library.
I chose this architecture because the problem and the domain logic are quite simple. Also to keep the domain logic 
separated from View.

I started creating the UILayer, using the outside-in technique, to get a quick feedback of the UI and to get a better
idea of how to create and separate the layers.

Secondly I created the Netwrok Service/Tests to provide the information from a specific url. After that I focused on
the Infrastructure/Tests and Domain layer/Tests.

At the end I linked the layers and made some finals adjusts. 
