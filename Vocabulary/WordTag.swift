//
//  WordTag.swift
//  Vocabulary
//
//  Created by Yi Zhang on 2021/4/21.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

public enum WordTag: String {
    case zhongKao = "zk"
    case gaoKao = "gk"
    case cet4 = "cet4"
    case cet6 = "cet6"
    case ky = "ky"
    case toefl = "toefl"
    case ielts = "ielts"
    case collins
    case oxford
    case unknown

    public var displayName: String {
        switch self {
        case .zhongKao:
            return "中考词汇"
        case .gaoKao:
            return "高考词汇"
        case .cet4:
            return "4级词汇"
        case .cet6:
            return "6级词汇"
        case .ky:
            return "考研词汇"
        case .toefl:
            return "托福词汇"
        case .ielts:
            return "雅思词汇"
        case .collins:
            return "柯林斯5星词汇"
        case .oxford:
            return "牛津3000词汇"
        case .unknown:
            return ""
        }
    }

    public init(rawValue: String) {
        switch rawValue {
        case "zk":      self = .zhongKao
        case "gk":      self = .gaoKao
        case "cet4":    self = .cet4
        case "cet6":    self = .cet6
        case "ky":      self = .ky
        case "toefl":   self = .toefl
        case "ielts":   self = .ielts
        case "collins": self = .collins
        case "oxford":  self = .oxford
        default:        self = .unknown
        }
    }
}
