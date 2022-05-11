//
//  ModelsData.swift
//  The Weather App
//
//  Created by Артём Симан on 10.05.22.
//

import Foundation

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double = 0.0
    var feels_like: Double = 0.0
    var pressure: Int = 0
    var humidity: Int = 0
    
}

struct DataWeather: Codable {
    var weather: [Weather] = []
    var main: Main = Main()
    var name: String = ""
}
