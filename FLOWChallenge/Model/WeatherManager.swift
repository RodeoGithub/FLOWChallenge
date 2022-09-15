//
//  WeatherManager.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 15/09/2022.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid={API key}"
    
    let weather5DaysURL = "https://api.openweathermap.org/data/2.5/forecast?appid={API key}"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let baseUrl = "\(weatherURL)&q=\(cityName)"
        let urlString = baseUrl.replacingOccurrences(of: " ", with: "%20")
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let baseUrl = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        let urlString = baseUrl.replacingOccurrences(of: " ", with: "%20")
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateWeather(self, weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrentWeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description)
            
            print(weather)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
