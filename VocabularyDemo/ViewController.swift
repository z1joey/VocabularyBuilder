//
//  ViewController.swift
//  VocabularyDemo
//
//  Created by Yi Zhang on 2021/4/18.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit
import Vocabulary
import SpeechManager

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!

    var speechManager: SpeechManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Vocabulary.shared.connectDatabase { success in
            print("isDatabaseConnected: \(success)")
        }

        speechManager = SpeechManager()
        speechManager.requestAuthorization { success in
            print("isSpeechManagerAuthorized: \(success)")
        }

        Timer.scheduledTimer(withTimeInterval: 61, repeats: true) { t in
            print("restart")
            self.speechManager.recognizeLastWord { [weak self] speechWord in
                if let word = speechWord?.word {
                    self?.textField.text = word
                    self?.searchWord(word)
                }
            }
        }.fire()
    }

    @IBAction func searchAction(_ sender: UIButton) {
        if let text = textField.text, text.count > 0 {
            searchWord(text)
        }
    }

    private func searchWord(_ word: String) {
        var res: String = ""
        Vocabulary.shared.searchWord(word) { words in
            words.compactMap { $0.word }.forEach { word in
                res += word + "\n"
            }
            self.textView.text = res
        }
    }
}
