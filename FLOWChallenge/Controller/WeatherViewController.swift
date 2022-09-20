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
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var seeForecastButton: UIButton!
    let userDefaults = UserDefaults.standard
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    let spinner = SpinnerViewController()
    
    var currentCity: City? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.title = K.appName
        
        iconImage.image = UIImage(systemName: "cloud.sun")
        cityLabel.text = userDefaults.string(forKey: K.UserDefaultsKey.lastCityName)
        temperatureLabel.text = userDefaults.string(forKey: K.UserDefaultsKey.lastTemperature)
        seeForecastButton.titleLabel?.text = K.seeForecastButtonText
        seeForecastButton.imageView?.image = UIImage(systemName: "chevron.forward")
        
        locationManager.delegate = self
        searchBarField.delegate = self
        weatherManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func goToForecast(_ sender: UIButton) {
        performSegue(withIdentifier: K.goToForecastSegueIdentifier, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.goToForecastSegueIdentifier {
            if let VC = segue.destination as? ExtendedWeatherViewController {
                VC.currentCity = currentCity
            }
        }
    }
    
    func createSpinnerView() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    func removeSpinnerView() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}

//MARK: - SearchBarDelegate

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        }
        else {
            searchBarField.placeholder = K.searchPlaceholder
            return false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let city = searchBarField.text {
            weatherManager.fetchWeather(cityName: city, type: .Current)
        }
        searchBarField.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarTextDidEndEditing(searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }

}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateExtendedWeather(_ weatherManager: WeatherManager, _ weather: ExtendedWeatherModel) {
        
    }
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel){
        let capitalizedDescription = weather.description.capitalized
        let iconImageName = weather.conditionName
        cityLabel.text = weather.cityName
        temperatureLabel.text = weather.temperatureString
        iconImage.image = UIImage(systemName: iconImageName)
        descriptionLabel.text = capitalizedDescription
        
        
        userDefaults.set([weather.coordinates.lat,weather.coordinates.lon], forKey: K.UserDefaultsKey.lastLocation)
        userDefaults.set(capitalizedDescription, forKey: K.UserDefaultsKey.lastDescription)
        userDefaults.set(weather.conditionName, forKey: K.UserDefaultsKey.lastIcon)
        userDefaults.set(weather.cityName, forKey: K.UserDefaultsKey.lastCityName)
        
        userDefaults.synchronize()
        currentCity = City(name: weather.cityName, country: nil, coord: weather.coordinates)
        
        removeSpinnerView()
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.removeSpinnerView()
            let dialogMessage = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon, type: .Current)
            createSpinnerView()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let dialogMessage = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
         
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    @IBAction func gpsButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}
