//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPermission: KAuthProtocol {
    
    func auth(success: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { (result) in
            success(result)
        }
    }
    
    var isAuth: Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
}
