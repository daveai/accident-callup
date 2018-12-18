//
//  TruckStopWizardViewController.swift
//  HIRA
//
//  Created by Debashis  on 28/12/17.
//  Copyright © 2017 Debashis . All rights reserved.
//

import UIKit

class TruckStopWizardViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet var w1Content: UIView!
    @IBOutlet var w2Content: UIView!
    @IBOutlet var w3Content: UIView!
    @IBOutlet weak var w3View: UIView!
    @IBOutlet weak var w2View: UIView!
    @IBOutlet weak var w1View: UIView!
    @IBOutlet weak var w1ScrollView: UIScrollView!
    @IBOutlet weak var w2ScrollView: UIScrollView!
    @IBOutlet weak var w3ScrollView: UIScrollView!
    @IBOutlet weak var horizontalContainer: UIScrollView!
    @IBOutlet weak var w1Container: UIView!
    @IBOutlet weak var w2Container: UIView!
    @IBOutlet weak var w3Container: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnw1: UIButton!
    @IBOutlet weak var btnw2: UIButton!
    @IBOutlet weak var btnw3: UIButton!
    @IBOutlet weak var backNextStackView: UIStackView!
    @IBOutlet weak var btnImage: UIButton!
    let picker = UIImagePickerController()
    var currentPage = 0
    var activeField: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        w1View.addSubview(w1Content)
        w2View.addSubview(w2Content)
        w3View.addSubview(w3Content)
        horizontalContainer.delegate = self
        btnBack.isHidden = true
        picker.delegate = self
        registerForKeyboardNotifications()
    }
    override func viewDidLayoutSubviews() {
        w1Content.frame = w1View.bounds
        w2Content.frame = w2View.bounds
        w3Content.frame = w3View.bounds
        w1ScrollView.contentSize = CGSize(width: self.w1ScrollView.frame.width, height: self.w1Container.frame.height)
        w2ScrollView.contentSize = CGSize(width: self.w2ScrollView.frame.width, height: self.w2Container.frame.height)
        w3ScrollView.contentSize = CGSize(width: self.w3ScrollView.frame.width, height: self.w3Container.frame.height)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func gotToPage(page:CGFloat){
        horizontalContainer.setContentOffset(CGPoint(x: horizontalContainer.frame.size.width * page, y: 0.0), animated: true)
        currentPage = Int(page)
        switch page {
        case 0:
            clearAllBreadcumbs()
            btnw1.setImage(UIImage(named: "w1_active"), for: .normal)
            btnNext.setTitle("Next",for: .normal)
            break
        case 1:
            clearAllBreadcumbs()
            btnw2.setImage(UIImage(named: "w2_active"), for: .normal)
            btnNext.setTitle("Next",for: .normal)
            break
        case 2:
            clearAllBreadcumbs()
            btnw3.setImage(UIImage(named: "w3_active"), for: .normal)
            btnNext.setTitle("Finish",for: .normal)
            break
        default: break
            
        }
        if currentPage > 0 {
            btnBack.isHidden = false
        } else {
            btnBack.isHidden = true
        }
        self.view.endEditing(true)
    }

    @IBAction func actionGotoPage0(_ sender: Any) {
        gotToPage(page: 0)
        clearAllBreadcumbs()
        btnw1.setImage(UIImage(named: "w1_active"), for: .normal)
    }
    @IBAction func actionGotoPage1(_ sender: Any) {
        gotToPage(page: 1)
        clearAllBreadcumbs()
        btnw2.setImage(UIImage(named: "w2_active"), for: .normal)
    }
    @IBAction func actionGotoPage2(_ sender: Any) {
        gotToPage(page: 2)
        clearAllBreadcumbs()
        btnw3.setImage(UIImage(named: "w3_active"), for: .normal)
    }
    func clearAllBreadcumbs(){
        btnw1.setImage(UIImage(named: "w1_inactive"), for: .normal)
        btnw2.setImage(UIImage(named: "w2_inactive"), for: .normal)
        btnw3.setImage(UIImage(named: "w3_inactive"), for: .normal)
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    @IBAction func actionBack(_ sender: Any) {
        if currentPage > 0 {
            currentPage = currentPage - 1
            gotToPage(page: CGFloat(currentPage))
        }
    }
    @IBAction func actionNext(_ sender: Any) {
        if currentPage == 2 {
            self.performSegue(withIdentifier: "StopDetails", sender: self)
        }
        if currentPage < 2 {
            currentPage = currentPage + 1
            gotToPage(page: CGFloat(currentPage))
        }
    }
    @IBAction func actionOpenImagePicker(_ sender: Any) {
        let actionSheetController = UIAlertController (title: "Choose source", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        actionSheetController.popoverPresentationController?.sourceRect = self.view.frame
        //Add Cancel-Action
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        //Add Save-Action
        actionSheetController.addAction(UIAlertAction(title: "From Camera", style: UIAlertActionStyle.default, handler: { (actionSheetController) -> Void in
            self.picker.allowsEditing = false
            self.picker.sourceType = .camera
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true, completion: nil)
        }))
        
        //Add Discard-Action
        actionSheetController.addAction(UIAlertAction(title: "From Library", style: UIAlertActionStyle.default, handler: { (actionSheetController) -> Void in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true, completion: nil)
        }))
        
        //present actionSheetController
        present(actionSheetController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        btnImage.contentMode = .scaleToFill //3
        btnImage.setBackgroundImage(chosenImage, for: .normal)  //4
        dismiss(animated:true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        switch currentPage {
        case 0:
            self.w1ScrollView.isScrollEnabled = true
        case 1:
            self.w2ScrollView.isScrollEnabled = true
        case 2:
            self.w3ScrollView.isScrollEnabled = true
        default:
            break
        }
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        switch currentPage {
        case 0:
            self.w1ScrollView.contentInset = contentInsets
            self.w1ScrollView.scrollIndicatorInsets = contentInsets
        case 1:
            self.w2ScrollView.contentInset = contentInsets
            self.w2ScrollView.scrollIndicatorInsets = contentInsets
        case 2:
            self.w3ScrollView.contentInset = contentInsets
            self.w3ScrollView.scrollIndicatorInsets = contentInsets
        default:
            break
        }
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                switch currentPage {
                case 0:
                    self.w1ScrollView.scrollRectToVisible(activeField.frame, animated: true)
                case 1:
                    self.w2ScrollView.scrollRectToVisible(activeField.frame, animated: true)
                case 2:
                    self.w3ScrollView.scrollRectToVisible(activeField.frame, animated: true)
                default:
                    break
                }
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        switch currentPage {
        case 0:
            self.w1ScrollView.contentInset = contentInsets
            self.w1ScrollView.scrollIndicatorInsets = contentInsets
            //self.w1ScrollView.isScrollEnabled = false
        case 1:
            self.w2ScrollView.contentInset = contentInsets
            self.w2ScrollView.scrollIndicatorInsets = contentInsets
            //self.w2ScrollView.isScrollEnabled = false
        case 2:
            self.w3ScrollView.contentInset = contentInsets
            self.w3ScrollView.scrollIndicatorInsets = contentInsets
            //self.w3ScrollView.isScrollEnabled = false
        default:
            break
        }
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        activeField = textView
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        activeField = nil
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        return true
    }
}
