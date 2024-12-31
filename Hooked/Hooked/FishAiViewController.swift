//
//  FishAiViewController.swift
//  Hooked
//
//  Created by Emre on 19.12.2024.
//

import UIKit
import CoreML
import Vision

class FishAiViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var fishImageView: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var chosenImage = CIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func resultButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        fishImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        if let ciImage = CIImage(image: fishImageView.image!){
            chosenImage = ciImage
        }
        
        recognizeImage(image: chosenImage)
        
     }
    
    func recognizeImage(image: CIImage){
        
        resultLabel.text = "Tarıyorum..."
        
        if let model = try? VNCoreMLModel(for: fishAi_().model){
            let request = VNCoreMLRequest(model: model) { (vnrequest, error) in
                
                if let results = vnrequest.results as? [VNClassificationObservation] {
                    if results.count > 0 {
                        let topResult = results.first
                        
                        DispatchQueue.main.async {
                            let confidenceLevel = (topResult?.confidence ?? 0) * 100
                            let rounded = Int (confidenceLevel * 100) / 100
                            
                            self.resultLabel.text = "\(rounded)% ihtimalle \(topResult!.identifier)"
                        }
                    }
                }
            }
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([request])
                }catch{
                    print("error")
                }
            }
        }
        
        
        }
        
    }
    
    

