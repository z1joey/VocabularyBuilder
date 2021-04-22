//
//  VocabularyBookViewController.swift
//  VocabularyDemo
//
//  Created by joey on 4/22/21.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit

class VocabularyBookViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    }
}
