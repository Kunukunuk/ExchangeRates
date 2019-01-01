//
//  PickBaseCurrencyViewController.swift
//  ExchangeRates
//
//  Created by Kun Huang on 12/31/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class PickBaseCurrencyViewController: UIViewController {
    
    @IBOutlet weak var baseCurrencyPicker: UIPickerView!
    let baseCurrencyArray = ["AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK","EUR", "GBP", "HKD", "HRK", "HUF", "IDR", "ILS", "INR", "ISK", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN", "RON", "RUB", "SEK", "SGD", "THB", "TRY", "USD", "ZAR"]
    var pickedCurrency = "AUD"

    override func viewDidLoad() {
        super.viewDidLoad()

        baseCurrencyPicker.delegate = self
        baseCurrencyPicker.dataSource = self
        
    }
    
    @IBAction func selectBaseCurrency(_ sender: UIButton) {
        
        performSegue(withIdentifier: "showExchange", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showExchange" {
            let destinationVC = segue.destination as! ExchangeRateViewController
            destinationVC.baseCurrencySymbol = pickedCurrency
        }
    }

}

extension PickBaseCurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return baseCurrencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return baseCurrencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCurrency = baseCurrencyArray[row]
    }
}
