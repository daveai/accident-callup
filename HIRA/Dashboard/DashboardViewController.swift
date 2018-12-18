//
//  DashboardViewController.swift
//  HIRA
//
//  Created by Debashis  on 28/12/17.
//  Copyright © 2017 Debashis . All rights reserved.
//

import UIKit
import Gloss
class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var shifts:[Shift]?
    struct Segue {
        static let TO_START_SHIFT = "toStartShift"
    }
    @IBOutlet weak var btnTruckStop: UIButton!
    @IBOutlet weak var btnStartEndShift: UIButton!
    @IBOutlet weak var bottomSpaceTable: NSLayoutConstraint!
    @IBOutlet weak var shiftTableView: UITableView!
    
    func setUp(shifts:[Shift]){
        self.shifts = shifts
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell: RecentShiftTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? RecentShiftTableViewCell
        if cell == nil {
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RecentShiftTableViewCell
        }
        cell.name.text = shifts![indexPath.section].name
        cell.markerView.backgroundColor = .random()
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.shifts?.count)!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shiftTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if (UserDefaults.standard.value(forKey: "isShiftStarted") == nil || UserDefaults.standard.value(forKey: "isShiftStarted") as! Bool == false){
            btnTruckStop.isHidden = true
            btnStartEndShift.setImage(#imageLiteral(resourceName: "startshift"), for: .normal)
            bottomSpaceTable.constant = 0
            self.view.setNeedsUpdateConstraints()
            self.view.layoutIfNeeded()
        } else {
            btnTruckStop.isHidden = false
            btnStartEndShift.setImage(#imageLiteral(resourceName: "endshift"), for: .normal)
            bottomSpaceTable.constant = 83
            self.view.setNeedsUpdateConstraints()
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func actionStartEndShift(_ sender: Any) {
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {        
        if identifier == Segue.TO_START_SHIFT {
            if (UserDefaults.standard.value(forKey: "isShiftStarted") as! Bool == true){
                UserDefaults.standard.set(false, forKey: "isShiftStarted")
                btnTruckStop.isHidden = true
                btnStartEndShift.setImage(#imageLiteral(resourceName: "startshift"), for: .normal)
                bottomSpaceTable.constant = 0
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
                return false
            }
        }
        return true
    }
    

}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
