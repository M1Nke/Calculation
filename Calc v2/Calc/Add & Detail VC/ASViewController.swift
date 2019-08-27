//
//  ASViewController.swift
//  Calc
//
//  Created by Даниил Иванов on 26/08/2019.
//  Copyright © 2019 Даниил Иванов. All rights reserved.
//

import UIKit

protocol SourceDelegate {
    func sendSource(U: String, I: String)
}

class ASViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewfont = UIFont(name: "Helvetica", size: 20)
    
    var delegateSource: SourceDelegate?
    
    var u = String()
    var i = String()
    
    var token: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        BarItems()
        AS()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CHECK()
    }
    
    lazy var utf: UITextField = {
        let tf = UITextField(frame: CGRect(x: 275, y: 8, width: 50, height: 29))
        return tf
    }()
    lazy var itf: UITextField = {
        let tf = UITextField(frame: CGRect(x: 275, y: 8, width: 50, height: 29))
        return tf
    }()
    lazy var ul: UILabel = {
        let kv = UILabel(frame: CGRect(x: 345, y: 8, width: 75, height: 29))
        kv.text = "кВ"
        return kv
    }()
    lazy var il: UILabel = {
        let ka = UILabel(frame: CGRect(x: 345, y: 8, width: 75, height: 29))
        ka.text = "кА"
        return ka
    }()
    
    @objc func Cancel(_ : UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func Save(_ : UIBarButtonItem) {
        CHECK()
        delegateSource?.sendSource(U: u, I: i)
 
        dismiss(animated: true, completion: nil)
    }
    
    func CHECK() {
        if token == 1 {
            utf.text  = "lox"
            itf.text  = "Pidr"
        } else {
            u = utf.text ?? ""
            i = itf.text ?? ""
        }
    }
    
    func AS() {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
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
            cell.textLabel?.text = "Номинальное напряжение"
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.font = self.viewfont
            ul.textAlignment = .left
            ul.font = UIFont.systemFont(ofSize: 20)
            utf.borderStyle = .roundedRect
            utf.textAlignment = .center
            utf.font = self.viewfont
            utf.minimumFontSize = 15
            utf.adjustsFontSizeToFitWidth = true
            cell.addSubview(utf)
            cell.addSubview(ul)
        case 1:
            cell.textLabel?.text = "Ток КЗ на шинах"
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.font = self.viewfont
            il.textAlignment = .left
            il.font = UIFont.systemFont(ofSize: 20)
            itf.borderStyle = .roundedRect
            itf.font = self.viewfont
            itf.minimumFontSize = 15
            itf.adjustsFontSizeToFitWidth = true
            itf.textAlignment = .center
            cell.addSubview(itf)
            cell.addSubview(il)
        default:
            break
        }
        return cell
    }
    
    
    
}
