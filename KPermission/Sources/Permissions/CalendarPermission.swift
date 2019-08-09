//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit
import EventKit

class CalendarPermission: KAuthProtocol {
    
    var type:EKEntityType!
    
    init(type: EKEntityType) {
        self.type = type
    }
    
    func auth(success: @escaping (Bool) -> Void) {
        EKEventStore.init().requestAccess(to: type) { (result, error) in
            guard error == nil else {
                success(false)
                return
            }
            success(result)
        }
    }
    
    var isAuth: Bool {
        return EKEventStore.authorizationStatus(for: type) == .authorized
    }
}
