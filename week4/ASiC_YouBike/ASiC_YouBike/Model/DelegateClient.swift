//
//  DelegateClient.swift
//  ASiC_YouBike
//
//  Created by WU CHIH WEI on 2018/2/24.
//  Copyright © 2018年 WU CHIH WEI. All rights reserved.
//

import Foundation

protocol DelegateClientProtocol: class {
    
    func didGetDataFromFile(stationInfo: StationInfo) -> Void
}

/*
 Call the loadData() method, DelegateClient will generate a StationInfo instance and pass the StationInfo instance to it's delegate object through the method didGetDataFromFile(:)
 */



struct DelegateClient {
    
    // why optional: all the struct and class need init, but delegate doesn't need, so we use optional
    // why weak: to prevent reference cycle
    // remember only classes can be at the end of weak relationships, so we have to set protocol to be class bound
    weak var delegate: DelegateClientProtocol?
    
    func loadData() {
        
        let manager = YouBikeManager.createManagerFromFile()
        
        guard manager.stations.count > 0 else { return }
        
        
        self.delegate?.didGetDataFromFile(stationInfo: manager.stations[0])
    }
    
}
