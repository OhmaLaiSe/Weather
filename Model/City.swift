//
//  City.swift
//  Weather
//
//  Created by Liam on 9/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import Foundation

struct SortedCities {
    // 'cities' are sorted in alphabetical order (A-Z) each instance
    let sortedCities: [City] = Cities.init().cities.sorted(by: { $0.city < $1.city })
}

struct Cities {
    let cities: [City] = [City(city: "Sydney", latitude: -33.8688, longitude: 151.2093),
                  City(city: "Melbourne", latitude: -37.8136, longitude: 144.9631),
                  City(city: "Edinburgh", latitude: 55.9533, longitude: -3.1883),
                  City(city: "London", latitude: 55.5074, longitude: -0.1278),
                  City(city: "Tokyo", latitude: 35.6762, longitude: 139.6503),
                  City(city: "Mexico City", latitude: 19.4326, longitude: -99.1332),
                  City(city: "New York", latitude: 40.7128, longitude: -74.0060),
                  City(city: "Los Angeles", latitude: 34.0522, longitude: -118.2437),
                  City(city: "Honolulu", latitude: 21.3069, longitude: -157.8583),
                  City(city: "Amsterdam", latitude: 52.3680, longitude: 4.9036),
                  City(city: "Berlin", latitude: 52.5200, longitude: 13.4050),
                  City(city: "Barcelona", latitude: 41.3851, longitude: 2.1734),
                  City(city: "Ho Chi Minh City", latitude: 10.8231, longitude: 106.6297),
                  City(city: "Tangier", latitude: 35.7595, longitude: -5.8340),
                  City(city: "Kathmandu", latitude: 27.7172, longitude: 85.3240),
                  City(city: "Hobart", latitude: -42.8821, longitude: 147.3272),
                  City(city: "Lima", latitude: -12.0464, longitude: -77.0428),
                  City(city: "Katoomba", latitude: -33.7125, longitude: 150.3119),
                  City(city: "Varanasi", latitude: 25.3176, longitude: 82.9739),
                  City(city: "San Francisco", latitude: 37.7749, longitude: -122.4194)]
 }

struct City: Codable {
    var city: String
    var latitude: Double
    var longitude: Double
}
