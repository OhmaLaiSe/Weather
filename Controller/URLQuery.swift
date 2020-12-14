//
//  URLQuery.swift
//  Weather
//
//  Created by Liam on 14/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import Foundation

struct URLQuery {
    let baseURL = "https://api.darksky.net/forecast"
    let key = "191fa2c9bd28a5534d91249b8c244653"
    let currentlyQuery = "?exclude=minutely,hourly,daily,alerts,flags"
    let weeklyQuery = "?exclude=currently,minutely,hourly,alerts,flags"

    func getCurrentlyQuery(cityName: City) -> String {
        // getCurrentlyQuery() returns the URL for retrieving the 'Currently' data from Dark Sky API as a String which is used for Current weather
        let string = "\(baseURL)/\(key)/\(cityName.latitude),\(cityName.longitude)\(currentlyQuery)"
        return string
    }
    
    func getWeeklyQuery(cityName: City) -> String {
        // getWeeklyQuery() returns the URL for retrieving the 'Daily' data from Dark Sky API as a String which is used for both the 24-hour and 7-day forecasts
        let string = "\(baseURL)/\(key)/\(cityName.latitude),\(cityName.longitude)\(weeklyQuery)"
        return string
    }
}
