//
//  MainCell.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/10.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {

    let activityCellHeight=CGFloat(24.0)
    var imgView: UIImageView!
    var titleLabel:UILabel!
    var averagePriceLabel:UILabel!
    var monthAmountLabel:UILabel!
    var activityTableView:UITableView!
    var evaluateAmountLabel:UILabel!
    var activityArray:[[String:String]]!{
        didSet{
            if let _=activityArray {
                for c in self.activityTableView.constraints{
                    if c.firstAttribute==NSLayoutAttribute.height{
                        c.constant=CGFloat(activityArray.count)*activityCellHeight
                    }
                }
            }
            self.activityTableView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.imgView=UIImageView()
        self.contentView.addSubview(self.imgView)
        self.imgView.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        self.imgView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 10)
        self.imgView.autoSetDimensions(to: CGSize(width: 80, height: 80))
        
        self.titleLabel=UILabel()
        self.titleLabel.font=UIFont.systemFont(ofSize: 17.0)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.autoPinEdge(.leading, to: .trailing, of: self.imgView, withOffset: 10)
        self.titleLabel.autoPinEdge(.top, to: .top, of: self.imgView, withOffset: 0)
        self.titleLabel.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -10)
        
        self.averagePriceLabel=UILabel()
        self.averagePriceLabel.font=UIFont.systemFont(ofSize: 16.0)
        self.averagePriceLabel.textColor=UIColor.red
        self.contentView.addSubview(self.averagePriceLabel)
        self.averagePriceLabel.autoPinEdge(.leading, to: .leading, of: self.titleLabel)
        self.averagePriceLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.imgView)
        
        let perPersonLabel=UILabel()
        perPersonLabel.font=UIFont.systemFont(ofSize: 14.0)
        perPersonLabel.textColor=UIColor.gray
        perPersonLabel.text="/人"
        self.contentView.addSubview(perPersonLabel)
        perPersonLabel.autoPinEdge(.leading, to: .trailing, of: self.averagePriceLabel, withOffset: 2.0)
        perPersonLabel.autoPinEdge(.bottom, to: .bottom, of: self.averagePriceLabel)
        
        self.monthAmountLabel=UILabel()
        self.monthAmountLabel.font=UIFont.systemFont(ofSize: 15.0)
        self.monthAmountLabel.textColor=UIColor.gray
        self.contentView.addSubview(self.monthAmountLabel)
        self.monthAmountLabel.autoPinEdge(.leading, to: .trailing, of: perPersonLabel, withOffset: 50.0)
        self.monthAmountLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.averagePriceLabel)
        
        self.activityTableView=UITableView()
        self.activityTableView.dataSource=self
        self.activityTableView.delegate=self
        self.activityTableView.separatorStyle = .none
        self.activityTableView.bounces=false
        self.activityTableView.rowHeight=activityCellHeight
        self.contentView.addSubview(self.activityTableView)
        self.activityTableView.autoPinEdge(.leading, to: .leading, of: self.titleLabel)
        self.activityTableView.autoPinEdge(.top, to: .bottom, of: self.imgView, withOffset: -20)
        self.activityTableView.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -80.0)
        self.activityTableView.autoSetDimension(.height, toSize: 0)
        self.activityTableView.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: -10)
        
        self.evaluateAmountLabel=UILabel()
        self.evaluateAmountLabel.font=UIFont.systemFont(ofSize: 14.0)
        self.evaluateAmountLabel.textColor=UIColor.gray
        self.contentView.addSubview(self.evaluateAmountLabel)
        self.evaluateAmountLabel.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -20.0)
        self.evaluateAmountLabel.autoPinEdge(.top, to: .top, of: self.activityTableView, withOffset: 0.0)
        
        let seperaterLine=UIView()
        seperaterLine.backgroundColor=UIColor.lightGray
        self.contentView.addSubview(seperaterLine)
        seperaterLine.autoPinEdge(toSuperviewEdge: .leading)
        seperaterLine.autoPinEdge(toSuperviewEdge: .trailing)
        seperaterLine.autoPinEdge(toSuperviewEdge: .bottom)
        seperaterLine.autoSetDimension(.height, toSize: 1)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _=self.activityArray {
            return self.activityArray.count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId="activityCell"
        var cell:ActivityCell! = tableView.dequeueReusableCell(withIdentifier: cellId) as! ActivityCell!
        if cell==nil{
            cell=ActivityCell(style: .default, reuseIdentifier: cellId)
        }
        let item=self.activityArray[indexPath.row]
        cell.activityDisLabel.text=item["activityDis"]
        let activityType=item["activityType"]
        if activityType=="1" {
            cell.imgView.image=UIImage(named: "jian")
        }else if activityType=="2"{
            cell.imgView.image=UIImage(named: "zhe")
        }
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class ActivityCell:UITableViewCell{
        var imgView:UIImageView!
        var activityDisLabel:UILabel!
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.imgView=UIImageView()
            self.contentView.addSubview(self.imgView)
            self.imgView.autoPinEdge(.leading, to: .leading, of: self.contentView)
            self.imgView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 2)
            self.imgView.autoSetDimensions(to: CGSize(width: 20.0, height: 20.0))
            
            self.activityDisLabel=UILabel()
            self.activityDisLabel.font=UIFont.systemFont(ofSize: 13.0)
            self.activityDisLabel.textColor=UIColor.gray
            self.contentView.addSubview(self.activityDisLabel)
            self.activityDisLabel.autoPinEdge(.leading, to: .trailing, of: self.imgView, withOffset: 3)
            self.activityDisLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.imgView)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
