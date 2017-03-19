//
//  ShowActivityViewController.swift
//  kalender3
//
//  Created by Erika Linde on 09/03/17.
//  Copyright © 2017 Erika Linde. All rights reserved.
//

import UIKit
import CoreData

class ShowActivityViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var label: UILabel!
    var project: Project?
    
    
    @IBOutlet weak var desciptOfProject: UITextView!
    @IBOutlet weak var task: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "\(project!.label!) \(project!.startDate!) - \(project!.endDate!)"
        task.text = project!.tasks?.startDate
        desciptOfProject.text = project?.descript
       
    }
    
    
    //ha denna funktion för att spara ner texten till projectets description
    func textViewDidEndEditing(_ textView: UITextView) {
        
        project?.descript = desciptOfProject.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    //nedanstående funktion är för att dismissa keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.desciptOfProject.resignFirstResponder()
    }
}
