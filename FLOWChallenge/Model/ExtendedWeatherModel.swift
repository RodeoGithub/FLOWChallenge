//
//  ExtendedWeatherModel.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 16/09/2022.
//

import Foundation

struct ExtendedWeatherModel {
    let responseCode: String
    let city: City
    let list: [WeatherList]

    var daysList: Dictionary<String,DayModel> {
        var days: Dictionary<String, DayModel> = [:]
        var used = [Int: Bool]()
        for i in 0..<6 {
            let day = Date().get(.day)
            used.updateValue(false, forKey: day+i)
        }
            print(used.keys.count)
        for item in list {
            let date = item.dt_txt
            let day = date.get(.day)
            if used[day] != nil {
                if !(used[day]!) {
                    days.updateValue(DayModel(main: item.main, weather: item.weather, date: item.dt_txt), forKey: "\(day)")
                    used.updateValue(true, forKey: day)
                }
            }
        }
        return days
    }
}
