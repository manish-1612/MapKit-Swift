//
//  RouteVC.swift
//  MapKitPractice
//
//  Created by Manish Kumar on 25/08/15.
//  Copyright (c) 2015 Innofied Solutions Pvt. Ltd. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RouteVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapview: MKMapView!
    var arrayForLocation: [CLLocationCoordinate2D] = []
    
    // MARK :- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapview.delegate = self
        mapview.mapType = MKMapType(rawValue: 0)!
        mapview.showsBuildings = true
        
        addAnnotationsOnMap()
        showRouteOnMap()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //do as per your desire
    }
    
    override func viewWillDisappear(animated: Bool) {
        //do as per your desire
    }
    
    override func viewDidAppear(animated: Bool) {
        //do as per your desire
    }
    
    override func viewDidDisappear(animated: Bool) {
        //do as per your desire
    }

    
    func addAnnotationsOnMap(){
        
        for var index = 0; index < arrayForLocation.count; ++index {
            if index % 5 == 0{
                var coordinate = arrayForLocation[index]
                var annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                var locationToDisplay = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                
                var geoCoder = CLGeocoder ()
                geoCoder.reverseGeocodeLocation(locationToDisplay, completionHandler: { (placemarks, error) -> Void in
                    if let placemarks = placemarks as? [CLPlacemark] where placemarks.count > 0 {
                        var placemark = placemarks[0]
                        var addressDictionary = placemark.addressDictionary;
                        annotation.title = addressDictionary["Name"] as? String
                        self.mapview.addAnnotation(annotation)

                    }
                })
                
            }
        }
    }
    
    
    func showRouteOnMap(){
        var polyline = MKPolyline(coordinates: &arrayForLocation, count: arrayForLocation.count)
        self.mapview.addOverlay(polyline)
        
        mapview.setVisibleMapRect(polyline.boundingMapRect, edgePadding: UIEdgeInsetsMake(25.0, 10.0, 25.0, 10.0), animated: true)
    }
    
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if (overlay is MKPolyline) {
            var pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = UIColor.redColor()
            pr.lineWidth = 5
            return pr
        }
        
        return nil
    }


    
    // MARK :- Memory warning handling
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


