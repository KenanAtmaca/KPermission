//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationPermission: KAuthProtocol {
    
    func auth(success: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (result, error) in
            guard error == nil else {
                success(false)
                return
            }
            success(result)
        }
    }
    
    var isAuth: Bool {
        var status:Bool = false
        let semaphore = DispatchSemaphore(value: 0)
        UNUserNotificationCenter.current().getNotificationSettings { (result) in
            switch (result.authorizationStatus) {
            case .authorized:
                status = true
                semaphore.signal()
            case .denied, .notDetermined, .provisional:
                status = false
                semaphore.signal()
            @unknown default: status = false
            }
        }
        semaphore.wait()
        return status
    }
}
