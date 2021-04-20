//
//  ViewController.swift
//  VocabularyDemo
//
//  Created by Yi Zhang on 2021/4/18.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit
import Vocabulary

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Vocabulary.shared.connectDatabase { success in
            print("isDatabaseConnected: \(success)")
        }
    }

    @IBAction func searchAction(_ sender: UIButton) {
        if let text = textField.text, text.count > 0 {
//            Vocabulary.shared.consultWord(text) { word in
//                self.textView.text = word?.translation
//            }
            var res: String = ""
            Vocabulary.shared.searchWord(text) { words in
                words.compactMap { $0.word }.forEach { word in
                    res += word + "\n"
                }
                self.textView.text = res
            }
        }
    }
}
