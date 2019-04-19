//
//  ViewController.swift
//  LandmarkRecognition
//
//  Created by Zed on 4/18/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var result: UITextView!

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

    @IBAction func recognize(_ sender: UIButton) {
        detectCloudLandmarks(image: image.image)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.image.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func detectCloudLandmarks(image: UIImage?) {
        let vision = Vision.vision()
        guard let image = image else { return }

        // Initialize a VisionImage object with the given UIImage.
        let visionImage = VisionImage(image: image)

        // Create a landmark detector.
        // [START config_landmark_cloud]
        let options = VisionCloudDetectorOptions()
        options.modelType = .latest
        options.maxResults = 20
        // [END config_landmark_cloud]
        // [START init_landmark_cloud]
        let cloudDetector = vision.cloudLandmarkDetector(options: options)
        // Or, to use the default settings:
        // let cloudDetector = vision.cloudLandmarkDetector()
        // [END init_landmark_cloud]
        // [START detect_landmarks_cloud]
        cloudDetector.detect(in: visionImage) { landmarks, error in
            guard error == nil, let landmarks = landmarks, !landmarks.isEmpty else {
                // [START_EXCLUDE]
                let errorString = error?.localizedDescription ?? "No results returned."
                self.result.text = "Cloud landmark detection failed with error: \(errorString)"
                // [END_EXCLUDE]
                return
            }

            // Recognized landmarks
            // [START_EXCLUDE]
            self.result.text = landmarks.map { landmark -> String in

                return "Landmark: \(String(describing: landmark.landmark ?? "")), " +
                    "Confidence: \(String(describing: landmark.confidence ?? 0) ), " +
                    "EntityID: \(String(describing: landmark.entityId ?? "") ), " +
                "Frame: \(landmark.frame)"
                }.joined(separator: "\n")
            // [END_EXCLUDE]
        }
        // [END detect_landmarks_cloud]
    }
}

