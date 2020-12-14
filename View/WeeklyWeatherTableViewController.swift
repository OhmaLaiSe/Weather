//
//  WeeklyWeatherTableViewController.swift
//  Weather
//
//  Created by Liam on 10/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import UIKit

class WeeklyWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureHighLabel: UILabel!
    @IBOutlet weak var temperatureLowLabel: UILabel!
    @IBOutlet weak var windBearingLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
}

class WeeklyWeatherTableViewController: UITableViewController {
    var city: City!
    var forecastType: String!
    let weatherController = WeatherController()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBAction func favouriteButtonTouchDown(_ sender: UIButton) {
        // favouriteButton can add or remove a favourite forecast
        // favouriteButton animates and alternates colour (between blue and gray) on TouchDown
        UIView.animate(withDuration: 0.25) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        if let savedFavourite = Favourite.loadFromFile() {
            if savedFavourite.forecastType == self.forecastType && savedFavourite.city.city == self.city.city {
                let favourite = Favourite(city: City(city: "", latitude: 0, longitude: 0), forecastType: "")
                Favourite.saveToFile(favourite: favourite)
                sender.backgroundColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
            } else {
                let favourite = Favourite(city: self.city, forecastType: self.forecastType)
                Favourite.saveToFile(favourite: favourite)
                sender.backgroundColor = .gray
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        checkForFavourite()
    }

    func setTitle() {
        // Sets the correct title for the forecast type
        cityLabel.text = "\(city.city)"
        if forecastType == "weekly" {
            self.title = "7-day forecast"
        } else if forecastType == "daily" {
            self.title = "24-hour forecast"
        }
    }
    
    func checkForFavourite() {
        // favouriteButton is set to '.gray' when the favourite forecast is opened
        if let savedFavourite = Favourite.loadFromFile() {
            if savedFavourite.forecastType == self.forecastType && savedFavourite.city.city == self.city.city {
                favouriteButton.backgroundColor = .gray
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Determines if 1 row (24-hour forecast) or 7 rows (7-day forecast) is required depending on 'forecastType'
        var rows = 0
        if forecastType == "weekly" {
            rows = 7
        } else if forecastType == "daily" {
            rows = 1
        }
        return rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyWeatherCell", for: indexPath) as! WeeklyWeatherTableViewCell
        updateUI(row: indexPath.row, cell: cell)
        return cell
    }
    
    func updateUI(row: Int, cell: WeeklyWeatherTableViewCell) {
        // Retrieves 'Daily' data from Dark Sky API and updates WeeklyWeatherTableViewCell
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        weatherController.fetchWeeklyWeather(forCity: city) { (weeklyWeather) in
            DispatchQueue.main.async {
                cell.dateLabel?.text = Converters.convertUnixTimeToDate(unixTime: weeklyWeather.daily.data[row].time)
                cell.weatherImage?.image = UIImage(named: "\(weeklyWeather.daily.data[row].icon)")
                cell.temperatureHighLabel?.text = "High: \(Converters.convertToCelsius(fahrenheit: weeklyWeather.daily.data[row].temperatureHigh))"
                cell.temperatureLowLabel?.text = "Low: \(Converters.convertToCelsius(fahrenheit: weeklyWeather.daily.data[row].temperatureLow))"
                cell.summaryLabel?.text = "\(weeklyWeather.daily.data[row].summary)"
                cell.windBearingLabel?.text = "Wind direction: \(weeklyWeather.daily.data[row].windBearing)°"
                cell.windSpeedLabel?.text = "Wind speed: \(Converters.convertToKilometresPerHour(milesPerHour: weeklyWeather.daily.data[row].windSpeed))"
                UIView.animate(withDuration: 1.5, delay: 0.0, options: [.repeat, .autoreverse], animations: {
                    cell.weatherImage?.transform = CGAffineTransform(rotationAngle: -0.2)
                    cell.weatherImage?.transform = CGAffineTransform(rotationAngle: 0.2)
                }, completion: nil)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
