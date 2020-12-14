//
//  CurrentlyWeather.swift
//  Weather
//
//  Created by Liam on 9/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import Foundation

struct CurrentlyWeather: Codable {
    let currently: Currently
}

struct Currently: Codable {
    let time: Int
    let summary: String
    let icon: String
    let temperature: Double
    let windSpeed: Double
    let windBearing: Int
}
