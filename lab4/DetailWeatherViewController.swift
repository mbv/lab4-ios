//
//  DetailWeatherViewController.swift
//  lab4
//
//  Created by Konstantin Terehov on 3/17/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailWeatherViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var cityInfo: CityAnnotation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if cityInfo != nil {
            let city = cityInfo!
            mapView.addAnnotation(city)
            mapView.selectAnnotation(city, animated: true)
            
            let region = MKCoordinateRegionMake(city.coordinate, MKCoordinateSpanMake(1, 1))
            
            mapView.setRegion(region, animated: true)
        }
    }

}
