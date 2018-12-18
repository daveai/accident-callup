//
//  LoginViewController.swift
//  HIRA
//
//  Created by Debashis  on 28/12/17.
//  Copyright © 2017 Debashis . All rights reserved.
//

import UIKit
import Alamofire
import Gloss
class LoginViewController: UIViewController {
    var activeField: UITextField?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var changeOrgPopup: UIView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        changeOrgPopup.alpha = 0.0
        registerForKeyboardNotifications()
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
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    @IBAction func actionChangeOrg(_ sender: Any) {
        changeOrgPopup.frame = self.view.bounds
        self.view.addSubview(changeOrgPopup)
        UIView.animate(withDuration: 0.5) {
            self.changeOrgPopup.alpha = 1.0
        }
    }
    
    @IBAction func actionChangePopup(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.changeOrgPopup.alpha = 0.0
        }) { (isCompleted) in
            self.changeOrgPopup.removeFromSuperview()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        indicator.isHidden = false
        login(userName: userName.text!, password: password.text!, userType: 2)
        indicator.startAnimating()
    }
    
    func login(userName:String, password:String, userType:Int){
        Web.XHR(path: "login", paramerters: ["email":userName,"password":password,"user_type":userType], requestHeader: [:], onCompletion: { (response, status, headers) in
            if status != 200 {
                let jsonResponse = response as! JSON
                let alert = UIAlertController(title: "Error", message:jsonResponse["message"] as? String , preferredStyle:UIAlertControllerStyle.alert)
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
            } else {
                let responseHeaders:[String:String] = headers as! [String : String]
                let x_auth_token:String = responseHeaders["X-Auth-Token"]!
                print(x_auth_token)
                let jsonResponse = response as! JSON
                let userDetails = jsonResponse["user_details"] as! JSON
                let user:User! = User(json: userDetails)
                UserDefaults.standard.setValue(x_auth_token, forKey: "x_auth_token")
                UserDefaults.standard.setValue(user.id, forKey: "current_user_id")
                let containerStoryBoard = UIStoryboard(name: "container", bundle: nil)
                let initialViewController = containerStoryBoard.instantiateViewController(withIdentifier: "container_nav") as! UINavigationController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = initialViewController
                
            }            
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }) { (response, status, headers) in
            let errorResponse = response as! HIRAError
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
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
}
