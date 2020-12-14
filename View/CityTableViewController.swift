//
//  CityTableViewController.swift
//  Weather
//
//  Created by Liam on 9/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {
    var city: City?
    var forecastType: String?
    let sortedCities = SortedCities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segueToFavourite()
    }
    
    func segueToFavourite() {
        // performSegue() will be called to send the user to their favourite forecast saved in favourite.plist
        // favourite.plist is created with dummy data if this is the first time running the app
        if let favourite = Favourite.loadFromFile() {
            city = favourite.city
            forecastType = favourite.forecastType
            
            if favourite.forecastType == "currently" {
                performSegue(withIdentifier: "FavouriteCurrentlySegue", sender: Any?.self)
            } else if favourite.forecastType == "daily" {
                performSegue(withIdentifier: "FavouriteWeeklySegue", sender: Any?.self)
            } else if favourite.forecastType == "weekly" {
                performSegue(withIdentifier: "FavouriteWeeklySegue", sender: Any?.self)
            }
        } else {
            let favourite = Favourite(city: City(city: "", latitude: 0, longitude: 0), forecastType: "")
            Favourite.saveToFile(favourite: favourite)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedCities.sortedCities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let cityString = sortedCities.sortedCities[indexPath.row].city
        cell.textLabel?.text = cityString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectForecastSegue" {
            let selectForecastViewController = segue.destination as! SelectForecastViewController
            let index = tableView.indexPathForSelectedRow!.row
            selectForecastViewController.city = sortedCities.sortedCities[index]
        } else if segue.identifier == "FavouriteCurrentlySegue" {
            let currentlyWeatherViewController = segue.destination as! CurrentlyWeatherViewController
            currentlyWeatherViewController.city = city
        } else if segue.identifier == "FavouriteWeeklySegue" {
            let weeklyWeatherTableViewController = segue.destination as! WeeklyWeatherTableViewController
            weeklyWeatherTableViewController.city = city
            weeklyWeatherTableViewController.forecastType = forecastType
        }
    }
}
