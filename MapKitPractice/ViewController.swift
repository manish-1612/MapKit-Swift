//
//  ViewController.swift
//  MapKitPractice
//
//  Created by Manish Kumar on 24/08/15.
//  Copyright (c) 2015 Innofied Solutions Pvt. Ltd. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var locationArray: [CLLocationCoordinate2D] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        
        // user activated automatic attraction info mode
        var status = CLLocationManager.authorizationStatus()
        if status == .NotDetermined || status == .Denied || status == .AuthorizedWhenInUse {
            // present an alert indicating location authorization required
            // and offer to take the user to Settings for the app via
            // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType(rawValue: 0)!
        mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        mapView.showsBuildings = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        mapView.mapType = MKMapType(rawValue: 2)!
    }
    
    
    override func viewWillAppear(animated: Bool) {
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        locationManager.stopUpdatingHeading()
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        //code for user tracking
        var userCoordinate = newLocation.coordinate
        
        if let userCoordinateNew = userCoordinate as CLLocationCoordinate2D? {
            locationArray.append(CLLocationCoordinate2DMake(userCoordinateNew.latitude, userCoordinateNew.longitude))
        }
        
        /*
        for coordinate in locationArray{
            println("coordinate : \(coordinate.latitude),\(coordinate.longitude)")
        }*/
    }
    
    @IBAction func showRouteCovered(sender: AnyObject) {
        self .performSegueWithIdentifier("routeSegue", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "routeSegue" {
            var routeController : RouteVC = segue.destinationViewController as! RouteVC
            
            if routeController .isKindOfClass(RouteVC){
                routeController.arrayForLocation = locationArray
            }
        }
    }
}
