//
//  DatePickerViewController.swift
//  kalender3
//
//  Created by Erika Linde on 09/03/17.
//  Copyright © 2017 Erika Linde. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePickerStart: UIDatePicker!
    @IBOutlet weak var datePickerEnd: UIDatePicker!
    var btnLabelText:String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addView = segue.destination as! AddActivityViewController
        addView.dateInfo = datePickerStart.date
        addView.dateInfoEnd = datePickerEnd.date
        
        print(btnLabelText)
        addView.btnLabelText = btnLabelText
    }
    
   
}
