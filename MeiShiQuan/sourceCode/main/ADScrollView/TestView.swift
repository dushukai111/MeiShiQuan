//
//  TestView.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/11.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class TestView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    init(a:Int,b:Int){
        super.init(frame:CGRect.zero)
    }
    override init(frame:CGRect){
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func test(){
        let a=TestView()
    }
}
