//
//  SpeechWord.swift
//  SpeechManager
//
//  Created by Yi Zhang on 2021/4/20.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import Speech

public struct SpeechWord {
    public var word: String
    public var confidence: Float

    init(segment: SFTranscriptionSegment) {
        word = segment.substring
        confidence = segment.confidence
    }
}
