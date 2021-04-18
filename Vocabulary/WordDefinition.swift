// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let word = try? newJSONDecoder().decode(Word.self, from: jsonData)

import Foundation

// MARK: - WordDefinition
public struct WordDefinition: Codable {
    public let wordRank: Int?
    public let headWord: String?
    public let content: WordContent?
    public let bookID: String?

    enum CodingKeys: String, CodingKey {
        case wordRank, headWord, content
        case bookID = "bookId"
    }

    public init(wordRank: Int?, headWord: String?, content: WordContent?, bookID: String?) {
        self.wordRank = wordRank
        self.headWord = headWord
        self.content = content
        self.bookID = bookID
    }
}

// MARK: - WordContent
public struct WordContent: Codable {
    public let word: ContentWord?

    public init(word: ContentWord?) {
        self.word = word
    }
}

// MARK: - ContentWord
public struct ContentWord: Codable {
    public let wordHead, wordID: String?
    public let content: WordContentClass?

    enum CodingKeys: String, CodingKey {
        case wordHead
        case wordID = "wordId"
        case content
    }

    public init(wordHead: String?, wordID: String?, content: WordContentClass?) {
        self.wordHead = wordHead
        self.wordID = wordID
        self.content = content
    }
}

// MARK: - WordContentClass
public struct WordContentClass: Codable {
    public let sentence: ContentSentence?
    public let usphone: String?
    public let syno: ContentSyno?
    public let ukphone, ukspeech: String?
    public let star: Int?
    public let phrase: ContentPhrase?
    public let speech: String?
    public let remMethod: RemMethod?
    public let relWord: RelWord?
    public let usspeech: String?
    public let trans: [Tran]?

    public init(sentence: ContentSentence?, usphone: String?, syno: ContentSyno?, ukphone: String?, ukspeech: String?, star: Int?, phrase: ContentPhrase?, speech: String?, remMethod: RemMethod?, relWord: RelWord?, usspeech: String?, trans: [Tran]?) {
        self.sentence = sentence
        self.usphone = usphone
        self.syno = syno
        self.ukphone = ukphone
        self.ukspeech = ukspeech
        self.star = star
        self.phrase = phrase
        self.speech = speech
        self.remMethod = remMethod
        self.relWord = relWord
        self.usspeech = usspeech
        self.trans = trans
    }
}

// MARK: - ContentPhrase
public struct ContentPhrase: Codable {
    public let phrases: [PhraseElement]?
    public let desc: String?

    public init(phrases: [PhraseElement]?, desc: String?) {
        self.phrases = phrases
        self.desc = desc
    }
}

// MARK: - PhraseElement
public struct PhraseElement: Codable {
    public let pContent, pCN: String?

    enum CodingKeys: String, CodingKey {
        case pContent
        case pCN = "pCn"
    }

    public init(pContent: String?, pCN: String?) {
        self.pContent = pContent
        self.pCN = pCN
    }
}

// MARK: - RelWord
public struct RelWord: Codable {
    public let rels: [Rel]?
    public let desc: String?

    public init(rels: [Rel]?, desc: String?) {
        self.rels = rels
        self.desc = desc
    }
}

// MARK: - Rel
public struct Rel: Codable {
    public let pos: String?
    public let words: [WordElement]?

    public init(pos: String?, words: [WordElement]?) {
        self.pos = pos
        self.words = words
    }
}

// MARK: - WordElement
public struct WordElement: Codable {
    public let hwd, tran: String?

    public init(hwd: String?, tran: String?) {
        self.hwd = hwd
        self.tran = tran
    }
}

// MARK: - RemMethod
public struct RemMethod: Codable {
    public let val, desc: String?

    public init(val: String?, desc: String?) {
        self.val = val
        self.desc = desc
    }
}

// MARK: - ContentSentence
public struct ContentSentence: Codable {
    public let sentences: [SentenceElement]?
    public let desc: String?

    public init(sentences: [SentenceElement]?, desc: String?) {
        self.sentences = sentences
        self.desc = desc
    }
}

// MARK: - SentenceElement
public struct SentenceElement: Codable {
    public let sContent, sCN: String?

    enum CodingKeys: String, CodingKey {
        case sContent
        case sCN = "sCn"
    }

    public init(sContent: String?, sCN: String?) {
        self.sContent = sContent
        self.sCN = sCN
    }
}

// MARK: - ContentSyno
public struct ContentSyno: Codable {
    public let synos: [SynoElement]?
    public let desc: String?

    public init(synos: [SynoElement]?, desc: String?) {
        self.synos = synos
        self.desc = desc
    }
}

// MARK: - SynoElement
public struct SynoElement: Codable {
    public let pos, tran: String?
    public let hwds: [Hwd]?

    public init(pos: String?, tran: String?, hwds: [Hwd]?) {
        self.pos = pos
        self.tran = tran
        self.hwds = hwds
    }
}

// MARK: - Hwd
public struct Hwd: Codable {
    public let w: String?

    public init(w: String?) {
        self.w = w
    }
}

// MARK: - Tran
public struct Tran: Codable {
    public let tranCN, descOther, descCN, pos: String?
    public let tranOther: String?

    enum CodingKeys: String, CodingKey {
        case tranCN = "tranCn"
        case descOther
        case descCN = "descCn"
        case pos, tranOther
    }

    public init(tranCN: String?, descOther: String?, descCN: String?, pos: String?, tranOther: String?) {
        self.tranCN = tranCN
        self.descOther = descOther
        self.descCN = descCN
        self.pos = pos
        self.tranOther = tranOther
    }
}
