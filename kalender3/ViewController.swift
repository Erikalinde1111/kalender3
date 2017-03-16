//
//  ViewController.swift
//  kalender3
//
//  Created by Erika Linde on 08/03/17.
//  Copyright © 2017 Erika Linde. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var newProjectBtn: UIButton!
    @IBOutlet weak var newTaskBtn: UIButton!
    var projects: [Project] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         let project = projects[indexPath.row]
        cell.textLabel?.text = "\(project.label!)  \(project.startDate!) - \(project.endDate!)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newProject" {
            let chooseDates = segue.destination as! DatePickerViewController
            chooseDates.btnLabelText = newProjectBtn.titleLabel!.text
        }
        else if segue.identifier == "newTask" {
            let chDates = segue.destination as! DatePickerViewController
                chDates.btnLabelText = newTaskBtn.titleLabel!.text
        }
        else if segue.identifier == "showactivity" {
            let showActivity = segue.destination as! ShowActivityViewController
           let cell = sender as! UITableViewCell
            let indexPath = table.indexPath(for: cell)!
            let project = projects[indexPath.row]
           showActivity.project = project
        }
        else {
            
        }
        

    }
    
    func getData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Project")
        
        do {
            projects = try context.fetch(request) as! [Project]
            for project in projects {
                print("\(project.id) har stardatum \(project.startDate) har syssla \(project.tasks?.startDate)")
            }
        }
        catch let error {
            NSLog("Kunde inte hämta från core data \(error)")
        }
        

    }
    

}

