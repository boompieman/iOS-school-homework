//
//  ViewController.swift
//  終極密碼
//
//  Created by MACBOOK on 2018/2/18.
//  Copyright © 2018年 MACBOOK. All rights reserved.
//

import UIKit
import Foundation

fileprivate let reuseIdentifier = "numberButton"
fileprivate let screenWidth = UIScreen.main.bounds.width

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var finalCodeTitle: UILabel!
    @IBOutlet weak var showEnterLebel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var finalCode = FinalCodeImplement()
    
    var currentSelection: CodeSelection?
    
    var tmpWord:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        setupFinalCode()
        setupCollectionViewCells()
        updateDisplayWith(showEnter: "請輸入數字")
        print(finalCode.target)
    }
    
    func setupFinalCode() {
        finalCode = FinalCodeImplement()
    }
    
    func setupCollectionViewCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let padding: CGFloat = 10
        let itemWidth = screenWidth/3 - padding
        let itemHeight = screenWidth/3 - padding
    
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
    
        collectionView.collectionViewLayout = layout
    }
    
    func updateDisplayWith(showEnter: String? = nil) {
        
        if let showEnterL = showEnter {
            showEnterLebel.text = "\(showEnterL)"
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return finalCode.selection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FinalCodeCell else { fatalError() }
        
        let item = finalCode.selection[indexPath.row]
        
        cell.buttonNumber.text = item.rawValue
        cell.buttonNumber.layer.borderColor = UIColor.white.cgColor
        cell.buttonNumber.layer.borderWidth = 2
        cell.clipsToBounds = true
        cell.buttonNumber.layer.masksToBounds = true
        // 115.0
//        print(cell.bounds.size.width)
        print(screenWidth)
        cell.buttonNumber.layer.cornerRadius = (cell.bounds.size.width - 20) * 0.5
        print (cell.buttonNumber.layer.cornerRadius)
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateCell(having: indexPath, selected: true)
        
        currentSelection = finalCode.selection[indexPath.row]
        
        if currentSelection == .cancel {
            tmpWord = ""
            updateDisplayWith(showEnter: "請輸入數字")
        }
        else if currentSelection == .submit {
            do {
                let alertWord = try finalCode.compare(of: Int(tmpWord))
                showAlertwith(title: "Submission outcome", message: alertWord)
                
            } catch FinalCodeError.invalidNumber {
                print("invalid Number")
            } catch let unKnownError {
                print("\(unKnownError)")
            }
            
            if finalCode.isTarget(of: Int(tmpWord)) {
                viewDidLoad()
            }
        }
        else {
            do {
                try tmpWord = tmpWord + finalCode.enterNumber(selection: currentSelection)
                updateDisplayWith(showEnter: tmpWord)
            } catch FinalCodeError.invalidSelection {
                print("invalid Selection")
            } catch let unKnownError {
                print("\(unKnownError)")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateCell(having: indexPath, selected: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        updateCell(having: indexPath, selected: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        updateCell(having: indexPath, selected: false)
    }
    
    func updateCell(having indexPath: IndexPath, selected: Bool) {
        
        let selectedBackgroundColor = UIColor(red: 41/255.0, green: 211/255.0, blue: 241/255.0, alpha: 1.0)
        let defaultBackgroundColor = UIColor.black

        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = selected ? selectedBackgroundColor : defaultBackgroundColor
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showAlertwith(title:String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: dismissAlert)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func dismissAlert(sneder: UIAlertAction) -> Void {
        tmpWord = ""
        updateDisplayWith(showEnter: "請輸入數字")
    }


}

