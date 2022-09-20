//
//  WeatherDetailViewController.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 14/09/2022.
//

import Foundation
import UIKit

class ExtendedWeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var weatherManager = WeatherManager()
    
    var days: Dictionary<String,DayModel> = [:]
    
    var daysArray: [Dictionary<String,DayModel>.Element] = []
    
    var currentCity: City?
    
    let userDefaults = UserDefaults.standard
    
    let spinner = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.title = currentCity?.name
        
        weatherManager.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.dayCellNibName, bundle: nil), forCellReuseIdentifier: K.dayCellIdentifier)
        
        createSpinnerView()
        
        if let safeCurrentCity = currentCity {
            weatherManager.fetchWeather(latitude: safeCurrentCity.coord.lat, longitude: safeCurrentCity.coord.lon, type: .Forecast)
        }
        else{
            removeSpinnerView()
            goBackError()
        }
    }
    
    func goBackError() {
        let dialogMessage = UIAlertController(title: "Error", message: K.goBackErrorMessage, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            _ = self.navigationController?.popViewController(animated: true)
         })
         
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
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

//MARK: - UITableViewDataSource

extension ExtendedWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if daysArray.count >= 6 {
            return daysArray.count-1
        }
        return daysArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.dayCellIdentifier, for: indexPath) as! DayCell
        
        var i = indexPath.row
        
        if daysArray.count >= 6 {
            i = i+1
        }
        
        let dateFormatter = DateFormatter()
        let cellDate = daysArray[i].value.date
        let cellDescription = daysArray[i].value.weather[0].description
        let cellIcon = UIImage(systemName: daysArray[i].value.conditionName)
        let cellMinTemp = daysArray[i].value.minTemperatureString
        let cellMaxTemp = daysArray[i].value.maxTemperatureString
        let cellHumidity = daysArray[i].value.humidityString
        cell.dayLabel.text = dateFormatter.shortWeekdaySymbols[Calendar.current.component(.weekday, from: cellDate) - 1]
        
        cell.descriptionLabel.text = cellDescription.capitalized
        cell.dayIcon.image = cellIcon
        cell.minTemperatureLabel.text = cellMinTemp
        cell.maxTemperatureLabel.text = cellMaxTemp
        cell.humidityLabel.text = cellHumidity
        
        return cell
    }

}

//MARK: - WeatherManagerDelegate

extension ExtendedWeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        //
    }
    
    func didUpdateExtendedWeather(_ weatherManager: WeatherManager, _ weather: ExtendedWeatherModel) {
        days = weather.daysList
        daysArray = days.sorted(by: { $0.0 < $1.0 })
        
        for day in daysArray {
            print(day.key)
        }
        
        tableView.reloadData()
        removeSpinnerView()
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
