//
//  ViewController.swift
//  ExchangeRates
//
//  Created by Kun Huang on 12/4/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var basePickerView: UIPickerView!
    @IBOutlet weak var baseValue: UITextField!
    @IBOutlet weak var convertedValue: UITextField!
    
    var basePickerLabels = [String]()
    var basePickerData: [String: Double] = [:]
    var pickedCurrency: String = ""
    var baseCurrencySymbol: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        basePickerView.delegate = self
        basePickerView.dataSource = self
        
        getAPIData(of: baseCurrencySymbol!)
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return basePickerLabels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return basePickerLabels[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickedCurrency = basePickerLabels[row]
        
    }
    
    @IBAction func convertValue(_ sender: UIButton) {
        guard let value = Double(baseValue.text!) else {
            return
        }
        
        if pickedCurrency != "" {
            let double = basePickerData[pickedCurrency]
            let convert = double! * value
            let stringOutput = String(format: "%.2f", convert)
            convertedValue.text = stringOutput
        } else {
            print("bye")
        }
        
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func getAPIData(of symbol: String) {
        
        let url = URL(string: "https://api.exchangeratesapi.io/latest?base=\(symbol)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let dataJSON = data else {
                print("error with \(error?.localizedDescription)")
                return
            }
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: dataJSON, options: []) as! [String: Any]
            
            let rates = dataDictionary["rates"] as! [String: Double]
            
            for (key, value) in rates {
                
                if self.pickedCurrency == "" {
                    self.pickedCurrency = key
                    print(self.pickedCurrency)
                }
                self.basePickerLabels.append(key)
                self.basePickerData[key] = value
                
            }
            DispatchQueue.main.sync {
                self.basePickerView.reloadAllComponents()
            }
            
        }
        task.resume()
    }

}

