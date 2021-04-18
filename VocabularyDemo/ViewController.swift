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

    var vocabulary: [String: WordDefinition] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareVocabulary()
    }

    @IBAction func searchAction(_ sender: UIButton) {
        guard let text = textField.text, text.count > 0 else { return }

        textView.text = consultWord(text)?.content?.word?.content?.sentence?.sentences?.first?.sContent
    }
}

extension ViewController {
    func consultWord(_ word: String) -> WordDefinition? {
        return vocabulary[word]
    }

    func prepareVocabulary() {
        guard let url = getJSONURL("KaoYan_1") else { return }
        vocabulary.removeAll()

        let jsonStrings = getJSONStrings(url)

        jsonStrings.forEach { jsonString in
            if let wordDefinition = jsonStringToWordObject(jsonString) {
                if let word = wordDefinition.headWord {
                    vocabulary[word] = wordDefinition
                }
            }
        }

        print("Vocabulary is prepared: \(vocabulary.count > 0)")
    }

    func getJSONURL(_ name: String) -> URL? {
        return Bundle(identifier: "z1joey.Vocabulary")?.url(forResource: name, withExtension: "json")
    }

    func getJSONStrings(_ url: URL) -> [String] {
        do {
            let contents = try String(contentsOf: url)
            let seperatedStrings = contents.components(separatedBy: "{\"wordRank\":").dropFirst()
            let jsonStrings = seperatedStrings.map { "{\"wordRank\":" + $0 }

            return jsonStrings
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func jsonStringToWordObject(_ jsonString: String) -> WordDefinition? {
        guard let data = jsonString.data(using: .utf8) else { return nil }

        do {
            let word = try JSONDecoder().decode(WordDefinition.self, from: data)
            return word
        } catch {
            print(error)
            return nil
        }
    }
}

