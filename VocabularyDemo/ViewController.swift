//
//  ViewController.swift
//  VocabularyDemo
//
//  Created by Yi Zhang on 2021/4/18.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit
import Vocabulary
import SQLite

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!

    var connection: Connection?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        connection = connectDatabase()
    }

    @IBAction func searchAction(_ sender: UIButton) {
        if let text = textField.text, text.count > 0 {
            textView.text = consultWord(text)
        }
    }
}

private extension ViewController {
    func connectDatabase() -> Connection? {
        guard let path = Bundle(identifier: "z1joey.Vocabulary")?.url(forResource: "db", withExtension: "sqlite3")?.absoluteString else {
            print("path is nil.")
            return nil
        }
        
        do {
            return try Connection(path, readonly: true)
        } catch {
            print(error)
            return nil
        }
    }

    func consultWord(_ word: String) -> String? {
        let ecdict = Table("ecdict")
        let wordExpression = Expression<String?>("word")
        let result = ecdict.filter(wordExpression == word)

        do {
            let word = try connection?.pluck(result)
            return try word?.get(Expression<String>("translation"))
        } catch {
            return error.localizedDescription
        }
    }
}
