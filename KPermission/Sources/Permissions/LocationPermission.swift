//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit
import CoreLocation

class LocationPermission:NSObject, KAuthProtocol {
    
    private var locationManager:CLLocationManager = CLLocationManager()
    private var status:Bool = false
    
    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    func auth(success: @escaping (Bool) -> Void) {
        if CLLocationManager.locationServicesEnabled() {
        locationManager.requestWhenInUseAuthorization()
        success(self.status)
        }
    }
    
    var isAuth: Bool {
        switch (CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse: return true
        case .denied, .notDetermined, .restricted: return false
        @unknown default: return false
        }
    }
}

extension LocationPermission: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.status = true
            NotificationCenter.default.post(name: .init("ReloadPermissionStatus"), object: nil, userInfo: ["permissionType": KPermissionType.location])
        case .denied, .notDetermined, .restricted:
            self.status = false
        @unknown default: break
        }
    }
}
