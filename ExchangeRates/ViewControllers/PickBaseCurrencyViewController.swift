//
//  PickBaseCurrencyViewController.swift
//  ExchangeRates
//
//  Created by Kun Huang on 12/31/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class PickBaseCurrencyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
//            DispatchQueue.main.sync {
//                self.basePickerView.reloadAllComponents()
//            }
            
        }
        task.resume()
    }

}
