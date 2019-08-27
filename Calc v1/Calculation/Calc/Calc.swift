//
//  Calc.swift
//  Calculation
//
//  Created by Даниил Иванов on 14/08/2019.
//  Copyright © 2019 Даниил Иванов. All rights reserved.
//

import Foundation

class Calc {
    
    var U = Double()
    var I = Double()
    var Kodn = Double()
    var Kn = Double()
    var Ksz = Double()
    var Kv = Double()
    var I1: Double = 0
    var I2: Double = 0
    var cables = [Cable] ()
    var S = String()
    // AR и AX - записываются сопротивления кабелей
    var AR = [Double] ()
    var AX = [Double] ()
    
    var R = Double()
    var X = Double()
    var Z = Double()
    var Zc = Double()
    var Zabs = Double()
    var Ik3 = Double()
    var Ik2 = Double()
    var Irab = Double()
    var Ir = Double()
    var Isr = Double()
    
    var NameRele = String()
}

extension Calc {
    func SC() {
        for cable in cables {
            let rc = Double(cable.RCable)!
            let xc = Double(cable.XCable)!
            let lc = Double(cable.LengthOfCable)!
            let RL = Double(rc*lc)
            let XL = Double(xc*lc)
            AR.insert(RL, at: AR.endIndex)
            R = round(AR.reduce(0, +) * 1000)/1000
            AX.insert(XL, at: AX.endIndex)
            X = round(AX.reduce(0, +) * 1000)/1000
        }
    }
}

extension Calc{
    func SysTKZ() {
        Zc = round((U*1000)/(sqrt(3)*(I*1000)) * 1000)/1000
        Zabs = round(sqrt(R*R+X*X) * 1000)/1000
        Z = round((Zc + Zabs) * 1000)/1000
        Ik3 = round((U*1000)/(sqrt(3)*Z) * 1000)/1000
        Ik2 = round((sqrt(3)/2)*Ik3 * 1000)/1000
    }
}

extension Calc {
    func UST() {
        Irab = round((Double(S)!*1000)/(sqrt(3)*(U*1000)) * 1000)/1000
        Ir = round(Kodn*Irab * 1000)/1000
        Isr = round((Kn*Ksz*Ir)/Kv * 1000)/1000
    }
}

extension Calc {
    func NUL() {
        AR.removeAll()
        AX.removeAll()
    }
}
