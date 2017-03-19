//
//  AddActivityViewController.swift
//  kalender3
//
//  Created by Erika Linde on 09/03/17.
//  Copyright © 2017 Erika Linde. All rights reserved.
//

import UIKit
import CoreData

class AddActivityViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    
    
    @IBOutlet weak var descript: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dateEnd: UITextView!
    @IBOutlet weak var date: UITextView!
    var dateInfo: Date!
    var dateInfoEnd: Date!
    var btnLabelText: String!
    let imagePicker = UIImagePickerController()
    var i = 0
    var j = 0
    var k = 0
    let defaultID = UserDefaults.standard
    var t1: Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateF = DateFormatter()
        let short = DateFormatter.Style.short
        dateF.dateStyle = short
        dateF.timeStyle = short
        dateF.dateFormat = "MM/DD/YY"
        let strDateS = dateF.string(from: dateInfo)
        date.text = strDateS
        print(strDateS)
        
        let strDateEnd = dateF.string(from: dateInfoEnd)
        dateEnd.text = strDateEnd
        print(strDateEnd)
        label.text = btnLabelText
        //strdate blir summan av hur många dar in på året vi är så 1 Jan är 1, 2 Jan är 2 o s v
       
    }

    
    @IBAction func addImage(_ sender: UIButton) {
        i += 1
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.image.image = image
       
        if let data = UIImagePNGRepresentation(image){
            let url = URL(fileURLWithPath: imagePath)
            try! data.write(to: url)
            NSLog("Sparat bilddata till fil, \(imagePath)")
        }
         imagePicker.dismiss(animated: true, completion: nil)
    }
    
    var imagePath : String{
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if var imageNumber = UserDefaults.standard.integer(forKey: "imageNumber") as? Int{
            imageNumber += 1
            UserDefaults.standard.set(imageNumber, forKey: "imageNumber")
            
            if let documentDirectory = paths.first {
                
                return documentDirectory.appending("/cached\(imageNumber).png")
            }else{
                fatalError("No documents directory")
            }
            
        }else{
            if let documentDirectory = paths.first {
                
                return documentDirectory.appending("/cached\(1).png")
                //Nu kommer alla bilder heta "cached.png" så lägger till en unik siffra med
            }else{
                fatalError("No documents directory")
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addActivity(_ sender: Any) {
        
        if(label.text == "NYTT PROJEKT"){
            
            let context1 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let request1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            //vill välja en syssla som har samma startdatum som date ovan och lägga den som project.task
            request1.predicate = NSPredicate(format: "startDate = %@", date.text)
            print("predicate:  \(request1.predicate)")
            do {
                let tasks = try context1.fetch(request1) as! [Task]
                t1 = tasks.first
                for task in tasks {
                    print("task  \(task.id) har stardatum \(task.startDate)")
                }
            }
            catch let error {
                NSLog("Kunde inte hämta från core data \(error)")
            }

            
            
            j = defaultID.integer(forKey: "id")
            j += 1
            defaultID.set(j, forKey: "id")

            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let projectDescription = NSEntityDescription.entity(forEntityName: "Project", in: context)!
            let project = NSManagedObject(entity: projectDescription, insertInto: context) as! Project
            let idP = defaultID.integer(forKey: "id")
            project.id = Int32(idP)
            project.startDate = date.text
            project.endDate = dateEnd.text
            project.label = label.text
            project.descript = descript.text
            project.source = ""
            project.tasks = t1
            //documentDirectory är en string med sökvägen till bilden den strängen skall läggas till varje project
            
            do{
                try (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            catch let error {
                NSLog("Kunde inte spara till core data \(error)")
            }
            
        } else {
            k = defaultID.integer(forKey: "id")
            k += 1
            defaultID.set(k, forKey: "id")
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let taskDescription = NSEntityDescription.entity(forEntityName: "Task", in: context)!
            let task = NSManagedObject(entity: taskDescription, insertInto: context) as! Task
            
            
            
            let idT = defaultID.integer(forKey: "id")
            task.id = Int32(idT)
            task.startDate = date.text
            task.endDate = dateEnd.text
            task.label = label.text
            task.source = ""
            task.descript = ""
            
            
            do{
                try (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            catch let error {
                NSLog("Kunde inte spara till core data \(error)")
            }
            
            /*
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            
            do {
                let tasks = try context.fetch(request) as! [Task]
                for task in tasks {
                    print("\(task.id) har stardatum \(task.startDate)")
                }
            }
            catch let error {
                NSLog("Kunde inte hämta från core data \(error)")*/
            }
            
        }
        
    }
    

