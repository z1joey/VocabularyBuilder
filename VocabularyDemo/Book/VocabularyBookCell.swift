//
//  VocabularyBookCell.swift
//  VocabularyDemo
//
//  Created by joey on 4/22/21.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit

class VocabularyBookCell: UITableViewCell {
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var vocabularyCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var completionProgressView: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomView.layer.borderWidth  = 0.5
        bottomView.layer.borderColor  = UIColor.lightGray.cgColor
        bottomView.layer.cornerRadius = 10
        bottomView.layer.sketchShadow(color: .black, alpha: 0.2, x: 0, y: 1, blur: 2.7)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
