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

    var timer: Timer?

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

        NotificationCenter.default.addObserver(self, selector: #selector(viewControllerWillEnterBackground), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(viewControllerDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)

        updateTextViewByTag(.gaoKao)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @objc func viewControllerWillEnterBackground()  {
        speechManager.stopRecording()

        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }

    @objc func viewControllerDidBecomeActive()  {
        startTimer()
    }

    @IBAction func searchAction(_ sender: UIButton) {
//        if let text = textField.text, text.count > 0 {
//            updateTextViewByWord(text)
//            view.endEditing(true)
//        }
    }

    private func updateTextViewByWord(_ word: String) {
        var res: String = ""
        Vocabulary.shared.filterByWord(word) { words in
            words.compactMap { $0.word }.forEach { word in
                res += word + "\n"
            }
            self.textView.text = res
        }
    }

    private func updateTextViewByTag(_ tag: WordTag) {
        var res: String = ""
        Vocabulary.shared.filterByTag(.collins5) { words in
            words.compactMap { $0 }.forEach { word in
                res += "\(word.word): tags\(word.tags.map { $0.displayName }) collins: \(word.stars), oxford: \(word.isOxfordWord)\n"
            }
            self.textView.text = res
        }
    }

    private func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 61, repeats: true) { t in
//            print("restart")
//            self.speechManager.recognizeLastWord { [weak self] speechWord in
//                if let word = speechWord?.word {
//                    self?.textField.text = word
//                    self?.updateTextViewByWord(word)
//                }
//            }
//        }
//        timer?.fire()
    }
}
