//
//  MainViewController.swift
//  Calc
//
//  Created by Даниил Иванов on 21/08/2019.
//  Copyright © 2019 Даниил Иванов. All rights reserved.
//

import UIKit

class InitialDataViewController: UIViewController {
    
    var ident = String()
    
    var cables = [CableModel] ()
    
    var source = [ChangeSource] ()
    
    var token: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Название точки КЗ и таблица
    lazy var cabletable: UITableView = {
        let CableTable = UITableView()
        CableTable.delegate = self
        CableTable.dataSource = self
        CableTable.delaysContentTouches = false
        CableTable.translatesAutoresizingMaskIntoConstraints = false
        return CableTable
    }()
    
    private var namesolve: UITextField = {
        let NameSolve = UITextField()
        NameSolve.translatesAutoresizingMaskIntoConstraints = false
        NameSolve.placeholder = "Точка КЗ"
        NameSolve.textAlignment = .center
        NameSolve.borderStyle = .roundedRect
        NameSolve.font = UIFont.systemFont(ofSize: 20)
        return NameSolve
    }()
    
    private var stackcableview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var cableLabel: UILabel =  {
        let CableLabel = UILabel ()
        CableLabel.font = UIFont.systemFont(ofSize: 20)
        CableLabel.textAlignment = .left
        CableLabel.translatesAutoresizingMaskIntoConstraints = false
        return CableLabel
    } ()
    
    lazy var buttoncable: UIButton = {
        let Button = UIButton.init(type: .system)
        Button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        Button.addTarget(self, action: #selector(AddCable(_:)), for: .touchUpInside)
        return Button
    }()

    @objc func AddCable(_ : UIButton) {
        print("Add Cable Button is tapped in controller")
        self.token = 0
        showAddWindow()
    }
//
// Исходные данные
    private var stackTitleview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var sourcelabel: UILabel = {
        let SourceLabel = UILabel ()
        SourceLabel.font = UIFont.systemFont(ofSize: 21)
        SourceLabel.text = "Исходные данные"
        SourceLabel.textAlignment = .left
        SourceLabel.translatesAutoresizingMaskIntoConstraints = false
        return SourceLabel
    }()
    
    lazy var buttonsource: UIButton = {
        let Button = UIButton.init(type: .system)
        Button.setTitle("Добавить", for: .normal)
        Button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        Button.addTarget(self, action: #selector(AddSource(sender:)), for: .touchUpInside)
        return Button
    }()
    
    public var titleULabel: UILabel = {
        let Ulabel = UILabel ()
        Ulabel.text = "Номинальное напряжение"
        Ulabel.font = UIFont.systemFont(ofSize: 20)
        Ulabel.textAlignment = .left
        Ulabel.translatesAutoresizingMaskIntoConstraints = false
        return Ulabel
    }()
    
    public var titleILabel: UILabel = {
        let Ilabel = UILabel ()
        Ilabel.text = "Ток КЗ на шинах"
        Ilabel.font = UIFont.systemFont(ofSize: 20)
        Ilabel.textAlignment = .left
        Ilabel.translatesAutoresizingMaskIntoConstraints = false
        return Ilabel
    }()
    
    private var uLabel: UILabel = {
        let ulabel = UILabel ()
        ulabel.font = UIFont.systemFont(ofSize: 20)
        ulabel.textAlignment = .left
        ulabel.translatesAutoresizingMaskIntoConstraints = false
        return ulabel
    }()
    
    private var iLabel: UILabel = {
        let ilabel = UILabel ()
        ilabel.font = UIFont.systemFont(ofSize: 20)
        ilabel.textAlignment = .left
        ilabel.translatesAutoresizingMaskIntoConstraints = false
        return ilabel
    }()
    
    @objc func AddSource(sender : UIButton) {
        sender.setTitle("Изменить", for: .normal)
        ShowAddSource()
    }
//
    
    lazy var subView: [UIView] = [self.stackcableview, self.namesolve, self.cabletable, self.stackTitleview]
    lazy var sourcesubView: [UIView] = [self.titleULabel, self.titleILabel, self.uLabel, self.iLabel]
    lazy var cablestack: [UIView] = [self.cableLabel, self.buttoncable]
    lazy var stacktitleview: [UIView] = [self.sourcelabel, self.buttonsource]
    
    init(viewWith: InitialHelper) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.white
        edgesForExtendedLayout = []
        
        //Кабели
        cableLabel.text = viewWith.name
        namesolve.placeholder = viewWith.kztf
        buttoncable.setTitle(viewWith.cablebutton, for: .normal)
        cabletable.register(UITableViewCell.self, forCellReuseIdentifier: viewWith.cabletable)
        self.ident = viewWith.cabletable
        
        
        for view in subView {self.view.addSubview(view) }
        for view in sourcesubView {self.view.addSubview(view) }
        for view in cablestack {self.stackcableview.addArrangedSubview(view) }
        for view in stacktitleview {self.stackTitleview.addArrangedSubview(view) }

        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: namesolve, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 90),
            NSLayoutConstraint(item: namesolve, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: stackTitleview, attribute: .top, relatedBy: .equal, toItem: namesolve, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackTitleview, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: stackTitleview, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -30),
            
            NSLayoutConstraint(item: titleULabel, attribute: .top, relatedBy: .equal, toItem: stackTitleview, attribute: .bottom, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: titleULabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: uLabel, attribute: .top, relatedBy: .equal, toItem: stackTitleview, attribute: .bottom, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: uLabel, attribute: .leading, relatedBy: .equal, toItem: titleULabel, attribute: .trailing, multiplier: 1, constant: 100),
            
            NSLayoutConstraint(item: titleILabel, attribute: .top, relatedBy: .equal, toItem: titleULabel, attribute: .bottom, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: titleILabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: iLabel, attribute: .top, relatedBy: .equal, toItem: titleULabel, attribute: .bottom, multiplier: 1, constant: 17),
            NSLayoutConstraint(item: iLabel, attribute: .leading, relatedBy: .equal, toItem: titleULabel, attribute: .trailing, multiplier: 1, constant: 100),
            
            NSLayoutConstraint(item: stackcableview, attribute: .top, relatedBy: .equal, toItem: titleILabel, attribute: .bottom, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: stackcableview, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: stackcableview, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -30),
            
            NSLayoutConstraint(item: cabletable, attribute: .top, relatedBy: .equal, toItem: stackcableview, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cabletable, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: cabletable, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -30),
            NSLayoutConstraint(item: cabletable, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -650),
            
            ])
    
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InitialDataViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in cabletable: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ cabletable: UITableView, numberOfRowsInSection: Int) -> Int {
        return cables.count
    }
    
    func tableView(_ cabletable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cabletable.dequeueReusableCell(withIdentifier: ident, for: indexPath)
        let cable = cables[indexPath.row]
        cell.textLabel?.text = cable.NameOfCable
        cell.textLabel?.textAlignment = .center
//        cabletable.tableFooterView = UIView()
        return cell
    }
    
    func tableView(_ cabletable: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = cables[indexPath.row]
        self.token = 1
        let adVC = ADViewController()
            adVC.token = token
            adVC.detailCable = row
        let navi = UINavigationController(rootViewController: adVC)
            navi.modalPresentationStyle = .formSheet
            navi.preferredContentSize = CGSize(width: 380, height: 185)
        present(navi, animated: true, completion: nil)
        cabletable.deselectRow(at: indexPath, animated: true)
}
    
    func tableView(_ cabletable: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.cables.remove(at: indexPath.row)
            self.cabletable.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension InitialDataViewController: CableDelegate {
    func sendDataCable(_ sendCable: ADViewController, didAddCable cable: CableModel) {
        cables.append(cable)
        cabletable.reloadData()
    }
    
    func sendChangeCable(_ sendChange: ADViewController, didChangeCable cable: CableModel) {
        cabletable.reloadData()
    }
}

extension InitialDataViewController {
    func showAddWindow() {
        let adVC = ADViewController()
        adVC.delegateCable = self
        adVC.token = token
        let navi = UINavigationController(rootViewController: adVC)
        navi.modalPresentationStyle = .formSheet
        navi.preferredContentSize = CGSize(width: 380, height: 185)
        present(navi, animated: true, completion: nil)
    }
}

extension InitialDataViewController: SourceDelegate {
    func sendSource(U: String, I: String) {
        uLabel.text = "U = \(U) кВ"
        iLabel.text = "I = \(I) кА"
        
        let bU = U
        let bI = I
        let asVC = ASViewController()
            asVC.u = bU
            asVC.i = bI
    }
}

extension InitialDataViewController {
    func ShowAddSource() {
        let asVC = ASViewController()
            asVC.delegateSource = self
            asVC.token = token
        let navi = UINavigationController(rootViewController: asVC)
        navi.modalPresentationStyle = .formSheet
        navi.preferredContentSize = CGSize(width: 380, height: 92.5)
        present(navi, animated: true, completion: nil)
    }
}
