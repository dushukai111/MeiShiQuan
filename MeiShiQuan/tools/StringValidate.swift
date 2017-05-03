//
//  StringValidate.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/12/14.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class StringValidate: NSObject {

    static func validatePhoneNumber(phoneNumber:String)->Bool{
        let pattern = "^1\\d{10}$";
        let predicate=NSPredicate(format: "SELF MATCHES %@",pattern)
        return predicate.evaluate(with: phoneNumber);
    }
}
