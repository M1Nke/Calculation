//
//  AddCableTableViewController.swift
//  Calculation
//
//  Created by Даниил Иванов on 10/08/2019.
//  Copyright © 2019 Даниил Иванов. All rights reserved.
//

import UIKit

protocol CableDelegate {
    func sendDataCable(_ sendCable: CableTableViewController, didAddCable cable: Cable)
    func sendChangeCable(_ sendChange: CableTableViewController, didChangeCable cable: Cable)
}

class CableTableViewController: UITableViewController {
    
    @IBOutlet var NameOfCableTextField : UITextField!
    @IBOutlet var LengthOfCableTextField : UITextField!
    @IBOutlet var RCableTextField : UITextField!
    @IBOutlet var XCableTextField : UITextField!
    
    var delegateCable: CableDelegate?
    
    var token: Int = 0
    
    var detailCable: Cable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if token == 1 {
            CHECK()
        }
    }
    
    func CHECK() {
        switch token {
        case 1:
            NameOfCableTextField.text = detailCable.NameOfCable
            LengthOfCableTextField.text = detailCable.LengthOfCable
            RCableTextField.text = detailCable.RCable
            XCableTextField.text = detailCable.XCable
            self.token = 2
        case 2:
            detailCable.NameOfCable = NameOfCableTextField.text ?? ""
            detailCable.LengthOfCable = LengthOfCableTextField.text ?? ""
            detailCable.RCable = RCableTextField.text ?? ""
            detailCable.XCable = XCableTextField.text ?? ""
            delegateCable?.sendChangeCable(self, didChangeCable: detailCable)
        default:
            let NameOfCable = NameOfCableTextField.text ?? ""
            let LengthOfCable = LengthOfCableTextField.text ?? ""
            let RCable = RCableTextField.text ?? ""
            let XCable = XCableTextField.text ?? ""
            let newCables = Cable(NameOfCable: NameOfCable, LengthOfCable: LengthOfCable, RCable: RCable, XCable: XCable)
            delegateCable?.sendDataCable(self, didAddCable: newCables)
        }
    }
    
    
    
    @IBAction func SaveTappedCabel(_sender: UIBarButtonItem) {
        if token == 2 || token == 0 {
            CHECK()
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func CancelTapped(_sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
}

