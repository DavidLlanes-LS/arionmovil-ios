//
//  LocationManager.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI
import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    @Published var latitudeVar = ""
    @Published var longitudeVar = ""
    public var locationManager = CLLocationManager()
    public var latitude:String = ""
    public var longitude:String = ""
    override init() {
        
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
            
                
            
        }
    }

    @Published var lastLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined:
            return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
           
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied:
            self.locationManager.requestWhenInUseAuthorization()
            return "denied"
        default: return "unknown"
        }
       
    }

   
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        //print("ubicacion estado \(statusString)")
     
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        //print("ubicacion \(location.latitude)")
        self.latitudeVar = String(location.latitude)
        self.longitudeVar = String(location.longitude)
    }

}

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}
