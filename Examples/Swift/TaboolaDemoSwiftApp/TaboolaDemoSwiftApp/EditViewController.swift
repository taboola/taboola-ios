//
//  EditViewController.swift
//  TaboolaDemoSwiftApp
//

import UIKit

typealias EditViewControllerHandler = ([String: String]) -> Void

class EditViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: Properties
    var arrayOfKeys = [String]()
    var defaultValues = [String]()
    var handler: EditViewControllerHandler?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
        arrayOfKeys = ["mode", "publisher", "pageType", "pageURL", "placement"]
        defaultValues = ["thumbnails-sdk3", "betterbytheminute-app", "article", "http://www.example.com", "Mobile"]
        getDataFromTextFileds()
        updateButtonEnabled()
    }
    
    //MARK: Fileprivate functions
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    fileprivate func getDataFromTextFileds() {
        UserDefaults.standard.synchronize()
        for (index, textField) in textFields.enumerated() {
            textField.text = UserDefaults.standard.string(forKey: arrayOfKeys[index]) ?? defaultValues[index]
        }
    }
    
    fileprivate func saveDataFromTextFields() {
        for (index, textField) in textFields.enumerated() {
            UserDefaults.standard.set(textField.text, forKey: self.arrayOfKeys[index])
        }
    }
    
    fileprivate func updateButtonEnabled() {
        var isEnabled: Bool = true
        for textField: UITextField in textFields {
            if textField.text == "" {
                isEnabled = false
                break
            }
        }
        saveButton.isEnabled = isEnabled
    }
}

//MARK: Extemsions
extension EditViewController {
    
    @IBAction func actionSaveContent(_ sender: UIButton) {
        if (handler != nil) {
            var widgetAttributes = [String: String]()
            var index: Int = 0
            for key in arrayOfKeys {
                widgetAttributes[key] = textFields[index].text
                index += 1
            }
            self.handler?(widgetAttributes)
        }
        saveDataFromTextFields()
        dismiss(animated: true, completion: { _ in })
    }
    @IBAction func actionChangeTextField(_ sender: UITextField) {
        updateButtonEnabled()
    }
}

extension EditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let currentIndex = (textFields.index { $0 === textField })!
        if currentIndex + 1 < textFields.count {
            textFields[currentIndex + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
