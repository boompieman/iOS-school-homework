// Delegate Pattern

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


//
//  YouBike.swift
//  ASiC_YouBike
//
//  Created by WU CHIH WEI on 2018/2/23.
//  Copyright © 2018年 WU CHIH WEI. All rights reserved.
//

struct YouBikeStation: Codable, StationInfo {
    
    let name: String
    
    let position: String
    
    let totalBikes: String
    
    let remainBikes: String
    
    let longitude: String
    
    let latitude: String
    
    enum CodingKeys: String, CodingKey {
        
        case name = "sna"
        
        case position = "ar"
        
        case totalBikes = "tot"
        
        case remainBikes = "sbi"
        
        case longitude = "lng"
        
        case latitude = "lat"
    }
}

struct YouBikeManager: Codable {
    
    var stations: [YouBikeStation]
    
    enum CodingKeys: String, CodingKey {
        
        case stations = "datas"
        
    }
    
    static func createManagerFromFile() -> YouBikeManager {
        
        let filePath = Bundle.main.path(
            
            forResource: YouBikeConstant.fileName.rawValue,
            
            ofType: YouBikeConstant.fileType.rawValue
            
        )
        
        let filePathURL = URL(fileURLWithPath: filePath!)
        
        do {
            
            let data = try Data(contentsOf: filePathURL, options: .mappedIfSafe)
            
            let jsonDecoder = JSONDecoder()
            
            let youbikeManager = try jsonDecoder.decode(YouBikeManager.self, from: data)
            
            return youbikeManager
            
        } catch {
            
            fatalError()
        }
    }
}


enum YouBikeConstant: String {
    
    case fileName = "YouBikeStations"
    
    case fileType = "json"
}


//
//  DelegateClient.swift
//  ASiC_YouBike
//
//  Created by WU CHIH WEI on 2018/2/24.
//  Copyright © 2018年 WU CHIH WEI. All rights reserved.
//

protocol DelegateClientProtocol: class {
    
    func didGetDataFromFile(stationInfo: StationInfo)
    
}

/*
 Call the loadData() method, DelegateClient will generate a StationInfo instance and pass the StationInfo instance to it's delegate object through the method didGetDataFromFile(:)
 */

// to call station info(Label)
class StationInfoGetter: DelegateClientProtocol {
    func didGetDataFromFile(stationInfo: StationInfo) {
        stationsInfo.append(stationInfo)
    }
}


struct DelegateClient {
    // why optional: all the struct and class need init, but delegate doesn't need, so we use optional
    // why weak: to prevent reference cycle
    // remember only classes can be at the end of weak relationships, so we have to set protocol to be class bound
    weak var delegate: DelegateClientProtocol?
    
    func loadData() {
        
        let manager = YouBikeManager.createManagerFromFile()
        
        guard manager.stations.count > 0 else { return }
        for station in manager.stations {
            self.delegate?.didGetDataFromFile(stationInfo: station)
        }
    }
    
}

//
//  ClosureClient.swift
//  ASiC_YouBike
//
//  Created by WU CHIH WEI on 2018/2/24.
//  Copyright © 2018年 WU CHIH WEI. All rights reserved.
//
import MapKit

class YouBikeAnnotation: NSObject, MKAnnotation {

    var title: String?

    var subtitle: String?

    var coordinate: CLLocationCoordinate2D

    init(station: YouBikeStation) {

        self.title = station.name

        self.subtitle = station.position

        self.coordinate = CLLocationCoordinate2D(

            latitude: Double(station.latitude)!,
            longitude: Double(station.longitude)!
        )
    }
}

/*
 Call the getDataFromFile(:) method, ClosureClient will generate a MKAnnotation instance.
 
 You can get the instance through the closure which is the parameter of the getDataFromFile(:) method.
 */

struct ClosureClient {
    
    var annotations = [YouBikeAnnotation]()

    func getDataFromFile(completion: (MKAnnotation) -> Void) -> Void {

        let manager = YouBikeManager.createManagerFromFile()

        guard manager.stations.count > 0 else { return }

        for station in manager.stations {
            let annotation = YouBikeAnnotation(station: station)
            completion(annotation)
        }
    }
}



// Controller
protocol StationInfo {
    
    var name: String { get }
    
    var position: String { get }
    
    var remainBikes: String { get }
}


var delegateClient = DelegateClient()

let manager = YouBikeManager.createManagerFromFile()

let station = StationInfoGetter()

var stationsInfo = [StationInfo]()

delegateClient.delegate = station
delegateClient.loadData()

print(stationsInfo[0])

//closure client

//let annotation = YouBikeAnnotation(station: manager.stations[0])
//
//func completion(annotation: MKAnnotation) {
//    print(annotation.title)
//}

let closureClient = ClosureClient()
var annotations = [YouBikeAnnotation]()
func completion(annotation: MKAnnotation) {
    annotations.append(annotation as! YouBikeAnnotation)
}

closureClient.getDataFromFile(completion: completion)
print(annotations[0].title)


if (stationsInfo[0].name == annotations[0].title) {
    print("yes")
}








