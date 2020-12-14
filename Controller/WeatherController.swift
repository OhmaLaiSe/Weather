//
//  WeatherController.swift
//  Weather
//
//  Created by Liam on 9/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import Foundation
import UIKit

struct WeatherController: Codable {
    // fetchCurrentlyWeather() fetches the 'Currently' data from Dark Sky API and completes a CurrentlyWeather object
    func fetchCurrentlyWeather(forCity cityName: City, completion: @escaping (CurrentlyWeather) -> Void) {
        if let url = URL(string: URLQuery.init().getCurrentlyQuery(cityName: cityName)) {
            let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5)
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
                if let data = data,
                    let currentlyWeather = try? jsonDecoder.decode(CurrentlyWeather.self, from: data) {
                    completion(currentlyWeather)
                } else {
                    DispatchQueue.main.async {
                        if let errorString = error?.localizedDescription {
                            self.showAlert(error: errorString)
                        }
                    }
                }
            }
            task.resume()
        }
    }

    func fetchWeeklyWeather(forCity cityName: City, completion: @escaping (WeeklyWeather) -> Void) {
        // fetchWeeklyWeather() fetches the 'Daily' data from Dark Sky API and completes a WeeklyWeather object
        if let url = URL(string: URLQuery.init().getWeeklyQuery(cityName: cityName)) {
            let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5)
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                if let data = data,
                    let weeklyWeather = try? jsonDecoder.decode(WeeklyWeather.self, from: data) {
                    completion(weeklyWeather)
                } else {
                    DispatchQueue.main.async {
                        if let errorString = error?.localizedDescription {
                            self.showAlert(error: errorString)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func showAlert(error: String) {
        // showAlert() presents the Error alert defined in Extensions.swift to the user when fetchCurrentlyWeather() or fetchWeeklyWeather() is unable to retrieve data from Dark Sky API with a timeoutInterval of 5 seconds
        let presentViewController = UIApplication.shared.keyWindow?.rootViewController
        presentViewController?.showAlert(error: error)
    }
}
