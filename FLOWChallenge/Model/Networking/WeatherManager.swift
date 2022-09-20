//
//  WeatherManager.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 15/09/2022.
//

import Foundation
import CoreLocation

enum RequestType: String{
    case Current = "weather"
    case Forecast = "forecast"
}

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModel)
    func didUpdateExtendedWeather(_ weatherManager: WeatherManager,_ weather: ExtendedWeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let standardUserDefaults = UserDefaults.standard
    
    let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String, type: RequestType) {
        let Url = "\(baseURL)\(type.rawValue)?appid=\(K.API_KEY)&q=\(cityName)&units=\(standardUserDefaults.string(forKey: K.UserDefaultsKey.preferedUnits) ?? "metric")"
        let urlString = Url.replacingOccurrences(of: " ", with: "%20")
        
        performRequest(with: urlString, type: type)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, type: RequestType){
        let Url = "\(baseURL)\(type.rawValue)?appid=\(K.API_KEY)&lat=\(latitude)&lon=\(longitude)&units=\(standardUserDefaults.string(forKey: K.UserDefaultsKey.preferedUnits) ?? "metric")"
        let urlString = Url.replacingOccurrences(of: " ", with: "%20")
        
        performRequest(with: urlString, type: type)
    }
    
    
    func performRequest(with urlString: String, type: RequestType) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if type == .Current {
                        if let weather = self.parseCurrentWeatherJSON(safeData) {
                            DispatchQueue.main.async {
                                self.delegate?.didUpdateWeather(self, weather)
                            }
                        }
                    }
                    else if type == .Forecast {
                        if let weather = self.parseExtendedWeatherJSON(safeData) {
                            DispatchQueue.main.async {
                                self.delegate?.didUpdateExtendedWeather(self, weather)
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseCurrentWeatherJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrentWeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            let coord = decodedData.coord
            
            let feelsLike = decodedData.main.feels_like
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description, feelsLike:feelsLike, coordinates: coord)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseExtendedWeatherJSON(_ weatherData: Data) -> ExtendedWeatherModel? {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        do {
            let decodedData = try decoder.decode(ExtendedWeatherData.self, from: weatherData)
            
            let city = decodedData.city
            let cod = decodedData.cod
            let list = decodedData.list
            
            let extendedWeather = ExtendedWeatherModel(responseCode: cod, city: city, list: list)
            
            return extendedWeather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
