//
//  WordObject.swift
//  VocabularyDemo
//
//  Created by Yi Zhang on 2021/4/19.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import Foundation

public struct WordObject: Codable {
    public let word: String?
    public let phonetic: String?
    public let definition: String?
    public let translation: String?
    public let pos: String?
    public let collins: String?
    public let oxford: String?
    public let tag: String?
    public let bnc: Int?
    public let frq: Int?
    public let exchange: String?
    public let detail: String?
    public let audio: String?
}
