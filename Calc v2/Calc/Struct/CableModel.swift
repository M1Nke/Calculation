//
//  CableModel.swift
//  Calc
//
//  Created by Даниил Иванов on 22/08/2019.
//  Copyright © 2019 Даниил Иванов. All rights reserved.
//

import Foundation

struct CableModel {
    var NameOfCable : String
    var LengthOfCable : String
    var RCable : String
    var XCable : String
    
    init(NameOfCable: String, LengthOfCable : String, RCable : String, XCable : String) {
        self.NameOfCable = NameOfCable
        self.LengthOfCable = LengthOfCable
        self.RCable = RCable
        self.XCable = XCable
    }
}
