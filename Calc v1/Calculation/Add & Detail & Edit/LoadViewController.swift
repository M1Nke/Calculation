//
//  LoadViewController.swift
//  Calculation
//
//  Created by Даниил Иванов on 13/08/2019.
//  Copyright © 2019 Даниил Иванов. All rights reserved.
//

import UIKit

protocol LoadDelegate {
    func sendDataLoad(Name: String, Load: Double, nLoad: String)
}

class LoadViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var NameTextField: UITextField!
    @IBOutlet var NumTextView: UITextView!
    
    var delegateLoad: LoadDelegate?
    
    var Load = Double()
    var Name = String()
    var vview = String ()
    
    var token: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        prefTextView()
        check()
    }
    
    func prefTextView() {
        let borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        NumTextView.delegate = self
        NumTextView.layer.borderWidth = 0.5
        NumTextView.layer.borderColor = borderColor.cgColor
        NumTextView.layer.cornerRadius = 5.0
    }
    
    func check() {
        if token == 1{
            NameTextField.text = Name
            NumTextView.text = vview
        }
    }

    
    func CalcLoad() {
        let view = NumTextView.text ?? ""
        vview = view
        let datas = view.components(separatedBy: "+")
        let Ddatas = datas.compactMap(Double.init)
        Load = Ddatas.reduce(0, +)
    }
    

    @IBAction func Save(_ sender: UIBarButtonItem) {
        Name = NameTextField.text!
        CalcLoad()
        delegateLoad?.sendDataLoad(Name: Name, Load: Load, nLoad: vview)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
