//
//  AddActivityViewController.swift
//  kalender3
//
//  Created by Erika Linde on 09/03/17.
//  Copyright © 2017 Erika Linde. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dateEnd: UITextView!
    @IBOutlet weak var date: UITextView!
    var dateInfo: Date!
    var dateInfoEnd: Date!
    var btnLabelText: String!
    let imagePicker = UIImagePickerController()
    var i = 0
    
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
        //strdate blir summan av hur många dar in på året vi är så 1 Jan är 1, 2 Jan är 2 o s v det får va så så länge 
        // Do any additional setup after loading the view.
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        if let documentDirectory = paths.first {
            
            //Nu kommer alla bilder heta "cached.png" så lägger till en unik siffra med
            return documentDirectory.appending("/cached\(i).png")
        }else{
            fatalError("No documents directory")
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
