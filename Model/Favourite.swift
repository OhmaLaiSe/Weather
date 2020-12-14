//
//  Favourite.swift
//  Weather
//
//  Created by Liam on 10/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import Foundation

class Favourite: Codable {
    var city: City
    var forecastType: String
    
    // Sets the location and name for favourite.plist
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("favourite").appendingPathExtension("plist")
    
    init(city: City, forecastType: String) {
        self.city = city
        self.forecastType = forecastType
    }
    
    static func saveToFile(favourite: Favourite) {
        // saveToFile() saves a Favourite forecast to favourite.plist
        let encoder = PropertyListEncoder()
        let codedFavourite = try? encoder.encode(favourite)
        try? codedFavourite?.write(to: ArchiveURL, options: .noFileProtection)
    }

    static func loadFromFile() -> Favourite?  {
        // loadFromFile() retrieves a saved Favourite forecast from favourite.plist
        guard let codedFavourite = try? Data(contentsOf: ArchiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Favourite.self, from: codedFavourite)        
    }
}
