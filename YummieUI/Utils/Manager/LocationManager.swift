//
//  LocationManager.swift
//  Yummie
//
//   Udayveer Singh
//    3035918634

import UIKit
import CoreLocation



class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private var locationManager: CLLocationManager
    
    var currentLocation: CLLocation?
    var onLocationUpdate: ((CLLocation) -> Void)?
    var onPermissionDenied: (() -> Void)?
    private lazy var geocoder = CLGeocoder()
    private override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // User granted permission
            locationManager.requestLocation()
        case .denied, .restricted:
            // User denied or restricted location access
            onPermissionDenied?()
        case .notDetermined:
            // Location permission not yet determined
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location
        onLocationUpdate?(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    func getAddressFromLocation(location: CLLocation, completion: @escaping (String?) -> Void) {
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print("Reverse geocoding failed with error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                if let placemark = placemarks?.first {
                    let address = placemark.compactAddress1
                   
                    completion(address)
                } else {
                    completion(nil)
                }
            }
        }
    
    
    func checkLocationServicesEnabled(completion: @escaping (Bool) -> ())  {
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse {
               completion(true)
        } else {
            completion(false)
        }
    }
}

extension CLPlacemark {
    var compactAddress: String? {
        if let name = name {
            var addressString = name
            if let city = locality {
                addressString += ", \(city)"
            }
            if let country = country {
                addressString += "- \(country)"
            }
            return addressString
        }
        return nil
    }
    
    var compactAddress1: String? {
        if let name = name {
            var addressString = name
            if let city = locality {
                addressString += ", \(city)"
            }
            if let country = country {
                addressString += ", \(country)"
            }
            return addressString
        }
        return nil
    }
    
}


import MapKit

final class LocationViewModel: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 22.3193, longitude: 114.1694),
        span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.setup()
    }
    
    func setup() {
        switch locationManager.authorizationStatus {
        //If we are authorized then we request location just once, to center the map
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        //If we don´t, we request authorization
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        locations.last.map {
            region = MKCoordinateRegion(
                center: $0.coordinate,
                span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
}
