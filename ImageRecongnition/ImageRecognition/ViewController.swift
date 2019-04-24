//
//  ViewController.swift
//  ImageRecongnition
//
//  Created by Zed on 4/24/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func DetectPressed(_ sender: UIButton) {

        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self

        let actionScript = UIAlertController(title: "Select Source of Image", message: "Photo Source", preferredStyle: .actionSheet )

        actionScript.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                print("Camera not Available")
            }
        }))

        actionScript.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in

            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)

        }))

        actionScript.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionScript, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

        imageView.image = image;
        picker.dismiss(animated: true, completion: nil)

        guard let ciimage = CIImage(image: image!) else {
            print("Unable to convert to CIImage")
            return
        }
        DetectImage(image: ciimage)

    }


    func DetectImage(image: CIImage){

        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
            print("Unable to get VNCoreMLModel")
            return
        }

        let request = VNCoreMLRequest(model: model){(request, error) in

            guard let result = request.results as? [VNClassificationObservation] else { return}

                print(result)


        }

        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }
        catch{
            print(error)
        }

    }

}


