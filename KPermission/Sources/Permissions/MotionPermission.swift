//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit
import CoreMotion

class MotionPermission: KAuthProtocol {
    
    private lazy var manager = CMMotionActivityManager()
    
    func auth(success: @escaping (Bool) -> Void) {
        manager.queryActivityStarting(from: Date(), to: Date(), to: OperationQueue.main) { (activity, error) in
            guard error == nil else {
                success(false)
                return
            }
            success(true)
            self.manager.stopActivityUpdates()
        }
    }
    
    var isAuth: Bool {
        return CMMotionActivityManager.authorizationStatus() == .authorized
    }
}
