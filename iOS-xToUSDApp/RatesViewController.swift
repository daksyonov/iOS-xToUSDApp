//
//  ViewController.swift
//  iOS-xToUSDApp
//
//  Created by Dmitry Aksyonov on 03.08.2020.
//  Copyright © 2020 Dmitry Aksyonov. All rights reserved.
//

import UIKit

class RatesViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var tagInputTextField: UITextField!
    @IBOutlet weak var currencyInputTextField: UITextField!
    
    var currencyPicker  = UIPickerView()
    var toolBar = UIToolbar()
    
    var pickerData = [Currency]()
    
    let ratesGetter = GetRate.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCurrencyPicker()
        collectPickerData()
        
        currencyPicker.delegate = self
        
    }
    
    @IBAction func getRateAction(_ sender: Any) {
        ratesGetter.getRate(tag: tagInputTextField.text ?? "") { data, status in
            if let data = data, status {
            } else if status {
                print("****** Error Decoding Data ******")
            } else {
                print("****** Error Obtaining Data ******")
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    self.rateLabel.text = "$\(Float(data.value))"
                    
                    if self.currencyInputTextField.text?.isEmpty == false {
                        self.textLabel.text = "\(self.currencyInputTextField.text ?? "X") to USD Rate Is:"
                    }
                    
                    if self.tagInputTextField.text != self.currencyInputTextField.text {
                        self.textLabel.text = "\(self.tagInputTextField.text ?? "X") to USD Rate Is:"
                        self.currencyInputTextField.text? = ""
                    }
                } else {
                    let alertController = UIAlertController(
                        title: "Oh snap!",
                        message: "Seems like you enetered nothing. Or just a wrong token. \nOtherwise it's not your fault, we'll fix it ASAP, sorry! \n\nMake sure to write a report to: \nios-feedback@latoken.com \n\nThank you!",
                        preferredStyle: .alert
                    )
                    
                    let alertAction = UIAlertAction(
                        title: "OK",
                        style: .cancel,
                        handler: { _ in
                            alertController.dismiss(
                                animated: true,
                                completion: nil
                            )
                    })
                    
                    alertController.addAction(alertAction)
                    
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
    func collectPickerData() {
        ratesGetter.getCurrencies() { (data, status) in
            if let data = data, status {
                
                data.forEach {
                    self.pickerData.append($0)
                }
                
                self.pickerData.sort { $0.name < $1.name }
            }
        }
    }
    
}

