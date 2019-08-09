//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit
import Contacts

class ContactsPermission: KAuthProtocol {
    
    func auth(success: @escaping (Bool) -> Void) {
        CNContactStore().requestAccess(for: .contacts) { (result, error) in
            guard error == nil else {
                success(false)
                return
            }
            success(result)
        }
    }
    
    var isAuth: Bool {
        return CNContactStore.authorizationStatus(for: .contacts) == .authorized
    }
}
