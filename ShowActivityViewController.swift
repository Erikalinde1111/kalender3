//
//  ShowActivityViewController.swift
//  kalender3
//
//  Created by Erika Linde on 09/03/17.
//  Copyright © 2017 Erika Linde. All rights reserved.
//

import UIKit

class ShowActivityViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var project: Project?
    
    @IBOutlet weak var desciptOfProject: UITextView!
    @IBOutlet weak var task: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "\(project!.label!) \(project!.startDate!) - \(project!.endDate!)"
        task.text = project!.tasks?.startDate
        desciptOfProject.text = project?.descript
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //skriver man in mer text i descript skall core datan 
    //uppdateras försök att uppdatera för varje gång man skriver
    //göra ny context och köra saveContext()
    //men jag vill kalla saveContext() för varje knapptryckning

   

}
