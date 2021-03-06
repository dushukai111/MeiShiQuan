//
//  PasswordSwitch.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/30.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit
enum SwitchType{
    case normal,security
}
class MySwitchView: UIView {

    private var onImageName="switch_on"
    private var offImageName="switch_off"
    private var imageView:UIImageView!
    var isOn = false{
        didSet{
            if isOn{
                imageView.image=UIImage(named: onImageName)
            }else{
                imageView.image=UIImage(named: offImageName)
            }
        }
    }
    var switchType:SwitchType = .normal{
        didSet{
            if switchType == .normal{
                onImageName="switch_on"
                offImageName="switch_off"
                
            }else{
                onImageName="pwd_visible"
                offImageName="pwd_invisible"
            }
            if isOn{
                imageView.image=UIImage(named: onImageName)
            }else{
                imageView.image=UIImage(named: offImageName)
            }
        }
    }
    var switchChangeBlock:((_ pwdSwitch:UIView,_ isSwitchOn:Bool)->Void)!
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView=UIImageView()
        imageView.image=UIImage(named: offImageName)
        imageView.translatesAutoresizingMaskIntoConstraints=false
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        let tap=UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.addGestureRecognizer(tap)
    }
    func onTap(){
        if isOn{
            isOn=false
            imageView.image=UIImage(named: offImageName)
        }else{
            isOn=true
            imageView.image=UIImage(named: onImageName)
        }
        if let _=switchChangeBlock {
            switchChangeBlock(self,isOn)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
