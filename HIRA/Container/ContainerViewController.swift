//
//  ContainerViewController.swift
//  HIRA
//
//  Created by Debashis  on 26/12/17.
//  Copyright © 2017 Debashis . All rights reserved.
//

import UIKit
import Gloss
import PKHUD
class ContainerViewController: UIViewController, MenuViewDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var btnBack: UIBarButtonItem!
    var oldBtnBack:UIBarButtonItem?
    var myShifts:[Shift]?
    struct SEGUE {
        static let EMB_MENU:String = "EMB_MENU"
    }
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var blurContainer: UIView!
    var menuTableViewController:MenuTableViewController?
    var isMenuOpen = false
    var currentViewController:UINavigationController = UINavigationController()
    override func viewDidLoad() {
        super.viewDidLoad()
        HUD.show(.labeledProgress(title: "Fetching shifts", subtitle: ""))
        let command = "get-shift?iDisplayLength=100&sEcho=1&iDisplayStart=1&iSortCol_0=0&sSortDir_0=desc"
        Web.XHRGet(path: command, paramerters: [:], requestHeader: ["X-Auth-Token":UserDefaults.standard.value(forKey: "x_auth_token") as! String!], onCompletion: { (shiftresponse, isShiftSuccess, shiftHeader) in
            print(shiftresponse)
            let shiftresponse = shiftresponse as! JSON
            let aaData:[JSON] = shiftresponse["aaData"] as! [JSON]
            self.myShifts = [Shift].from(jsonArray: aaData)!
            let childViewController: UINavigationController = {
                // Load Storyboard
                let storyboard = UIStoryboard(name: "Dashboard", bundle: Bundle.main)
                // Instantiate View Controller
                let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
                let dashboardViewController = viewController.visibleViewController as! DashboardViewController
                dashboardViewController.setUp(shifts: self.myShifts!)
                return viewController
            }()
            childViewController.delegate = self
            self.add(asChildViewController: childViewController)
            HUD.hide()
        }, onFailure: { (shiftFailResponse, isShiftSuccess, shiftHeader) in
            HUD.hide()
            let errorResponse = shiftFailResponse as! HIRAError
            let alert = UIAlertController(title: "Error", message:errorResponse.message, preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)
        })
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowOffset = CGSize.zero
        menuView.layer.shadowRadius = 4
        self.blurContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedOnBody)))
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        oldBtnBack = self.navigationItem.rightBarButtonItem
        self.navigationItem.rightBarButtonItem = nil
    }
    private func add(asChildViewController viewController: UINavigationController) {
        
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)       
        self.navigationItem.title = viewController.visibleViewController?.navigationItem.title!
        currentViewController = viewController
    }
    @objc func tappedOnBody(){
       hideMenuView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func openMenuView(){
        self.view.addSubview(blurContainer)
        blurContainer.frame = self.view.bounds
        self.view.bringSubview(toFront: menuView)
        self.menuViewLeadingConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        isMenuOpen = true
    }
    func hideMenuView(){
        self.menuViewLeadingConstraint.constant = -260
        self.blurContainer.removeFromSuperview()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        isMenuOpen = false
    }
    @IBAction func actionToggleMenu(_ sender: Any) {
        if !isMenuOpen {
            openMenuView()
        } else {
            hideMenuView()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE.EMB_MENU {
            self.menuTableViewController = segue.destination as? MenuTableViewController
            self.menuTableViewController?.menuViewDelegate = self
        }
    }
    
    func didSelectAMenu(selectedMenu: [String : String]) {        
        if selectedMenu["name"] != "" {
            if self.childViewControllers.count > 0 {
                let viewControllers:[UIViewController] = self.childViewControllers
                for viewContoller in viewControllers {
                    if viewContoller is UINavigationController {
                        viewContoller.willMove(toParentViewController: nil)
                        viewContoller.view.removeFromSuperview()
                        viewContoller.removeFromParentViewController()
                    }
                }
            }
            let childViewController: UINavigationController = {
                // Load Storyboard
                let storyboard = UIStoryboard(name: selectedMenu["name"]!, bundle: Bundle.main)
                // Instantiate View Controller
                //let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
                let viewController = storyboard.instantiateViewController(withIdentifier: selectedMenu["root"]!) as! UINavigationController
                return viewController
            }()
            childViewController.delegate = self
            add(asChildViewController: childViewController)
        }
        hideMenuView()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        currentViewController.popViewController(animated: true)
    }
    override func viewDidLayoutSubviews() {
        
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.title = currentViewController.visibleViewController?.navigationItem.title        
        if currentViewController.viewControllers.count > 1 {
            self.navigationItem.rightBarButtonItem = oldBtnBack
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
}
