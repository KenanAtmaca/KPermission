//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

class KPermissionTableView: UITableView {
    
    private var permission:KAuthProtocol? = nil
    
    var types: [KPermissionType] = [] {
        didSet {
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadPermissionObserve), name: NSNotification.Name.init(rawValue: "ReloadPermissionStatus"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAppActive), name: UIApplication.willEnterForegroundNotification, object: nil)
        self.separatorColor = UIColor.lightGray
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.delegate = self
        self.dataSource = self
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadNib() {
        guard let tableViewBundle = Bundle(identifier: "com.kenan.KPermission") else { return }
        self.register(UINib(nibName: "KPermissionListView", bundle: tableViewBundle), forCellReuseIdentifier: KPermissionTableCell.id)
    }
    
    private func reloadPermissionsStatus(cell: KPermissionTableCell) {
        let permission = KPermission.shared.allowPermission(permission: cell.data)
        cell.status = permission.isAuth
    }
    
    @objc private func reloadPermissionObserve(_ notification: Notification) {
        if let type = notification.userInfo?["permissionType"] as? KPermissionType {
           let permission = KPermission.shared.allowPermission(permission: type)
            if let typesRowIndex = types.firstIndex(of: type) {
                let index = IndexPath(row: typesRowIndex, section: 0)
                DispatchQueue.main.async {
                    if let permissionCell = self.cellForRow(at: index) as? KPermissionTableCell {
                       permissionCell.status = permission.isAuth
                    }
                }
            }
        }
    }
    
    @objc func reloadAppActive() {
        self.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .init(rawValue: "ReloadPermissionStatus"), object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
}

extension KPermissionTableView: UITableViewDelegate, UITableViewDataSource, KPermissionTableAction {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KPermissionTableCell.id) as? KPermissionTableCell else { return UITableViewCell() }
        cell.data = types[indexPath.row]
        cell.actionDelegate = self
        reloadPermissionsStatus(cell: cell)
        return cell
    }
    
    func tapAllowAction(cell: KPermissionTableCell) {
        guard !cell.status else { return }
        permission = KPermission.shared.allowPermission(permission: cell.data)
        permission?.auth { (status) in
            if !status {
                DispatchQueue.main.async {
                    if cell.checkImageButton.tag != 404 {
                       cell.setSettings()
                    } else {
                      KPermission.shared.goPermissionSettings()
                    }
                }
                return
            } else {
                cell.status = self.permission?.isAuth ?? false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
