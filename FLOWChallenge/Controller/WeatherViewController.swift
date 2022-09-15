//
//  WeatherViewController.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 14/09/2022.
//

import Foundation
import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchBarField: UISearchBar!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var weatherManager = WeatherManager()
    //let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locationManager.delegate = self
        searchBarField.delegate = self
        //weatherManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        //locationManager.requestLocation()
    }
    
}

//MARK: - SearchBarDelegate

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search button clicked")
        searchBarTextDidEndEditing(searchBar)
    }
    /*
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarField.endEditing(true)
        return true
    }*/
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        }
        else {
            searchBarField.placeholder = "Search a city..."
            return false
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let city = searchBarField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchBarField.text = ""
    }
    /*
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
 */
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel){
        cityLabel.text = weather.cityName
        temperatureLabel.text = weather.temperatureString
        //conditionImageView.image = UIImage(systemName: weather.conditionName)
        descriptionLabel.text = weather.description.capitalized
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
