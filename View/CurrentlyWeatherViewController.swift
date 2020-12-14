//
//  CurrentlyWeatherViewController.swift
//  Weather
//
//  Created by Liam on 9/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import UIKit

class CurrentlyWeatherViewController: UIViewController {
    var city: City!
    let weatherController = WeatherController()


    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBAction func favouriteButtonTouchDown(_ sender: UIButton) {
        // favouriteButton can add or remove a favourite forecast
        // favouriteButton animates and alternates colour (between blue and gray) on TouchDown
        UIView.animate(withDuration: 0.25) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
        if let savedFavourite = Favourite.loadFromFile() {
            if savedFavourite.forecastType == "currently" && savedFavourite.city.city == self.city.city {
                let favourite = Favourite(city: City(city: "", latitude: 0, longitude: 0), forecastType: "")
                Favourite.saveToFile(favourite: favourite)
                sender.backgroundColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
            } else {
                let favourite = Favourite(city: self.city, forecastType: "currently")
                Favourite.saveToFile(favourite: favourite)
                sender.backgroundColor = .gray
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForFavourite()
        updateUI()
    }
    
    func checkForFavourite() {
        // favouriteButton is set to '.gray' when the favourite forecast is opened
        if let savedFavourite = Favourite.loadFromFile() {
            if savedFavourite.forecastType == "currently" && savedFavourite.city.city == self.city.city {
                favouriteButton.backgroundColor = .gray
            }
        }
    }
    
    func updateUI() {
        // Retrieves 'Currently' data from Dark Sky API and updates the UI
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        weatherController.fetchCurrentlyWeather(forCity: self.city) { (currentlyWeather) in
            DispatchQueue.main.async {
                self.cityLabel.text = "\(self.city.city)"
                self.dateLabel.text = Converters.convertUnixTimeToDate(unixTime: currentlyWeather.currently.time)
                self.weatherImage.image = UIImage(named: "\(currentlyWeather.currently.icon)")
                self.temperatureLabel.text = "\(Converters.convertToCelsius(fahrenheit: currentlyWeather.currently.temperature))"
                self.summaryLabel.text = "\(currentlyWeather.currently.summary)"
                self.windDirectionLabel.text = "Wind direction: \(currentlyWeather.currently.windBearing)°"
                self.windSpeedLabel.text = "Wind speed: \(Converters.convertToKilometresPerHour(milesPerHour: currentlyWeather.currently.windSpeed))"
                UIView.animate(withDuration: 1.5, delay: 0.0, options: [.repeat, .autoreverse], animations: {
                    self.weatherImage.transform = CGAffineTransform(rotationAngle: -0.2)
                    self.weatherImage.transform = CGAffineTransform(rotationAngle: 0.2)
                    
                }, completion: nil)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
