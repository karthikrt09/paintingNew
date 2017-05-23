//
//  PaintingViewController.swift
//  paintingCollector
//
//  Created by Karthik Thirunavukkarasan on 5/12/17.
//  Copyright © 2017 Karthik Thiru. All rights reserved.
//

import UIKit

class PaintingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var paintingImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var paint1 : Paint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if paint1 != nil{
            
           paintingImageView.image = UIImage(data: paint1!.image as! Data)
           titleTextField.text = paint1!.title
           addUpdateButton.setTitle("Update", for: .normal)
        }
        else{
            deleteButton.isHidden = true
        }
        
    }

    @IBAction func photoTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        paintingImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
    }

    @IBAction func addTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let paint = Paint(context: context)
        paint.title = titleTextField.text
        paint.image = NSData(data: UIImagePNGRepresentation(paintingImageView.image!)!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
}
