//
//  ChangeCityViewController.swift
//  MyWeatherApp
//
//  Created by Jovial on 2/11/20.
//  Copyright © 2020 Rajkishore. All rights reserved.
//

import UIKit

// protocol declaration
protocol  ChangeCityDelegate {
    func userEnterNewCityName(city:String)
    
    
}
class ChangeCityViewController: UIViewController {

    var delegate:ChangeCityDelegate?
//    let vc = ChangeCityViewController
    
    @IBOutlet weak var cityTextField: UITextField!
//    @IBOutlet weak var getWeather: UIButton!
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
////        self.present(vc, animated: true, completion: nil)
//        // Do any additional setup after loading the view.
//        
//    }
    @IBAction func backToCurrent(_ sender: Any) {
        
         dismiss(animated: true, completion:nil)
        
    }
    
     
    
 
    
    
    
    
    @IBAction func getWeatherButton(_ sender: Any) {
        
        let cityName = cityTextField.text!
        
        delegate?.userEnterNewCityName(city: cityName)
        
         dismiss(animated: true, completion:nil)
        
    }
    
}
    
    
   

