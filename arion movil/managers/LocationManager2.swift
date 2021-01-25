//
//  LocationManager2.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 25/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class LocationManager2: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
      let objectWillChange = PassthroughSubject<Void, Never>()
    private let geocoder = CLGeocoder()
    @Published var granted = false;
    
    @Published var status: CLAuthorizationStatus? {
       willSet { objectWillChange.send() }
     }
    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
      }
    override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
      }
    private func geocode() {
        guard let location = self.location else { return }
         geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
           if error == nil {
             self.placemark = places?[0]
           } else {
             self.placemark = nil
           }
         })

      }
    @Published var placemark: CLPlacemark? {
        willSet { objectWillChange.send() }
      }

}

extension LocationManager2: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.geocode()
    }
}

