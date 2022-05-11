//
//  ViewController.swift
//  The Weather App
//
//  Created by Артём Симан on 9.05.22.
//

import UIKit
import Rswift
import Alamofire
import SwiftyJSON
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var weatherInfo: UILabel!
    
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    let locationManager = CLLocationManager()
    var dataWeather = DataWeather()
    
//    let baseUrl = "https://openweathermap.org"
//    let apiKey = "dad90239facaa5d342519564d6856c33"
    override func viewDidLoad() {
        super.viewDidLoad()
        useLocationManager()
    }
    
    func useLocationManager() {
        locationManager.requestWhenInUseAuthorization()
       
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateView() {
        city.text = dataWeather.name
        weatherInfo.text = DataSource.weatherIDs[dataWeather.weather[0].id]
        temperature.text = dataWeather.main.temp.description + "°"
        weatherIcon.image = UIImage(named: dataWeather.weather[0].icon)
    }
    
    func updateWeatherInfo(latitude: Double, longtitude: Double) {
        let session = URLSession.shared
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=53.9&lon=27.5667&appid=dad90239facaa5d342519564d6856c33")!
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("DataTask error: \(error!.localizedDescription)")
                return
            }

            do {
                self.dataWeather = try JSONDecoder().decode(DataWeather.self, from: data!)
                DispatchQueue.main.async {
                    self.updateView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude)
        }
    }
}









//    func loadWeatherData(city: String, completion: @escaping () -> Void ) {
//        let path = "/data/2.5/forecast"
//
//        let parameters: Parameters = [
//            "q": city,
//            "units": "metric",
//            "appid": apiKey]
//        let url = baseUrl+path
//
//        AF.request(url, method: .get, parameters: parameters).responseData {
//            [weak self] response in
//            if let status = response.response?.statusCode {
//                guard (200..<300).contains(status) else{
//                    print("Wrong response status: \(status)")
//                    return
//                }
//            }
//            do {
//                let json = try JSON(data: data)
//                print(json["list"])
//                completion()
//            } catch {
//                print(error)
//            }
//        }
//    }
