//
//  DayModel.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 18/09/2022.
//

import Foundation

struct DayModel {
    let main: Main
    let weather: [Weather]
    let date: Date
    var minTemperatureString: String {
        return String(format: "%.1f", main.temp_min)
    }
    var maxTemperatureString: String {
        return String(format: "%.1f", main.temp_max)
    }
    var temperatureString: String {
        return String(format: "%.1f", main.temp)
    }
    var humidityString: String {
        return "\(main.humidity)%"
    }
    
    var conditionName: String {
        switch weather[0].id {
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
            return "cloud.sun"
        }
    }
}
