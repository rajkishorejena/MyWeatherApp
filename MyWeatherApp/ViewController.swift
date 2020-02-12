//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Jovial on 2/11/20.
//  Copyright © 2020 Rajkishore. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,CLLocationManagerDelegate ,ChangeCityDelegate {
    
    
    @IBOutlet weak var tempratureLbl: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var citynameLbl: UILabel!
    let Wether_url = "http://api.openweathermap.org/data/2.5/weather"
    let App_id = "82fb2d715074aca6593cada1793b29ba"

    // Declaring instance Variable
    let locationManager = CLLocationManager()
    let weatherDataModel =  WeatherDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    

    @IBAction func onClickSecondView(_ sender: UIButton){
//        let vc = ChangeCityViewController()
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(vc, animated: true, completion: nil)
//
        let secondViewPage = storyboard?.instantiateViewController(identifier: "ChangeCityViewController") as! ChangeCityViewController
        secondViewPage.delegate = self
       present(secondViewPage, animated: true, completion: nil)

    }

    
    
     
    
    
    
    
    //getWeatherData Method
    func getWeatherData(url:String, parameters:[String:String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            responce in
            if responce.result.isSuccess{
                print("Sucess! Go to the Weather Data")
                
                let weatherJSON : JSON = JSON(responce.result.value!)
          //      print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
            }
            else{
            //    print("Error \(responce.result.error)")
                self.citynameLbl.text = "Connection issues"
            }
        }
        
    }
    
    
    // updateWeatherData Method
    
    func updateWeatherData(json:JSON)
    {
        if let tempResult = json["main"]["temp"].double {
        weatherDataModel.temperature = Int(tempResult - 273.15)
        
        weatherDataModel.city = json["name"].stringValue
        
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        
        weatherDataModel.weatherIconeName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUserData()
            
    }
        else {
            citynameLbl.text = "Weather Unavailable"
        }
}
    @IBAction func moveButton(_ sender: Any) {
        
    }
    
    
    //update the location(didupdatewithlocation)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let parameter:[String:String] = ["lat":latitude, "lon":longitude, "appid":App_id]
            
            getWeatherData(url:Wether_url, parameters:parameter)
        }
    }
    // didFailWithError
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        citynameLbl.text = "Lcation Unavailable"
    }
    
    //UI Update
    func updateUserData()
    {
        citynameLbl.text = weatherDataModel.city
        tempratureLbl.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named:weatherDataModel.weatherIconeName)
    }
    
    
    
    func userEnterNewCityName(city:String){
        let parameter:[String:String] = ["q":city,"appid": App_id]
        getWeatherData(url: Wether_url, parameters: parameter)
        }
        
    
    //preparedForSegue
    

    
}

