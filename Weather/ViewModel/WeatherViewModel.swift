//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import Foundation
import Combine

class WeatherViewModel: BaseViewModel {
    
    @Published var weather: WeatherResponseVO?
    @Published var weatherResult: Result?
    
    var cancellables: Set<AnyCancellable> = []
    
    private let weatherModel = WeatherModel()
    
    func fetchWeather() {
        weatherModel.getWeather()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] weather in
                self?.weather = weather
            })
            .store(in: &bindings)
    }
    
    func fetchOneCallWeather() {
        weatherModel.getOneCallWeather()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { result in
                self.weatherResult = result
            })
            .store(in: &bindings)
    }
    
}
