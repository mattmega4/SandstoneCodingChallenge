//
//  MainViewController.swift
//  SandstoneCodingChallenge
//
//  Created by Matthew Howes Singleton on 4/20/17.
//  Copyright © 2017 Matthew Howes Singleton. All rights reserved.
//

import UIKit
import PureLayout

class MainViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
   
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var drawVw: UIView!
   
    
    @IBOutlet weak var chooseFromPhotoLibraryButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    @IBOutlet weak var decreaseLineSizeButton: UIButton!
    @IBOutlet weak var lineSizeTextField: UITextField!
    @IBOutlet weak var increaseLineSizeTextField: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingUpViewUsingAPI()
        
    }
    
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let chosenImg = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("error")
            return
        }

        
        imgView.image = chosenImg
        UIImageWriteToSavedPhotosAlbum(chosenImg, nil, nil, nil)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func settingUpViewUsingAPI() {
        
        imgView.autoPin(toTopLayoutGuideOf: self, withInset: 25.0)
        imgView.backgroundColor = .lightGray
        imgView.autoSetDimension(.height, toSize: 300.0)
        //        imgView.autoSetDimension(.width, toSize: 350.0)
        //        imgView.autoAlignAxis(.vertical, toSameAxisOf: view) // This should be .horizontal?
        
        imgView.autoPinEdge(toSuperviewEdge: .left, withInset: 20.0)
        imgView.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
        
//        drawVw.autoPin(toTopLayoutGuideOf: self, withInset: 25.0)
//        drawVw.backgroundColor = .clear
//        drawVw.autoSetDimension(.height, toSize: 200.0)
//        drawVw.autoPinEdge(toSuperviewEdge: .left, withInset: 20.0)
//        drawVw.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
        
        
        
        
        let topButtonArray: NSArray = [chooseFromPhotoLibraryButton, clearButton, takePhotoButton]
        topButtonArray.autoDistributeViews(along: .horizontal, alignedTo: .horizontal, withFixedSpacing: 10.0, insetSpacing: true, matchedSizes: true)
        topButtonArray.autoSetViewsDimension(.height, toSize: 30.0)
        
        chooseFromPhotoLibraryButton.autoPinEdge(.top, to: .bottom, of: imgView, withOffset: 25.0)
        clearButton.autoPinEdge(.top, to: .bottom, of: imgView, withOffset: 25.0)
        takePhotoButton.autoPinEdge(.top, to: .bottom, of: imgView, withOffset: 25.0)
        
//        chooseFromPhotoLibraryButton.autoPinEdge(.top, to: .bottom, of: drawVw, withOffset: 25.0)
        
        decreaseLineSizeButton.autoPinEdge(.top, to: .bottom, of: chooseFromPhotoLibraryButton, withOffset: 25.0)
        decreaseLineSizeButton.autoPinEdge(.top, to: .bottom, of: clearButton, withOffset: 25.0)
        decreaseLineSizeButton.autoPinEdge(.top, to: .bottom, of: takePhotoButton, withOffset: 25.0)
        decreaseLineSizeButton.autoPinEdge(toSuperviewEdge: .left, withInset: 25.0)
        decreaseLineSizeButton.autoPinEdge(.right, to: .left, of: lineSizeTextField, withOffset: 10.0)
        decreaseLineSizeButton.autoSetDimension(.height, toSize: 30.0)
        decreaseLineSizeButton.autoSetDimension(.width, toSize: 30.0)
        
        lineSizeTextField.autoPinEdge(.top, to: .bottom, of: chooseFromPhotoLibraryButton, withOffset: 25.0)
        lineSizeTextField.autoPinEdge(.top, to: .bottom, of: clearButton, withOffset: 25.0)
        lineSizeTextField.autoPinEdge(.top, to: .bottom, of: takePhotoButton, withOffset: 25.0)
        lineSizeTextField.autoPinEdge(.left, to: .right, of: decreaseLineSizeButton, withOffset: 10.0)
        lineSizeTextField.autoPinEdge(.right, to: .left, of: increaseLineSizeTextField, withOffset: 10.0)
        lineSizeTextField.autoSetDimension(.height, toSize: 30.0)
        
        increaseLineSizeTextField.autoPinEdge(.top, to: .bottom, of: chooseFromPhotoLibraryButton, withOffset: 25.0)
        increaseLineSizeTextField.autoPinEdge(.top, to: .bottom, of: clearButton, withOffset: 25.0)
        increaseLineSizeTextField.autoPinEdge(.top, to: .bottom, of: takePhotoButton, withOffset: 25.0)
        increaseLineSizeTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 25.0)
        increaseLineSizeTextField.autoPinEdge(.left, to: .right, of: lineSizeTextField, withOffset: 10.0)
        increaseLineSizeTextField.autoSetDimension(.height, toSize: 30.0)
        increaseLineSizeTextField.autoSetDimension(.width, toSize: 30.0)
        
    }
    
    
    

    
    
    
    
    @IBAction func choseFromPhotoLibraryTapped(_ sender: UIButton) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        imgView.image = nil
        imgView.backgroundColor = .lightGray
    }
    
    @IBAction func takePhotoButtonTapped(_ sender: UIButton) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func decreaseLineSizeButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func increaseLineSizeButtonTapped(_ sender: UIButton) {
    }
    
}



