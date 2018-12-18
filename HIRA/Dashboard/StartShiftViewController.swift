//
//  StartShiftViewController.swift
//  HIRA
//
//  Created by Debashis  on 28/12/17.
//  Copyright © 2017 Debashis . All rights reserved.
//

import UIKit

class StartShiftViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var activeField: UITextField?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfTruck: UITextField!
    @IBOutlet weak var tfShift: UITextField!
    @IBOutlet weak var tfDistrict: UITextField!
    @IBOutlet weak var tfOdometer: UITextField!
    let picker = UIPickerView();
    let toolBar = UIToolbar()
    let trucks = ["truck 1", "truck 2", "truck 3", "truck 4", "truck 5", "truck 6"]
    let shifts = ["AM-Shift", "PM-Shift"]
    let districts = ["Disctrict 1", "Disctrict 2", "Disctrict 3", "Disctrict 4", "Disctrict 5", "Disctrict 6"]
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        setUpPickerView()
        tfTruck.inputAccessoryView = toolBar
        tfTruck.inputView = picker
        tfDistrict.inputAccessoryView = toolBar
        tfDistrict.inputView = picker
        tfShift.inputAccessoryView = toolBar
        tfShift.inputView = picker
        tfOdometer.inputAccessoryView = toolBar
        // Do any additional setup after loading the view.       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
        picker.reloadAllComponents()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    @IBAction func actionStartShift(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isShiftStarted")
        self.navigationController?.popViewController(animated: true)
    }
    func setUpPickerView(){
        picker.delegate = self
        picker.dataSource = self
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPicker))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
    }
    @objc func donePicker(_sender:Any){
        /*if(activeField?.tag == 4){
            activeField?.resignFirstResponder()
            return
        }*/
        if activeField?.tag == 1 {
            activeField?.text = trucks[picker.selectedRow(inComponent: 0)]
            activeField?.resignFirstResponder()
        }
        if activeField?.tag == 2 {
            activeField?.text = shifts[picker.selectedRow(inComponent: 0)]
            activeField?.resignFirstResponder()
        }
        if activeField?.tag == 3 {
            activeField?.text = districts[picker.selectedRow(inComponent: 0)]
            activeField?.resignFirstResponder()
        }
    }
    @objc func cancelPicker(_sender:Any){
        activeField?.resignFirstResponder()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeField?.tag == 1 {
            return trucks.count
        }
        if activeField?.tag == 2 {
            return shifts.count
        }
        if activeField?.tag == 3 {
            return districts.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activeField?.tag == 1 {
            return trucks[row]
        }
        if activeField?.tag == 2 {
            return shifts[row]
        }
        if activeField?.tag == 3 {
            return districts[row]
        }
        return ""
    }
    
}
