//
//  RatesViewController+TextFields.swift
//  iOS-xToUSDApp
//
//  Created by Dmitry Aksyonov on 03.08.2020.
//  Copyright © 2020 Dmitry Aksyonov. All rights reserved.
//

import Foundation
import UIKit

extension RatesViewController: UITextFieldDelegate {
 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if currencyInputTextField.text?.isEmpty == false &&
            textField == tagInputTextField {
            textField.text = "\(pickerData[currencyPicker.selectedRow(inComponent: 0)].tag)"
        }
    }
}
