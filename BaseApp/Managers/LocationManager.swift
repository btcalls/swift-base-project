//
//  LocationManager.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/7/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CapabilityManager {

    static let shared = LocationManager()

    var isAuthorized: Bool {
        get {
            if #available(iOS 14.0, *) {
                let status = locationManager.authorizationStatus

                return status == .authorizedAlways || status == .authorizedWhenInUse
            } else {
                let status = CLLocationManager.authorizationStatus()

                return status == .authorizedAlways || status == .authorizedWhenInUse
            }
        }
        set {}
    }
    private var currentLocation: CLLocation?
    private var canAskForAuthorization: Bool {
        if #available(iOS 14.0, *) {
            let status = locationManager.authorizationStatus

            return status == .notDetermined || status == .denied
        } else {
            let status = CLLocationManager.authorizationStatus()

            return status == .notDetermined || status == .denied
        }
    }

    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        return locationManager
    }()

    func configure() {
        locationManager.delegate = self
    }

    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    func startMonitorLocation() {
        if !isAuthorized {
            return
        }
        
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
        } else {
            locationManager.startUpdatingLocation()
        }
    }

    func stopMonitoringLocation() {
        locationManager.stopUpdatingLocation()
    }

}

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if canAskForAuthorization {
            presentRequireDialog(.location)

            return
        }

        if isAuthorized {
            currentLocation = manager.location
        }
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }

}
