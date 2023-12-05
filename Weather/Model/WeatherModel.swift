//
//  WeatherModel.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import Foundation
import Combine

class WeatherModel {
    
    static let shared = WeatherModel()
    private let apiKey = "89575d3c850c4fe09a01e9aedf6aec9e"
    private let baseURL = "https://api.openweathermap.org/data/2.5"
    
    func getWeather() -> AnyPublisher<WeatherResponseVO, Error> {
        let url = URL(string: "\(baseURL)/weather?q=London&appid=\(apiKey)")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponseVO.self, decoder: JSONDecoder())
            .print("weather")
            .eraseToAnyPublisher()
    }
    
    var URL_LATITUDE = "16.871311"
    var URL_LONGITUDE = "96.19937"
    var URL_GET_ONE_CALL = ""
    
    func buildURL() -> String {
        URL_GET_ONE_CALL = "/onecall?lat=" + URL_LATITUDE + "&lon=" + URL_LONGITUDE + "&units=imperial" + "&appid=" + apiKey
        return baseURL + URL_GET_ONE_CALL
    }
    
    func setLatitude(_ latitude: String) {
        URL_LATITUDE = latitude
    }
    
    func setLatitude(_ latitude: Double) {
        setLatitude(String(latitude))
    }
    
    func setLongitude(_ longitude: String) {
        URL_LONGITUDE = longitude
    }
    
    func setLongitude(_ longitude: Double) {
        setLongitude(String(longitude))
    }
    
    func getOneCallWeather() -> AnyPublisher<Result, WeatherError> {
        if let cachedResult = CacheManager.shared.getCachedResult() {
            return Just(cachedResult)
                .setFailureType(to: WeatherError.self)
                .eraseToAnyPublisher()
        }
        
        guard let url = URL(string: buildURL()) else {
            return Fail(error: .urlError)
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw WeatherError.invalidResponse
                }
                return data
            }
            .decode(type: Result.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { res in
                CacheManager.shared.cacheResult(res)
            })
            .mapError { error in
                WeatherError.decodingError(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum WeatherError: Error {
    case urlError
    case invalidResponse
    case decodingError(Error)
}
