//
//  MainViewController.swift
//  SandstoneCodingChallenge
//
//  Created by Matthew Howes Singleton on 4/20/17.
//  Copyright © 2017 Matthew Howes Singleton. All rights reserved.
//

import UIKit
import PureLayout

class MainViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var chooseFromPhotoLibraryButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var decreaseLineSizeButton: UIButton!
    @IBOutlet weak var lineLenghLabel: UILabel!
    @IBOutlet weak var increaseLineSizeTextField: UIButton!
    
    let path = UIBezierPath()
    let shapeLayer = CAShapeLayer()
    var imagePicker = UIImagePickerController()
    
    var endingPoint = 25
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingUpViewUsingAPI()
        drawLineFromPoint(end: endingPoint, inView: imgView)
    }
    
    
    // MARK: PureLayout View Setup
    
    func settingUpViewUsingAPI() {
        
        imgView.autoPin(toTopLayoutGuideOf: self, withInset: 25.0)
        imgView.backgroundColor = .lightGray
        imgView.autoSetDimension(.height, toSize: 300.0)
        //        imgView.autoSetDimension(.width, toSize: 350.0)
        //        imgView.autoAlignAxis(.vertical, toSameAxisOf: view) // This should be .horizontal?
        
        imgView.autoPinEdge(toSuperviewEdge: .left, withInset: 20.0)
        imgView.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
        
        let topButtonArray: NSArray = [chooseFromPhotoLibraryButton, clearButton, takePhotoButton]
        topButtonArray.autoDistributeViews(along: .horizontal, alignedTo: .horizontal, withFixedSpacing: 10.0, insetSpacing: true, matchedSizes: true)
        topButtonArray.autoSetViewsDimension(.height, toSize: 30.0)
        
        chooseFromPhotoLibraryButton.autoPinEdge(.top, to: .bottom, of: imgView, withOffset: 25.0)
        clearButton.autoPinEdge(.top, to: .bottom, of: imgView, withOffset: 25.0)
        takePhotoButton.autoPinEdge(.top, to: .bottom, of: imgView, withOffset: 25.0)
        
        decreaseLineSizeButton.autoPinEdge(.top, to: .bottom, of: chooseFromPhotoLibraryButton, withOffset: 25.0)
        decreaseLineSizeButton.autoPinEdge(.top, to: .bottom, of: clearButton, withOffset: 25.0)
        decreaseLineSizeButton.autoPinEdge(.top, to: .bottom, of: takePhotoButton, withOffset: 25.0)
        decreaseLineSizeButton.autoPinEdge(toSuperviewEdge: .left, withInset: 25.0)
        decreaseLineSizeButton.autoPinEdge(.right, to: .left, of: lineLenghLabel, withOffset: 10.0)
        decreaseLineSizeButton.autoSetDimension(.height, toSize: 30.0)
        decreaseLineSizeButton.autoSetDimension(.width, toSize: 30.0)
        
        lineLenghLabel.autoPinEdge(.top, to: .bottom, of: chooseFromPhotoLibraryButton, withOffset: 25.0)
        lineLenghLabel.autoPinEdge(.top, to: .bottom, of: clearButton, withOffset: 25.0)
        lineLenghLabel.autoPinEdge(.top, to: .bottom, of: takePhotoButton, withOffset: 25.0)
        lineLenghLabel.autoPinEdge(.left, to: .right, of: decreaseLineSizeButton, withOffset: 10.0)
        lineLenghLabel.autoPinEdge(.right, to: .left, of: increaseLineSizeTextField, withOffset: 10.0)
        lineLenghLabel.autoSetDimension(.height, toSize: 30.0)
        
        increaseLineSizeTextField.autoPinEdge(.top, to: .bottom, of: chooseFromPhotoLibraryButton, withOffset: 25.0)
        increaseLineSizeTextField.autoPinEdge(.top, to: .bottom, of: clearButton, withOffset: 25.0)
        increaseLineSizeTextField.autoPinEdge(.top, to: .bottom, of: takePhotoButton, withOffset: 25.0)
        increaseLineSizeTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 25.0)
        increaseLineSizeTextField.autoPinEdge(.left, to: .right, of: lineLenghLabel, withOffset: 10.0)
        increaseLineSizeTextField.autoSetDimension(.height, toSize: 30.0)
        increaseLineSizeTextField.autoSetDimension(.width, toSize: 30.0)
        
    }
    
    
    // MARK: Draw Line Logic
    
    func drawLineFromPoint(end: Int, inView view: UIView) {
        
        path.move(to: CGPoint(x: 25, y: 150))
        path.addLine(to: CGPoint(x: end, y: 150))
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 5.0
        view.layer.addSublayer(shapeLayer)
        
        let currentLineLength = end - 25
        lineLenghLabel.text = "\(currentLineLength) Pixels Long"
    }
    
    
    // MARK: IBActions
    
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
        path.removeAllPoints()
        endingPoint-=1
        drawLineFromPoint(end: endingPoint, inView: imgView)
    }
    
    @IBAction func increaseLineSizeButtonTapped(_ sender: UIButton) {
        path.removeAllPoints()
        endingPoint+=1
        drawLineFromPoint(end: endingPoint, inView: imgView)
    }
    
} // End of MainViewController Class


// MARK: Extensions

extension MainViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let chosenImg = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("error")
            return
        }
        
        imgView.image = chosenImg
        UIImageWriteToSavedPhotosAlbum(chosenImg, nil, nil, nil)
        imagePicker.dismiss(animated: true, completion: nil)
    }
}



