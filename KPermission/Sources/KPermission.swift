//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

protocol KAuthProtocol: class {
    func auth(success: @escaping (_ flag:Bool) -> Void)
    var isAuth:Bool { get }
}

public enum KPermissionType: String, CustomStringConvertible {
    
    case camera = "Camera"
    case photoLibrary = "Photo Library"
    case notification = "Notification"
    case location = "Location"
    case microphone = "Microphone"
    case calendar = "Calander"
    case contacts = "Contacts"
    case reminder = "Reminder"
    case motion = "Motion"
    case mediaLibrary = "Media Library"
    case speech = "Speech"
    
    public var description: String {
        get {
            return self.rawValue
        }
    }
}

open class KPermission {

    static public let shared = KPermission()
    lazy public var view = KPermissionView()
    
     func allowPermission(permission: KPermissionType) -> KAuthProtocol {
        switch (permission) {
        case .camera: return CameraPermission()
        case .photoLibrary: return PhotoLibPermission()
        case .notification: return NotificationPermission()
        case .location: return LocationPermission()
        case .microphone: return MicPermission()
        case .calendar: return CalendarPermission(type: .event)
        case .contacts: return ContactsPermission()
        case .reminder: return CalendarPermission(type: .reminder)
        case .motion: return MotionPermission()
        case .mediaLibrary: return MediaLibPermission()
        case .speech: return SpeechPermission()
        }
    }
    
    func goPermissionSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
           UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }
    }
}
