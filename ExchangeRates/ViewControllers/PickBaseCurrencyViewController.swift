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

    override func viewDidLoad() {
        super.viewDidLoad()

        baseCurrencyPicker.delegate = self
        baseCurrencyPicker.dataSource = self
        // Do any additional setup after loading the view.
        getBaseCurrencySymbols()
    }
    

    func getBaseCurrencySymbols() {
        
        let url = URL(string: "https://api.exchangeratesapi.io/latest")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let dataJSON = data else {
                print("error with \(error?.localizedDescription)")
                return
            }
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: dataJSON, options: []) as! [String: Any]
            
            let baseCurrency = dataDictionary["rates"] as! [String: Double]
            
            print(baseCurrency)
            print(self.baseCurrencyArray.count)
//            DispatchQueue.main.sync {
//                self.basePickerView.reloadAllComponents()
//            }
            
        }
        task.resume()
    }
    
    @IBAction func selectBaseCurrency(_ sender: UIButton) {
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
}
