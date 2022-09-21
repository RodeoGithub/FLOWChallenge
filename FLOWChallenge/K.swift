//
//  K.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 15/09/2022.
//

import Foundation

struct K {
    static let API_KEY = "984118782944354ff46ce75f62eb8c73"
    static let unit = "metric"
    static let dayCellIdentifier = "DayWeatherCell"
    static let dayCellNibName = "DayCell"
    static let goToForecastSegueIdentifier = "showForecast"
    static let WeekdaysStrings = ["Saturday",
                                  "Sunday",
                                  "Monday",
                                  "Tuesday",
                                  "Wednesday",
                                  "Thursday",
                                  "Friday",
                                  "Saturday"]
    struct UserDefaultsKey {
        static let lastLocation = "LastLocation"
        static let lastDescription = "LastDescription"
        static let lastTemperature = "LastTemperature"
        static let preferedUnits = "Units"
        static let hasLaunchedOnce = "HasLaunchedOnce"
        static let lastIcon = "LastIcon"
        static let lastCityName = "LastCityName"
        
    }
    static let buenosAiresCoord = [-34.6132,-58.3772]
    static let seeForecastButtonText = "See Forecast"
    static let searchPlaceholder = "Search a city..."
    static let goBackErrorMessage = "An error occurred, Please try again."
    static let appName = "Flow Challenge"
}
