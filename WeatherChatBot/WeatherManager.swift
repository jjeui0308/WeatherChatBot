//
//  WeatherManager.swift
//  WeatherChatBot
//
//  Created by USER on 2018. 9. 21..
//  Copyright © 2018년 practice. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import ForecastIO

class WeatherManager {
    private init() {}
    static let instance = WeatherManager()
    let client = DarkSkyClient(apiKey: "c4bb77c4cc1c434b1459eb3ee4883f65")
    
    public func request(with location: CLLocationCoordinate2D) {
        client.getForecast(latitude: location.latitude, longitude: location.longitude) { (result) in
            switch result {
            case .success(let forecast, let requestMetadata):
                print(forecast.daily?.summary)
            case .failure(let error):
                NSLog(error.localizedDescription)
            }
        }
    }
    
}
