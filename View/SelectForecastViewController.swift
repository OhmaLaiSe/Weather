//
//  SelectForecastViewController.swift
//  Weather
//
//  Created by Liam on 10/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import UIKit

class SelectForecastViewController: UIViewController {
    var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // CurrentlyWeatherSegue segues to CurrentlyWeatherViewController with only 'city'
        // DailyWeatherSegue and WeeklyWeatherSegue both segue to CurrentlyWeatherViewController but with a different 'forecastType'
        if segue.identifier == "CurrentlyWeatherSegue" {
            let currentlyWeatherViewController = segue.destination as! CurrentlyWeatherViewController
            currentlyWeatherViewController.city = city
        } else if segue.identifier == "DailyWeatherSegue" {
            let weeklyWeatherTableViewController = segue.destination as! WeeklyWeatherTableViewController
            weeklyWeatherTableViewController.city = city
            weeklyWeatherTableViewController.forecastType = "daily"
        } else if segue.identifier == "WeeklyWeatherSegue" {
            let weeklyWeatherTableViewController = segue.destination as! WeeklyWeatherTableViewController
            weeklyWeatherTableViewController.city = city
            weeklyWeatherTableViewController.forecastType = "weekly"
        }
    }
}
