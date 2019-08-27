//
//  SolveViewController.swift
//  Calculation
//
//  Created by Даниил Иванов on 14/08/2019.
//  Copyright © 2019 Даниил Иванов. All rights reserved.
//

import UIKit
import iosMath


class SolveViewController: UIViewController {

    var calc = Calc ()
    var cables = [Cable] ()
    var ind = Int ()
    
    var stackV = UIStackView()
    var scrollV = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calc.SC()
        calc.SysTKZ()
        calc.UST()
        VStack()
        VisCable()
        SysPar()
        Resist()
        TKZS()
        UST()
        ScrollV()
        
    }
    
    
    @IBAction func Save(_ sender: UIBarButtonItem) {
        screenshot()
    }
    
    @IBAction func Back(_ sender: Any) {
        calc.NUL()
        dismiss(animated: true, completion: nil)
    }
}

extension SolveViewController {
    func VStack() {
        stackV.axis = .vertical
        stackV.alignment = .top
        stackV.distribution = .equalSpacing
        stackV.spacing = 35
        stackV.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackV)
        stackV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        stackV.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 95).isActive = true
    }
}

extension SolveViewController {
    func ScrollV() {
        let scrollRect = self.view.bounds
        scrollV = UIScrollView(frame: CGRect(x: 30, y: 95, width: Int(scrollRect.size.width), height: Int(scrollRect.size.height)))
        scrollV.addSubview(self.stackV)
        scrollV.contentSize = CGSize(width: scrollRect.size.width, height: scrollRect.size.height + CGFloat(200 + self.ind))
        self.view.addSubview(scrollV)
    }
}

extension SolveViewController {
    func VisCable() {
        
        let fontISX = UIFont(name: "Gost type B", size: 22)
        
        let labelISX = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelISX.text = "Исходные данные:"
        labelISX.textAlignment = .center
        labelISX.font = fontISX
        self.stackV.addArrangedSubview(labelISX)
        
        let font = UIFont(name: "Gost type B", size: 20)
        
        let labellength = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labellength.text = "Длина и сопротивление КЛ:"
        labellength.font = font
        self.stackV.addArrangedSubview(labellength)
        
        for (index, cable) in cables.enumerated() {
            
            let stackH = UIStackView()
            stackH.axis = .horizontal
            stackH.alignment = .leading
            stackH.distribution = .equalCentering
            stackH.spacing = 50
            stackH.translatesAutoresizingMaskIntoConstraints = false
            
            let font = UIFont(name: "Helvetica", size: 20)
            
            let labelN = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            labelN.text = cable.NameOfCable
            labelN.font = font
            stackH.addArrangedSubview(labelN)

            let labelL = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            labelL.text = "L" + String(index+1) + " = " + cable.LengthOfCable + " км"
            labelL.font = font
            stackH.addArrangedSubview(labelL)
  
            let labelR = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            labelR.text = "r" + String(index+1) + " = " + cable.RCable + " Ом/км"
            labelR.font = font
            stackH.addArrangedSubview(labelR)
            
            let labelX = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            labelX.text = "x" + String(index+1) + " = " + cable.XCable + " Ом/км"
            labelX.font = font
            stackH.addArrangedSubview(labelX)
            
            self.ind += 59
            
            self.stackV.addArrangedSubview(stackH)
        }
    }
}

extension SolveViewController {
    func SysPar() {
        
        let font = UIFont(name: "GOST type B", size: 20)
        
        let labelSys = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelSys.text = "Параметры системы:"
        labelSys.font = font
        self.stackV.addArrangedSubview(labelSys)
        
        let labelU = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelU.latex = "U" + " = " + String(calc.U) +  "kV"
        self.stackV.addArrangedSubview(labelU)
        
        let labelI = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelI.latex = "I_{k}^{(3)}" + " = " + String(calc.I) + "kA"
        self.stackV.addArrangedSubview(labelI)
        
        let labelZc = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelZc.latex = "Z_{c} = \\frac{U}{\\sqrt{3}\\cdot I_{kz}}" + " = " + "\\frac{\(String(calc.U))}{\\sqrt{3}\\cdot \(String(calc.I))}" + " = " + "\(String(calc.Zc))"
        self.stackV.addArrangedSubview(labelZc)
    }
}

extension SolveViewController {
    func Resist() {
        
            let font = UIFont(name: "GOST type B", size: 20)
        
            let labelResist = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            labelResist.text = "Расчет сопротивлений:"
            labelResist.font = font
            self.stackV.addArrangedSubview(labelResist)
            
            let labelR = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            labelR.latex = "R = r\\cdot L" + " = " + String(calc.R)
            stackV.addArrangedSubview(labelR)
            
            let labelX = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            labelX.latex = "X = x\\cdot L" + " = " + String(calc.X)
            stackV.addArrangedSubview(labelX)
            
            let labelZ = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            labelZ.latex = "Z = R + i\\cdot X = \(String(self.calc.R)) + i\\cdot \(String(self.calc.X))"
            stackV.addArrangedSubview(labelZ)
            
            let labelABS = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            labelABS.latex = "|Z| = \\sqrt{R^{2} + X^{2}}" + " = " + "\(self.calc.Zabs)"
            stackV.addArrangedSubview(labelABS)
        
            let labelZo = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            labelZo.latex = "Z_{o} = |Z| + Zc" + " = " + String(calc.Z)
            stackV.addArrangedSubview(labelZo)
    }
}

extension SolveViewController {
    func TKZS() {
        
        let font = UIFont(name: "GOST type B", size: 20)
        
        let labelTKSZ = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelTKSZ.text = "Расчет мощности и тока КЗ:"
        labelTKSZ.font = font
        self.stackV.addArrangedSubview(labelTKSZ)
        
        let labelS = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelS.latex = "S = " + String(calc.S)
        stackV.addArrangedSubview(labelS)
        
        let labelIk3 = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelIk3.latex = "I_{k}^{(3)} = \\frac{U}{\\sqrt{3}\\cdot Z_{o}}" + " = " + "\\frac{\(String(calc.U))}{\\sqrt{3}\\cdot \(String(calc.Z))}" + " = " + String(calc.Ik3)
        stackV.addArrangedSubview(labelIk3)
        
        let labelIk2 = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelIk2.latex = "I_{k}^{(2)} = \\frac{\\sqrt{3}}{2}\\cdot I_{k3}" + " = " + String(calc.Ik2)
        stackV.addArrangedSubview(labelIk2)
    }
}

extension SolveViewController {
    func UST() {
        
        let font = UIFont(name: "GOST type B", size: 20)
        
        let labelUST = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelUST.text = "Расчет тока срабатывания:"
        labelUST.font = font
        self.stackV.addArrangedSubview(labelUST)
        
        let labelIrab = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelIrab.latex = "I_{rab} = \\frac{S}{\\sqrt{3}\\cdot U}" + " = " + "\\frac{\(String(calc.S))}{\\sqrt{3}\\cdot \(String(calc.U))}" + " = " + String(calc.Irab)
        stackV.addArrangedSubview(labelIrab)
        
        let labelIr = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelIr.latex = "I_{p} = K_{o}\\cdot I_{rab}" + " = " + "\(String(calc.Kodn))\\cdot \(String(calc.Irab))" + " = " + String(calc.Ir)
        stackV.addArrangedSubview(labelIr)
        
        let labelRele = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelRele.text = "Тип реле:" + String(calc.NameRele)
        labelRele.font = font
        self.stackV.addArrangedSubview(labelRele)
        
        let labelIsr = MTMathUILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        labelIsr.latex = "I_{cp} = \\frac{K_{n}\\cdot K_{sz}}{K_{v}}\\cdot I_{p}" + " = " + "\\frac{\(String(calc.Kn))\\cdot \(String(calc.Ksz))}{\(String(calc.Kv))}\\cdot \(String(calc.Ir))" + " = " + String(calc.Isr)
        stackV.addArrangedSubview(labelIsr)
    }
}

extension SolveViewController {
    // begin image context
    func screenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.scrollV.contentSize, false, 0.0)
        // save the orginal offset & frame
        let savedContentOffset = scrollV.contentOffset
        let savedFrame = scrollV.frame
        // end ctx, restore offset & frame before returning
        defer {
            UIGraphicsEndImageContext()
            scrollV.contentOffset = savedContentOffset
            scrollV.frame = savedFrame
        }
        // change the offset & frame so as to include all content
        scrollV.contentOffset = .zero
        scrollV.frame = CGRect(x: 30, y: 95, width: scrollV.contentSize.width, height: scrollV.contentSize.height + CGFloat(200 + self.ind))
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        scrollV.layer.render(in: ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        return image
    }
}
