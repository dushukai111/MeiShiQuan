//
//  KGProgressAlertHUD.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/12/14.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class KGProgressAlertHUD: NSObject {

    static let progressViewTag=1111
    static let rotateViewTag=1112
    static func showSimpleProgress(title:String,view:UIView,offsetToCenterY:CGFloat){
        let backView=UIView()
        backView.tag=progressViewTag
        backView.backgroundColor=UIColor(white: 0.0, alpha: 0.3)
        backView.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(backView)
        view.addConstraint(NSLayoutConstraint(item: backView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: backView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: backView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: backView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        let contentView=UIView()
        contentView.backgroundColor=UIColor(white: 0.0, alpha: 0.7)
        contentView.layer.cornerRadius=10
        contentView.translatesAutoresizingMaskIntoConstraints=false
        backView.addSubview(contentView)
        backView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: backView, attribute: .centerX, multiplier: 1.0, constant: 0))
        backView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: backView, attribute: .centerY, multiplier: 1.0, constant: offsetToCenterY))
        backView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: backView, attribute: .width, multiplier: 1/3.0, constant: 0))
        backView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 1.0, constant: 0))
        
        let progressView=UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        progressView.startAnimating()
        progressView.translatesAutoresizingMaskIntoConstraints=false
        contentView.addSubview(progressView)
        
        contentView.addConstraint(NSLayoutConstraint(item: progressView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: progressView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: -15))
        
        let textLabel=UILabel()
        textLabel.font=UIFont.systemFont(ofSize: 15.0)
        textLabel.text=title
        textLabel.textColor=UIColor.white
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints=false
        contentView.addSubview(textLabel)
        contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 10))
        contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -10))
        contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -15))
        
    }
    static func showIconProgressView(icon:UIImage?,view:UIView,offsetToCenterY:CGFloat){
        let backView=UIView()
        backView.tag=progressViewTag
        backView.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(backView)
        view.addConstraint(NSLayoutConstraint(item: backView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: backView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: backView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: backView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        let iconView=UIImageView()
        iconView.image=icon
        iconView.layer.cornerRadius=25.0
        iconView.layer.masksToBounds=true
        iconView.backgroundColor=UIColor.white
        iconView.translatesAutoresizingMaskIntoConstraints=false
        backView.addSubview(iconView)
        backView.addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: backView, attribute: .centerX, multiplier: 1.0, constant: 0))
        backView.addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: backView, attribute: .centerY, multiplier: 1.0, constant: offsetToCenterY))
        backView.addConstraint(NSLayoutConstraint(item: iconView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        backView.addConstraint(NSLayoutConstraint(item: iconView, attribute: .height, relatedBy: .equal, toItem: iconView, attribute: .width, multiplier: 1.0, constant: 0))
        
        let rotateView=UIImageView()
        rotateView.tag=rotateViewTag
        rotateView.image=UIImage(named: "kgProgressAlertHUD_rotateIcon")
        rotateView.translatesAutoresizingMaskIntoConstraints=false
        backView.addSubview(rotateView)
        backView.addConstraint(NSLayoutConstraint(item: rotateView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        backView.addConstraint(NSLayoutConstraint(item: rotateView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        backView.addConstraint(NSLayoutConstraint(item: rotateView, attribute: .width, relatedBy: .equal, toItem: iconView, attribute: .width, multiplier: 1.0, constant: 8))
        backView.addConstraint(NSLayoutConstraint(item: rotateView, attribute: .width, relatedBy: .equal, toItem: rotateView, attribute: .height, multiplier: 1.0, constant: 0))
        
        let animation=CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue=M_PI*2
        animation.duration=1
        animation.repeatCount=HUGE
        rotateView.layer.add(animation, forKey: "kg_rotateAnimation")
    }
    static func dismissProgressView(view:UIView){
        let progressBackView=view.viewWithTag(progressViewTag)
        
        let rotateView=progressBackView?.viewWithTag(rotateViewTag)
        
        
        UIView.animate(withDuration: 0.3, animations: {
            progressBackView?.alpha=0.0
        }, completion: {(completion:Bool) in
            rotateView?.layer.removeAllAnimations()
            progressBackView?.removeFromSuperview()
            for subview in view.subviews{
                if subview.tag==1111{
                    subview.removeFromSuperview()
                }
            }
        })
        
        
    }
    
    static func showAlertMsg(message:String?,controller:UIViewController,delaySeconds:Int){
        //找出该controller的view位于屏幕的Y值
        var offsetY=controller.view.frame.origin.y
        var testView=controller.view
        while testView?.superview != UIApplication.shared.keyWindow{
            offsetY=(testView?.superview?.frame.origin.y)!+offsetY
            testView=testView?.superview
        }
        let backView=UIView()//backView用于遮罩，避免弹出框出现时，继续操作
        backView.translatesAutoresizingMaskIntoConstraints=false
        controller.view.addSubview(backView)
        controller.view.addConstraint(NSLayoutConstraint(item: backView, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1.0, constant: 0))
        controller.view.addConstraint(NSLayoutConstraint(item: backView, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1.0, constant: 0))
        controller.view.addConstraint(NSLayoutConstraint(item: backView, attribute: .top, relatedBy: .equal, toItem: controller.view, attribute: .top, multiplier: 1.0, constant: 0))
        controller.view.addConstraint(NSLayoutConstraint(item: backView, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        let alertView=UIView()
        alertView.alpha=0.0
        alertView.backgroundColor=UIColor(white: 0.0, alpha: 0.7)
        alertView.layer.cornerRadius=5.0
        alertView.translatesAutoresizingMaskIntoConstraints=false
        backView.addSubview(alertView)
        backView.addConstraint(NSLayoutConstraint(item: alertView, attribute: .centerX, relatedBy: .equal, toItem: backView, attribute: .centerX, multiplier: 1.0, constant: -offsetY))
        backView.addConstraint(NSLayoutConstraint(item: alertView, attribute: .centerY, relatedBy: .equal, toItem: backView, attribute: .centerY, multiplier: 1.0, constant: -offsetY))
        backView.addConstraint(NSLayoutConstraint(item: alertView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: backView, attribute: .width, multiplier: 1.0, constant: -60))
        
        let alertLabel=UILabel()
        alertLabel.text=message
        alertLabel.textAlignment = .center
        alertLabel.numberOfLines=0
        alertLabel.font=UIFont.systemFont(ofSize: 15)
        alertLabel.textColor=UIColor.white
        alertLabel.translatesAutoresizingMaskIntoConstraints=false
        alertView.addSubview(alertLabel)
        alertView.addConstraint(NSLayoutConstraint(item: alertLabel, attribute: .leading, relatedBy: .equal, toItem: alertView, attribute: .leading, multiplier: 1.0, constant: 15))
        alertView.addConstraint(NSLayoutConstraint(item: alertLabel, attribute: .trailing, relatedBy: .equal, toItem: alertView, attribute: .trailing, multiplier: 1.0, constant: -15))
        alertView.addConstraint(NSLayoutConstraint(item: alertLabel, attribute: .top, relatedBy: .equal, toItem: alertView, attribute: .top, multiplier: 1.0, constant: 15))
        alertView.addConstraint(NSLayoutConstraint(item: alertLabel, attribute: .bottom, relatedBy: .equal, toItem: alertView, attribute: .bottom, multiplier: 1.0, constant: -15))
        
        UIView.animate(withDuration: 0.3, animations: {
            alertView.alpha=1.0
        } , completion: {(completion:Bool) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.seconds(delaySeconds), execute: {
                UIView.animate(withDuration: 0.3, animations: {
                    alertView.alpha=0.0
                }, completion: {(completion:Bool) in
                    backView.removeFromSuperview()
                })
            })
        })
    }
}
