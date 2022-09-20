//
//  CurrentWeatherData.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 15/09/2022.
//

import Foundation

struct CurrentWeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
    let coord: Coordinate
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}
