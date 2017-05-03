//
//  SelectionAlertView.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/12/16.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class SelectionAlertView: UIView,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate {

    private let lineHeight:CGFloat=45
    private let titleHeight:CGFloat=40
    private var title:String!
    private var items:[String]!
    private var contentView:UIView!
    public var completeSelectionBlock:((_ index:Int)->Void)!
    init(title:String,items:[String]){
        super.init(frame: CGRect.zero)
        self.title=title
        self.items=items
        self.translatesAutoresizingMaskIntoConstraints=false
        self.backgroundColor=UIColor(white: 0.0, alpha: 0.3)
        //添加点击手势，点击后关闭选择框
        let tap=UITapGestureRecognizer(target: self, action: #selector(onTap))
        tap.delegate=self
        self.addGestureRecognizer(tap)
        
        contentView=UIView()
        contentView.backgroundColor=UIColor.white
        contentView.layer.shadowColor=UIColor.black.cgColor
        contentView.layer.shadowOpacity=0.3
        contentView.layer.shadowOffset=CGSize(width: 5, height: 5)
        contentView.alpha=0.0
        contentView.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(contentView)
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: titleHeight+lineHeight*CGFloat(self.items.count)))
        
        let titleLabel=UILabel()
        titleLabel.font=UIFont.systemFont(ofSize: 17.0)
        titleLabel.textAlignment = .center
        titleLabel.text=title
        titleLabel.translatesAutoresizingMaskIntoConstraints=false
        contentView.addSubview(titleLabel)
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 10))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -10))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: titleHeight))
        
        
        let tableView=UITableView()
        tableView.dataSource=self
        tableView.delegate=self
        tableView.separatorStyle = .none
        tableView.rowHeight=lineHeight
        tableView.translatesAutoresizingMaskIntoConstraints=false
        contentView.addSubview(tableView)
        contentView.addConstraint(NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: titleHeight))
        contentView.addConstraint(NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    func onTap(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha=0.0
        }, completion: {(completion:Bool) in
            self.removeFromSuperview()
        })
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId="selectionAlertViewCell"
        var cell=tableView.dequeueReusableCell(withIdentifier: cellId) as? SelectionAlertViewCell
        if cell==nil {
            cell=SelectionAlertViewCell(style: .default, reuseIdentifier: cellId)
        }
        let itemTitle=self.items[indexPath.row]
        cell?.titleLabel.text=itemTitle
        if indexPath.row==self.items.count-1 {
            cell?.separatorLine.isHidden=true
        }else{
            cell?.separatorLine.isHidden=false
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _=self.completeSelectionBlock {
            self.completeSelectionBlock(indexPath.row)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha=0.0
        }, completion: {(completion:Bool) in
            self.removeFromSuperview()
        })
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint=touch.location(in: self.contentView)
        if self.contentView.point(inside: touchPoint, with: nil) {
            return false
        }else{
            return true
        }
        
    }
    func show(){
        let window=UIApplication.shared.keyWindow
        window?.addSubview(self)
        window?.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leading, multiplier: 1.0, constant: 0))
        window?.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: window, attribute: .trailing, multiplier: 1.0, constant: 0))
        window?.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1.0, constant: 0))
        window?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: window, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.alpha=1.0
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class SelectionAlertViewCell:UITableViewCell{
        var titleLabel:UILabel!
        var separatorLine:UIView!
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.selectionStyle = .none
            titleLabel=UILabel()
            titleLabel.font=UIFont.systemFont(ofSize: 16.0)
            titleLabel.textColor=UIColor.gray
            titleLabel.translatesAutoresizingMaskIntoConstraints=false
            self.contentView.addSubview(titleLabel)
            self.contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 20))
            self.contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: -20))
            self.contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 0))
            self.contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: 0))
            
            separatorLine=UIView()
            separatorLine.backgroundColor=UIColor(white: 0.85, alpha: 1.0)
            separatorLine.translatesAutoresizingMaskIntoConstraints=false
            self.contentView.addSubview(separatorLine)
            self.contentView.addConstraint(NSLayoutConstraint(item: separatorLine, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0))
            self.contentView.addConstraint(NSLayoutConstraint(item: separatorLine, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0))
            self.contentView.addConstraint(NSLayoutConstraint(item: separatorLine, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: 0))
            self.contentView.addConstraint(NSLayoutConstraint(item: separatorLine, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1))
        }
        override func setHighlighted(_ highlighted: Bool, animated: Bool) {
            if highlighted {
                self.contentView.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
            }else{
                self.contentView.backgroundColor=UIColor.white
            }
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
