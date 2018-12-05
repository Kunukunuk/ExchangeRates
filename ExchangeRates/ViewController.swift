//
//  ViewController.swift
//  ExchangeRates
//
//  Created by Kun Huang on 12/4/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var basePickerView: UIPickerView!
    @IBOutlet weak var baseLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        basePickerView.delegate = self
        basePickerView.dataSource = self
        
        getAPIData()
    }

    func getAPIData() {
        
        let url = URL(string: "https://api.exchangeratesapi.io/latest?base=USD")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let dataJSON = data else {
                print("error with \(error?.localizedDescription)")
                return
            }
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: dataJSON, options: []) as! [String: Any]
            
            print(dataDictionary)
        }
        task.resume()
    }

}

