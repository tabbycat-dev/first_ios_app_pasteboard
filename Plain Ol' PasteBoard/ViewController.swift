//
//  ViewController.swift
//  Plain Ol' PasteBoard
//
//  Created by Tan Nguyen on 18/4/20.
//  Copyright © 2020 Tan Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let DATA_KEY = "data_key"
    @IBOutlet weak var textViewTop: UITextView!
    var pastedStrings : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadedStrings = UserDefaults.standard.stringArray(forKey: DATA_KEY){
            pastedStrings.append(contentsOf: loadedStrings) //retrieve all text from persistent storage and save to array
        }
        // Do any additional setup after loading the view.
        showText()
    }
    func addText(){
        guard let text = UIPasteboard.general.string, !pastedStrings.contains(text) else{
            return // only new text, dont save twice
        }
        
        pastedStrings.append(text) //added new text to array
        UserDefaults.standard.set(pastedStrings, forKey: DATA_KEY) // save text to persistent storage
        showText()
    }
    
    func showText(){
        textViewTop.text = ""
        for str in pastedStrings {
            textViewTop.text.append("\(str)\n---\n") //show all text in an array
        }
    }
    
    @IBAction func button(_ sender: UIBarButtonItem) {
        pastedStrings.removeAll()
        textViewTop.text =  ""
        UserDefaults.standard.removeObject(forKey: DATA_KEY)
    }
}

