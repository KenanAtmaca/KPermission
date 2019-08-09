//
//  Created by Kenan Atmaca on 2.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

open class KPermissionView:UIView {
    
    public enum KPermissionViewAnimationType {
        case top
        case bottom
        case left
        case right
        case scale
        case alpha
    }
    
    private var blackView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var contentView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var closeButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close", in: Bundle(identifier: "com.kenan.KPermission"), compatibleWith: nil), for: .normal)
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.alpha = 0.8
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Need Permissions"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var subtitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Permission Request"
        label.textColor = UIColor.gray
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var kTableView:KPermissionTableView = {
        let table = KPermissionTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var animationDuration:TimeInterval = 1.0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(view:UIView, types: [KPermissionType], animation: KPermissionViewAnimationType? = nil) {
        kTableView.types = types
        self.frame = UIScreen.main.bounds
        self.backgroundColor = .white
        self.addSubview(blackView)
        blackView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(kTableView)
        self.addSubview(closeButton)
        let contentSize = CGFloat(types.count * 70) + 90
        
        blackView.alpha = 1
        blackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        blackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        
        if contentSize <= self.frame.height * 0.8 {
            contentView.heightAnchor.constraint(equalToConstant: contentSize).isActive = true
        } else {
            contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        }
        
        closeButton.alpha = 1
        closeButton.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        closeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        kTableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
        kTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        kTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        kTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(self)
        
        if let animation = animation { setAnimation(type: animation) }
    }
    
    private func setAnimation(type: KPermissionViewAnimationType) {
        switch type {
        case .alpha:
            blackView.alpha = 0
            closeButton.alpha = 0
            UIView.animate(withDuration: animationDuration) {
                self.blackView.alpha = 1
                self.closeButton.alpha = 0.6
            }
        case .top: setPositionAnimations(x: 0, y: -300)
        case .bottom: setPositionAnimations(x: 0, y: 500)
        case .left: setPositionAnimations(x: -200, y: 0)
        case .right: setPositionAnimations(x: 200, y: 0)
        case .scale: setPositionAnimations(x: 0.5, y: 0.5, scale: true)
        }
    }
    
    private func setPositionAnimations(x: CGFloat, y: CGFloat, scale:Bool = false) {
        self.contentView.transform = scale == false ? CGAffineTransform.init(translationX: x, y: y) : CGAffineTransform.init(scaleX: x, y: y)
        self.closeButton.alpha = 0
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
            self.contentView.transform = CGAffineTransform.identity
            self.closeButton.alpha = 0.8
        }) { (_) in }
    }
    
    @objc private func closeAction() {
        UIView.animate(withDuration: 0.3, animations: {
            self.blackView.alpha = 0
            self.closeButton.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
