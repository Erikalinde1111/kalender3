//
//  ViewController.swift
//  kalender3
//
//  Created by Erika Linde on 08/03/17.
//  Copyright © 2017 Erika Linde. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var newProjectBtn: UIButton!
    @IBOutlet weak var newTaskBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "Lur"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let chooseDates = segue.destination as! DatePickerViewController
        if segue.identifier == "newProject" {
            chooseDates.btnLabelText = newProjectBtn.titleLabel!.text
        }else {
            chooseDates.btnLabelText = newTaskBtn.titleLabel!.text
        }
        

    }
    

}

