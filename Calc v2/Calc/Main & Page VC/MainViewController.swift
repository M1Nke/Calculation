//
//  PageViewController.swift
//  Calc
//
//  Created by Даниил Иванов on 22/08/2019.
//  Copyright © 2019 Даниил Иванов. All rights reserved.
//

import UIKit

class MainViewController: UIPageViewController {

    var ss = [InitialHelper]()
    
    var labelsVC = [InitialDataViewController] ()
    
    var ui: ChangeSource!
    
    var num: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BarItems()
        FirstPage()
    }
    
    fileprivate func BarItems() {
        title = "Расчеты РЗА"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Добавить КЗ", style: .plain, target: self, action: #selector(AddCalc(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Рассчитать", style: .plain, target: self, action: #selector(Solve(_:)))
    }
    
    fileprivate func FirstPage() {
        
        let first = InitialHelper(kztf: "Точка КЗ", cabletable: "\(num)", name: "Кабели \(num)", cablebutton: "Добавить")
        self.labelsVC.append(InitialDataViewController(viewWith: first))
        setViewControllers([labelsVC[0]], direction: .forward, animated: true, completion: nil)
        ss.append(first)
    }
    
    @objc func AddCalc(_ : UIBarButtonItem) {
        print("Добавить точку КЗ")
        self.num += 1
        AddPage()
    }
    
    fileprivate func AddPage() {
        let view = InitialHelper(kztf: "Точка КЗ", cabletable: "\(num)", name: "Кабели \(num)", cablebutton: "Добавить")
        self.labelsVC.append(InitialDataViewController(viewWith: view))
        setViewControllers([labelsVC[num]], direction: .forward, animated: true, completion: nil)
        ss.append(view)
        
        // MARK: Удаление view с последующих страниц
/*        if num > 0 {
        for ss in [labelsVC[num]] {
            for view in ss.stacktitleview {
                view.removeFromSuperview()
                for view in ss.sourcesubView {
                    view.removeFromSuperview()
                    }
                }
            }
        }   */
    }
    
    @objc func Solve(_ : UIBarButtonItem) {
        print("Рассчитать")
    }
    
    //MARK: - init UIPageViewController
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = UIColor.black
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("Листается назад")
        guard let viewController = viewController as? InitialDataViewController else {return nil}
        if let index = labelsVC.firstIndex(of: viewController) {
        if index > 0 {
            return labelsVC[index - 1]
        }
    }
            return nil
}
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("Листается вперед")
        guard let viewController = viewController as? InitialDataViewController else {return nil}
        if let index = labelsVC.firstIndex(of: viewController) {
            if index < ss.count - 1 {
                return labelsVC[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return ss.count
    }
    

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

