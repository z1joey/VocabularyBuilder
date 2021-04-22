//
//  VocabularyBookViewController.swift
//  VocabularyDemo
//
//  Created by joey on 4/22/21.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit
import Vocabulary

class VocabularyBookViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WordTag.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if let cell = cell as? VocabularyBookCell {
            cell.bookNameLabel.text = WordTag.allCases[indexPath.row].displayName
            cell.descriptionLabel.text = WordTag.allCases[indexPath.row].description
        }

        return cell
    }
}
