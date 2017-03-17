//
//  ConverterViewController.swift
//  lab4
//
//  Created by Konstantin Terehov on 3/17/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    let converter = ConverterModel()

    @IBOutlet weak var textFieldBYN: UITextField!
    @IBOutlet weak var labelUSD: UILabel!
    @IBOutlet weak var labelEUR: UILabel!
    @IBOutlet weak var labelRUB: UILabel!
    @IBAction func buttonConvertClick(_ sender: Any) {
        if let valueInBYN = getValueInBYN() {
            let converted = converter.getConvertedValues(valueInBYN: valueInBYN)
            showResult(converted: converted)
        } else {
            handleInvalidInput()
        }
    }
    
    func getValueInBYN() -> Double?{
        var result: Double?
        if (textFieldBYN.text ?? "").isEmpty {
            result = 1.0
        } else {
            result = Double(textFieldBYN.text!)
            result = (result == 0) ? 1 : result
        }
        return result
    }
    
    func handleInvalidInput() {
        textFieldBYN.text = nil
        showRates()
        showAlert()
    }
    
    func showRates() {
        showResult(converted: converter.getRates())
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: "Error", message: "Invalid input.", preferredStyle:.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showResult(converted: [Currency:Double]){
        labelUSD.text = "\(Currency.USD): \(converted[Currency.USD]!)"
        labelEUR.text = "\(Currency.EUR): \(converted[Currency.EUR]!)"
        labelRUB.text = "\(Currency.RUB): \(converted[Currency.RUB]!)"
    }

}
