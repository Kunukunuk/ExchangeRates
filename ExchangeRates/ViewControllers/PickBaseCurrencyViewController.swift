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
    var baseCurrencyArray = ["EUR"]

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
            
            print(dataDictionary)
            
            let baseCurrency = dataDictionary["rates"] as! [String: Double]
            
            print(baseCurrency)
//            DispatchQueue.main.sync {
//                self.basePickerView.reloadAllComponents()
//            }
            
        }
        task.resume()
    }

}

extension PickBaseCurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return baseCurrencyArray.count
    }
    
    
}
