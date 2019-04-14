//
//  ViewController.swift
//  SeattleWeatherApp
//
//  Created by Ashish on 2/13/19.
//  Copyright © 2019 Ashish. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityProtocol {
    
    
    func ChangeCityFunction(cityName: String) {
        print("User selected this city: \(cityName)")
        let params: [String:String] = ["q": cityName,"appid": appid ]
        
        GetWeatherData(url: API_URL, params: params )
    }
    

    let API_URL = "http://api.openweathermap.org/data/2.5/weather"
    let appid = "0e604e8bb5ff63a664f1d0f8a972ff99"
    
    
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblWeatherCondition: UILabel!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    let locationManager = CLLocationManager()
    let weatherModel = WeatherModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    @IBAction func ChangeCityButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ChangeCitySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let changeCityController = segue.destination as! ChangeCityViewController
        changeCityController.delegate = self
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            let lat = String(location.coordinate.latitude)
            let lng = String(location.coordinate.longitude)
            print("lat: \(lat) lng: \(lng)")
            
            let params: [String:String] = ["lat": lat, "lon": lng, "appid": appid ]
            
            GetWeatherData(url: API_URL, params: params )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        self.lblCityName.text = "--"
        self.lblTemperature.text = "--"
        self.lblWeatherCondition.text = "No Location Detected"
    }
    
    
    func GetWeatherData(url : String, params: [String: String]){
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON{
            response in
            if response.result.isSuccess{
                print("Successfully got weather data")
                let weatherJSON: JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.UpdateWeatherModel(json: weatherJSON)
            }else{
                print("Unable to get weather data")
                let jsonError = String(describing: response.result.error)
                print(jsonError)
                
                self.lblCityName.text = "--"
                self.lblTemperature.text = "--"
                self.lblWeatherCondition.text = "Network Error"
                
            }
        }
    }
    
    func UpdateWeatherModel(json: JSON){
        
        let kelvinTemp = json["main"]["temp"].doubleValue
        weatherModel.temperature = Int(kelvinTemp - 273.15)
        weatherModel.cityName = json["name"].stringValue
        weatherModel.weatherCondition = json["weather"][0]["main"].stringValue
        
        self.lblCityName.text =  weatherModel.cityName
        self.lblTemperature.text = String("\(weatherModel.temperature) ℃")
        self.lblWeatherCondition.text = weatherModel.weatherCondition

    }
    
    

    


}

