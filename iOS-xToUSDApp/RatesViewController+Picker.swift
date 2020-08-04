//
//  RatesViewcontroller+Picker.swift
//  iOS-xToUSDApp
//
//  Created by Dmitry Aksyonov on 03.08.2020.
//  Copyright © 2020 Dmitry Aksyonov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Picker View Data Source

extension RatesViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int
    { return pickerData.count }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String?
        
    { return pickerData[row].name }
    
}

// MARK: - Picker View Delegate

extension RatesViewController: UIPickerViewDelegate {
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    )
    {
        currencyInputTextField.text = pickerData[row].name
        tagInputTextField.text = pickerData[row].tag
    }
    
}

// MARK: - Category Picker & Toolbar Stuff

extension RatesViewController {
    
    func createCurrencyPicker() {
        currencyPicker = UIPickerView(
            frame: CGRect(
                x: 0,
                y: 200,
                width: view.frame.width,
                height: 216
            )
        )
        
        currencyPicker.backgroundColor = .none
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(categoryPickerDoneButtonHit)
        )
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(categoryPickerDoneButtonHit)
        )
        
        toolBar.setItems(
            [cancelButton, flexibleSpace, doneButton],
            animated: true)
        toolBar.isUserInteractionEnabled = true
        
        currencyInputTextField.inputView = currencyPicker
        currencyInputTextField.inputAccessoryView = toolBar
    }
    
    @objc func categoryPickerDoneButtonHit() {
        currencyInputTextField.resignFirstResponder()
    }
    
}
