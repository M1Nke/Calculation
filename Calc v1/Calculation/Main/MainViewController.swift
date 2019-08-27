//
//  ViewController.swift
//  Calculation
//
//  Created by Даниил Иванов on 08/08/2019.
//  Copyright © 2019 Даниил Иванов. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CableDelegate, LoadDelegate {

    @IBOutlet var VoltageTextField: UITextField!
    @IBOutlet var CurrentTextField: UITextField!
    @IBOutlet var KodnTextField: UITextField!
    @IBOutlet var NameOfLoadLabel: UILabel!
    @IBOutlet var LoadLabel: UILabel!
    @IBOutlet var NameOfReleTextField: UITextField!
    @IBOutlet var KnTextField: UITextField!
    @IBOutlet var KszTextField: UITextField!
    @IBOutlet var KvTextField: UITextField!
    @IBOutlet var OZZ1TextField: UITextField!
    @IBOutlet var OZZ2TextField: UITextField!
    @IBOutlet var CableTable: UITableView!
    
    var cables = [Cable] ()
    var calc = Calc ()
    

    var nLoad = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var token: Int = 0

    func sendDataCable(_ sendCable: CableTableViewController, didAddCable cable: Cable) {
        cables.append(cable)
        CableTable.reloadData()
    }
    
    func sendChangeCable(_ sendChange: CableTableViewController, didChangeCable cable: Cable) {
        CableTable.reloadData()
    }
    
    func sendDataLoad(Name: String, Load: Double, nLoad: String) {
        NameOfLoadLabel.text = Name
        LoadLabel.text = String(Load)
        self.nLoad = nLoad
        self.token = 1
    }

    func tableView(_ CableTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cables.count
    }
    
    func tableView(_ CableTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CellOfCabel = CableTable.dequeueReusableCell(withIdentifier: "CableCellIdentifier", for: indexPath)
            let cable = cables[indexPath.row]
            CellOfCabel.textLabel?.text = cable.NameOfCable
            return CellOfCabel
    }
    
    func tableView(_ CableTable: UITableView, didSelectRowAt indexPath: IndexPath) {
            let rowCable = cables[indexPath.row]
            self.token = 1
            CableTable.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "CableTableView", sender: rowCable)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.cables.remove(at: indexPath.row)
            self.CableTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func AddCable(_ sender: Any) {
        self.token = 0
    }
    
    func Read() {
        calc.U = Double(VoltageTextField.text ?? "")!
        calc.I = Double(CurrentTextField.text ?? "")!
        calc.Kodn = Double(KodnTextField.text ?? "")!
        calc.NameRele = NameOfReleTextField.text ?? ""
        calc.Kn = Double(KnTextField.text ?? "")!
        calc.Ksz = Double(KszTextField.text ?? "")!
        calc.Kv = Double(KvTextField.text ?? "")!
//        calc.I1 = Double(OZZ1TextField.text ?? "")!
 //       calc.I2 = Double(OZZ2TextField.text ?? "")!
        calc.S = LoadLabel.text! 
        calc.cables = self.cables
    }
    
    @IBAction func Solve(_ sender: Any) {
        Read()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CableTableView" {
            let naviOfCable = segue.destination as! UINavigationController
            let addCable = naviOfCable.topViewController as! CableTableViewController
            addCable.delegateCable = self
            addCable.detailCable = sender as? Cable
            addCable.token = token
        } else if segue.identifier == "AddLoad" {
            let naviOfLoad = segue.destination as! UINavigationController
            let addLoad = naviOfLoad.topViewController as! LoadViewController
            addLoad.delegateLoad = self
            addLoad.vview = nLoad
            addLoad.Name = NameOfLoadLabel.text!
            addLoad.token = token
        } else if segue.identifier == "SolveView" {
        let naviSolve = segue.destination as! UINavigationController
        let solve = naviSolve.topViewController as! SolveViewController
            solve.cables = cables
            solve.calc = calc
        }
    }
}

