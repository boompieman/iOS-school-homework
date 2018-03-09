//
//  YouBikeViewController.swift
//  ASiC_YouBike
//
//  Created by WU CHIH WEI on 2018/2/25.
//  Copyright © 2018年 WU CHIH WEI. All rights reserved.
//

import UIKit
import MapKit

protocol StationInfo {
    
    var name: String { get }
    
    var position: String { get }
    
    var remainBikes: String { get }
}

class YouBikeViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let closureClient = ClosureClient()
    
    @IBOutlet weak var name: UILabel!
    var delegateClient = DelegateClient()
    let stationInfo = StationInfoGetter()
    
    var stationsInfo = [StationInfo]()
    var annotations = [MKAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self

        
        setData()
        addAnnotations()
        setCenter()
    }
    
    func setData() {
        closureClient.getDataFromFile(completion: completion)
        delegateClient.delegate = stationInfo
        delegateClient.loadData()
    }
    
    func completion(annotation: MKAnnotation) {
        annotations.append(annotation as! YouBikeAnnotation)
    }
    
    func addAnnotations() {
        mapView.addAnnotations(annotations)
    }
    
    func setCenter() {
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let center:CLLocationCoordinate2D = annotations[0].coordinate
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center,
                                                                  span: currentLocationSpan)
        mapView.setRegion(currentRegion, animated: true)
    }
    
    func setLabel(stationInfo: StationInfo) {
        name.text = stationInfo.name
    }
    
//     改變annotation樣式
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
//        annotationView.image = UIImage(named: "icon_maker")
//        return annotationView
//    }

    
//    func mapView(_ mapView: MKMapView, didSelect: MKAnnotationView) {
//
//    }
}

class StationInfoGetter: DelegateClientProtocol {
    
    func didGetDataFromFile(stationInfo: StationInfo) {
//        YouBikeViewController.setLabel(stationInfo: stationInfo)
    }
}

