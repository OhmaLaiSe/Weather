//
//  WeeklyWeather.swift
//  Weather
//
//  Created by Liam on 9/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import Foundation

struct WeeklyWeather: Codable {
    let daily: DailyWeather
}

struct DailyWeather: Codable {
    let data: [Daily]
}

struct Daily: Codable {
    let time: Int
    let summary: String
    let icon: String
    let temperatureHigh: Double
    let temperatureLow: Double
    let windBearing: Int
    let windSpeed: Double
}
