//
//  LSInfo.swift
//  Luis Silva
//
//  Created by Luis Filipe Campani on 4/16/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

import UIKit

class LSInfo: NSObject {
   
    var infoDict : NSDictionary?
    
    override init() {
        if let path = NSBundle.mainBundle().pathForResource("LuisInfo", ofType: "plist") {
            infoDict = NSDictionary(contentsOfFile: path)
        }
    }
}
