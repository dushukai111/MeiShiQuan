//
//  FunctionButton.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/9.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class FunctionButton: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private var imageView:UIImageView!
    private var titleLabel:UILabel!
    private var target:AnyObject!
    private var action:Selector!
    var title:String=""{
        didSet{
            self.titleLabel.text=title
        }
    }
    var icon:String=""{
        didSet{
            self.imageView.image=UIImage(named: icon)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView=UIView()
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints=false
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0))
        imageView=UIImageView()
//        imageView.backgroundColor=UIColor.yellow
        imageView.layer.cornerRadius=20
        imageView.layer.masksToBounds=true
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints=false
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        imageView.isUserInteractionEnabled=true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImageViewTap)))
        titleLabel=UILabel()
        titleLabel.font=UIFont.systemFont(ofSize: 15.0)
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints=false
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 7))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0))
        
    }
    func addTarget(target:AnyObject?,action:Selector?){
        self.target=target
        self.action=action
    }
    func onImageViewTap(){
        if let _=self.target , let _=self.action {
            self.target.perform(self.action, with: self)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
