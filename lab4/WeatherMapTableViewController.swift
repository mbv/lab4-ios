//
//  WeatherMapTableViewController.swift
//  lab4
//
//  Created by Konstantin Terehov on 3/17/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class WeatherMapTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WeatherReloadAsyncDelegate, ShowErrorDelegate {
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var weatherModel : WeatherModel? = WeatherModel.sharedInstance
    let alertController = UIAlertController(title: "Error", message: "Can't get weather info", preferredStyle: .alert)
    
    
    func reloadWeather() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onError() {
        self.refreshControl.endRefreshing()
    }
    
    private func setActionForAlertController() {
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
    }
    
    func showError() {
        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setActionForAlertController()
        self.tableView.dataSource = self
        self.tableView.delegate = self

        weatherModel?.addReloadDelegate(reloadDelegate: self)
        weatherModel?.setErrorDelegate(errorDelegate: self)
        weatherModel?.refresh()
        
        refreshControl.addTarget(self, action: #selector(WeatherMapTableViewController.startRefresh), for: UIControlEvents.valueChanged)
        self.tableView?.addSubview(refreshControl)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func startRefresh() {
        weatherModel!.refresh()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherModel!.weatherCities.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        let cityWeather = weatherModel!.weatherCities[indexPath.row]
        cell.textLabel?.text = cityWeather.cityName
        cell.detailTextLabel?.text = cityWeather.temperature
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.traitCollection.verticalSizeClass == .compact) {
            mapView.removeAnnotations(mapView.annotations);
            
            let city = getSelectedCityAnnotation()
            mapView.addAnnotation(city)
            mapView.selectAnnotation(city, animated: true)
            
            let region = MKCoordinateRegionMake(city.coordinate, MKCoordinateSpanMake(1, 1))
            
            mapView.setRegion(region, animated: true)
        } else {
            performSegue(withIdentifier: "segueShowDetailWeather", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueShowDetailWeather") {
            let detailViewController = segue.destination as! DetailWeatherViewController
            
            detailViewController.cityInfo = getSelectedCityAnnotation()
        }
    }
    
    func getSelectedCityAnnotation() -> CityAnnotation {
        let cityWeather = weatherModel!.weatherCities[(self.tableView.indexPathForSelectedRow?.row)!]
        let city = CityAnnotation(coordinate: cityWeather.location.coordinate)
        city.title = cityWeather.cityName
        city.subtitle = cityWeather.temperature
        return city
    }

}
