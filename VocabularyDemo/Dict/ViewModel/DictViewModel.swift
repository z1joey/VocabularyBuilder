//
//  DictViewModel.swift
//  VocabularyDemo
//
//  Created by joey on 4/29/21.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Vocabulary

class DictViewModel {
    private let disposeBag = DisposeBag()

    var wordObject = BehaviorRelay<WordObject?>(value: nil)

    init(textObservable: Observable<String>) {
        textObservable
            .compactMap { $0 }
            .subscribe(onNext: { word in
                Vocabulary.shared.consultWord(word) { [weak self] obj in
                    self?.wordObject.accept(obj)
                }
            })
            .disposed(by: disposeBag)

        Vocabulary.shared.connectDatabase { success in
            print("isDatabaseConnected: \(success)")
        }
    }
}
