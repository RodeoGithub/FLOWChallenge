//
//  ExtendedWeatherData.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 16/09/2022.
//

import Foundation

struct ExtendedWeatherData: Decodable {
    let cod: String
    let list: [WeatherList]
    let city: City
}

struct WeatherList: Decodable {
    let main: Main
    let weather: [Weather]
    let dt_txt: Date
}

struct City: Decodable {
    let name: String
    let country: String?
    let coord: Coordinate
}

struct Coordinate: Decodable {
    let lat: Double
    let lon: Double
}
