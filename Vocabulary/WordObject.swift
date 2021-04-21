//
//  WordObject.swift
//  VocabularyDemo
//
//  Created by Yi Zhang on 2021/4/19.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import Foundation

public struct WordObject: Codable {
    public let word: String
    public let phonetic: String?
    public let definition: String?
    public let translation: String?
    public let pos: String?
    public let bnc: Int?
    public let frq: Int?
    public let exchange: String?
    public let detail: String?
    public let audio: String?

    private let tag: String?
    public var tags: [WordTag] {
        var _tags: [WordTag] = []

        if let tag = tag, tag.count > 0 {
            let ids = tag.components(separatedBy: " ")
            _tags = ids.map { WordTag(rawValue: $0) }
        }

        if stars == 5 {
            _tags.append(WordTag.collins)
        }

        if isOxfordWord {
            _tags.append(WordTag.oxford)
        }

        return _tags
    }

    private let collins: String?

    /// Collins dictionary rated word
    public var stars: Int? {
        if collins != nil, let int = Int(collins!) {
            return int
        }
        return nil
    }

    private let oxford: String?
    public var isOxfordWord: Bool {
        return oxford == "1"
    }
}
