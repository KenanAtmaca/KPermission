//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit
import AVFoundation

class MicPermission: KAuthProtocol {
    
    func auth(success: @escaping (Bool) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission { (result) in
            success(result)
        }
    }
    
    var isAuth: Bool {
        return AVAudioSession.sharedInstance().recordPermission == .granted
    }
}
