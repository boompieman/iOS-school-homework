//
//  ViewController.swift
//  MapKit Starter
//
//  Created by Pranjal Satija on 10/25/16.
//  Copyright © 2016 Pranjal Satija. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet var mapView: MKMapView?
    
    let locationManager = CLLocationManager()
    
    let places = Place.getPlaces()
    
    override func viewDidLoad() {
        requestLocationAccess()
        addAnnotations()
        setCenter()
        
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addAnnotations() {
        mapView?.delegate = self
        mapView?.addAnnotations(places)

        let overlays = places.map { MKCircle(center: $0.coordinate, radius: 100) }
        mapView?.addOverlays(overlays)
    }
    
    func setCenter() {
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let center:CLLocationCoordinate2D = places[0].coordinate
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center,
                                                                  span: currentLocationSpan)
        self.mapView?.setRegion(currentRegion, animated: true)
    }


}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
        annotationView.image = UIImage(named: "place icon")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 2
        return renderer
    }
}
