Efficient Weather App
Overview
  Imagine you are working for a weather data company, and your task is to create a weather app for iOS devices. The app should allow users to check the current weather conditions for a given location and also view the weather forecast for the next 5 days. The app fetches weather data from the OpenWeatherMap API and displays it in a user-friendly interface.

Features
1. User Interface:

- Clean and intuitive interface.
- Screen to enter the location (city or coordinates).
- Display of current weather conditions.
- 5-day weather forecast.

2.API Integration:

- Integration with OpenWeatherMap API.
- Graceful handling of API responses and errors.
- Asynchronous programming techniques for responsive UI.

3.Code Quality:

- Clean, readable, and maintainable Swift code.
- Adherence to Swift coding conventions and best practices.
- Proper error handling, avoiding force unwrapping and unnecessary force casts.
- Use of design patterns (e.g., MVVM) for code organization.

4.Solution Design:

- Modular and extensible codebase.
- Performance and memory usage optimization.
- Implementation of offline functionality.
- Sort functions for hourly and daily weather arrays.

Getting Started

* Clone the repository: git clone <repository-url>
* Open the Xcode project: cd <repository-folder> then open WeatherApp.xcodeproj
* Build and run the app in the Xcode simulator.

Dependencies

* Swift 5
* Xcode 12
* OpenWeatherMap API Key (required)

Configuration

* Acquire an API key from OpenWeatherMap.
* Open the Weather/Model/WeatherModel.swift file.
* Replace the placeholder <YOUR_API_KEY> with your actual API key.
