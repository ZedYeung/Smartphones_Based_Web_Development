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
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func uploadImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()

        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                print("Camera Not Available!")
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)

        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

        self.present(actionSheet, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

        self.imageView.image = pickedImage;
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func DetectPressed(_ sender: UIButton) {
      DetectImage(image: imageView.image)
    }

    func DetectImage(image: UIImage?) {
        guard let image = image else { return }
        
        guard let ciimage = CIImage(image: image) else {
            print("Unable to convert to CIImage")
            return
        }
        
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
            print("Unable to get VNCoreMLModel")
            return
        }

        let request = VNCoreMLRequest(model: model){(request, error) in
            
            guard let result = request.results as? [VNClassificationObservation] else { return}

            if let first = result.first {
                self.textView.text = String("\(first.identifier) \(first.confidence)")
            }

        }

        let handler = VNImageRequestHandler(ciImage: ciimage)
        do {
            try handler.perform([request])
        }
        catch{
            print(error)
        }

    }

}


