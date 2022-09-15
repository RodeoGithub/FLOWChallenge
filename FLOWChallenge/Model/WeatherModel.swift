//
//  WeatherModel.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 15/09/2022.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200..<233:
            return "cloud.bolt.rain"
        case 300..<322:
            return "cloud.drizzle"
        case 500..<532:
            return "cloud.rain"
        case 600..<623:
            return "cloud.snow"
        case 701..<782:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801..<805:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
