//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

protocol KPermissionTableAction: class {
    func tapAllowAction(cell: KPermissionTableCell)
}

class KPermissionTableCell: UITableViewCell {
    
    @IBOutlet weak var permissionImage: UIImageView!
    @IBOutlet weak var permissionTitle: UILabel!
    @IBOutlet weak var checkImageButton: UIButton!
    
    weak var actionDelegate: KPermissionTableAction?
    
    var status:Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.status == true ? self.setAllowed() : self.setAllow()
            }
        }
    }
    
    static var id = String(describing: self)
    
    var data: KPermissionType! {
        didSet {
            permissionTitle.text = data.description
            permissionImage.image = UIImage(named: data.description, in: Bundle(identifier: "com.kenan.KPermission"), compatibleWith: nil) ?? UIImage()
            permissionImage.image = permissionImage.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        checkImageButton.addTarget(self, action: #selector(allowButtonAction), for: .touchUpInside)
    }
    
    private func setAllow() {
        checkImageButton.setTitle("ALLOW", for: .normal)
        checkImageButton.tag = 500
        checkImageButton.backgroundColor = .clear
        checkImageButton.layer.borderWidth = 1
        checkImageButton.layer.borderColor = UIColor(red: 0 / 255, green: 122 / 255, blue: 255 / 255, alpha: 1).cgColor
        checkImageButton.setTitleColor(UIColor(red: 0 / 255, green: 122 / 255, blue: 255 / 255, alpha: 1), for: .normal)
        checkImageButton.layer.cornerRadius = 5
        permissionImage.tintColor = UIColor(red: 205 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1.0)
    }
    
    private func setAllowed() {
        checkImageButton.setTitle("ALLOWED", for: .normal)
        checkImageButton.layer.borderWidth = 0
        checkImageButton.backgroundColor = UIColor(red: 0 / 255, green: 122 / 255, blue: 255 / 255, alpha: 1)
        checkImageButton.setTitleColor(.white, for: .normal)
        checkImageButton.layer.cornerRadius = 5
        permissionImage.tintColor = .black
    }
    
     func setSettings() {
        checkImageButton.setTitle("SETTINGS", for: .normal)
        checkImageButton.tag = 404
        checkImageButton.backgroundColor = .clear
        checkImageButton.layer.borderWidth = 1
        checkImageButton.layer.borderColor = UIColor.lightGray.cgColor
        checkImageButton.setTitleColor(.lightGray, for: .normal)
        checkImageButton.layer.cornerRadius = 5
        permissionImage.tintColor = UIColor(red: 205 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1.0)
    }
    
    @objc func allowButtonAction() {
        actionDelegate?.tapAllowAction(cell: self)
    }
}
