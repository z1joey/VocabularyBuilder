//
//  DictViewController.swift
//  VocabularyDemo
//
//  Created by joey on 4/29/21.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit
import RxSwift

class DictViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    private var viewModel: DictViewModel!
    private let disposeBag = DisposeBag()

    init() {
        super.init(nibName: "DictViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DictViewModel(
            textObservable: textField.rx.text.orEmpty.asObservable()
        )

        viewModel
            .wordObject
            .compactMap { $0?.translation }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
