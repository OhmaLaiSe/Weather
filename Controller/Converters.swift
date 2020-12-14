//
//  Converters.swift
//  Weather
//
//  Created by Liam on 13/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import Foundation

class Converters {
    static func convertToCelsius(fahrenheit: Double) -> String {
        // convertToCelsius() converts the temperature data from Dark Sky API from fahrenheit to celcius
        let celcius = (fahrenheit - 32) / 1.8
        let formattedCelcius = String(format: "%.0fC", celcius)
        return formattedCelcius
    }
    
    static func convertToKilometresPerHour(milesPerHour: Double) -> String {
        // convertToKilometresPerHour() converts the windSpeed data from Dark Sky API from miles per hour to kilometres per hour
        let kilometresPerHour = milesPerHour * 1.609344
        let formattedKilometresPerHour = String(format: "%.0fkm/h", kilometresPerHour)
        return formattedKilometresPerHour
    }
    
    static func convertUnixTimeToDate(unixTime: Int) -> String {
        // convertUnixTimeToDate() converts the Unix timestamp from Dark Sky API to a formatted date
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMM"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
