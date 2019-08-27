//
//  ADViewController.swift
//  Calc
//
//  Created by Даниил Иванов on 21/08/2019.
//  Copyright © 2019 Даниил Иванов. All rights reserved.
//

import UIKit

protocol CableDelegate {
    func sendDataCable(_ sendCable: ADViewController, didAddCable cable: CableModel)
    func sendChangeCable(_ sendChange: ADViewController, didChangeCable cable: CableModel)
}

class ADViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewfont = UIFont(name: "Helvetica", size: 20)
    
    var delegateCable: CableDelegate? = nil
    
    var detailCable: CableModel!
    
    var token: Int = 0
    
    lazy var nametf: UITextField = {
        let tf = UITextField(frame: CGRect(x: 200, y: 8, width: 150, height: 29))
        return tf
    }()
    lazy var lngtf: UITextField = {
        let tf = UITextField(frame: CGRect(x: 200, y: 8, width: 150, height: 29))
        return tf
    }()
    lazy var rtf: UITextField = {
        let tf = UITextField(frame: CGRect(x: 200, y: 8, width: 150, height: 29))
        return tf
    }()
    lazy var xtf: UITextField = {
        let tf = UITextField(frame: CGRect(x: 200, y: 8, width: 150, height: 29))
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        BarItems()
        AD()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if token == 1 {
            CHECK()
        }
    }

    @objc func Cancel(_ : UIBarButtonItem) {
        print("Отменить")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func Save(_ : UIBarButtonItem) {
        if token == 2 || token == 0 {
            CHECK()
        }
        print("Сохранить")
        dismiss(animated: true, completion: nil)
    }
    
    func AD() {
        let adtable = UITableView()
        self.view.addSubview(adtable)
        adtable.translatesAutoresizingMaskIntoConstraints = false
        adtable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        adtable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        adtable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 30).isActive = true
        adtable.bottomAnchor.constraint(equalTo: adtable.topAnchor, constant: 185).isActive = true
        adtable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        adtable.delegate = self
        adtable.dataSource = self
        adtable.isScrollEnabled = false
        adtable.allowsSelection = false
        adtable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    fileprivate func BarItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(Cancel(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(Save(_:)))
    }
    
    func CHECK() {
        switch token {
        case 1:
            nametf.text = detailCable.NameOfCable
            lngtf.text = detailCable.LengthOfCable
            rtf.text = detailCable.RCable
            xtf.text = detailCable.XCable
            self.token = 2
        case 2:
            detailCable.NameOfCable = nametf.text ?? ""
            detailCable.LengthOfCable = lngtf.text ?? ""
            detailCable.RCable = rtf.text ?? ""
            detailCable.XCable = xtf.text ?? ""
            delegateCable?.sendChangeCable(self, didChangeCable: detailCable)
        default:
            let NameOfCable = nametf.text ?? ""
            let LengthOfCable = lngtf.text ?? ""
            let RCable = rtf.text ?? ""
            let XCable = xtf.text ?? ""
            let newCables = CableModel(NameOfCable: NameOfCable, LengthOfCable: LengthOfCable, RCable: RCable, XCable: XCable)
            print("\(newCables)")
            delegateCable?.sendDataCable(self, didAddCable: newCables)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Наименование"
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.font = self.viewfont
            nametf.borderStyle = .roundedRect
            nametf.placeholder = ""
            nametf.textAlignment = .center
            nametf.font = self.viewfont
            nametf.minimumFontSize = 15
            nametf.adjustsFontSizeToFitWidth = true
            cell.addSubview(nametf)
        case 1:
            cell.textLabel?.text = "Длина"
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.font = self.viewfont
            self.lngtf.borderStyle = .roundedRect
            self.lngtf.placeholder = ""
            self.lngtf.font = self.viewfont
            self.lngtf.textAlignment = .center
            cell.addSubview(self.lngtf)
        case 2:
            cell.textLabel?.text = "R (Ом/км)"
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.font = self.viewfont
            self.rtf.borderStyle = .roundedRect
            self.rtf.placeholder = ""
            self.rtf.font = self.viewfont
            self.rtf.textAlignment = .center
            cell.addSubview(self.rtf)
        case 3:
            cell.textLabel?.text = "X (Ом/км)"
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.font = self.viewfont
            self.xtf.borderStyle = .roundedRect
            self.xtf.placeholder = ""
            self.xtf.font = self.viewfont
            self.xtf.textAlignment = .center
            cell.addSubview(self.xtf)
        default:
            break
        }
    return cell
    }
}



