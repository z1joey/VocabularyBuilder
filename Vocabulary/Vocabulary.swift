//
//  Vocabulary.swift
//  Vocabulary
//
//  Created by Yi Zhang on 2021/4/19.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import Foundation
import SQLite

final public class Vocabulary {
    private init() {}
    static public let shared = Vocabulary()

    private var db: Connection?

    public func connectDatabase(completion: @escaping (Bool) -> Void) {
        guard let path = Bundle(identifier: "z1joey.Vocabulary")?.url(forResource: "db", withExtension: "sqlite3")?.absoluteString else {
            print("path is nil.")
            completion(false)
            return
        }
        
        do {
            db = try Connection(path, readonly: true)
            completion(true)
        } catch {
            print(error)
            completion(false)
        }
    }

    public func consultWord(_ word: String, completion: @escaping (WordObject?) -> Void) {
        guard let db = db else { return }

        DispatchQueue.global(qos: .userInitiated).async {
            let ecdict = Table("ecdict")
            let wordExpression = Expression<String?>("word")
            let result = ecdict.filter(wordExpression == word)

            do {
                if let row = try db.pluck(result) {
                    let object: WordObject = try row.decode()
                    DispatchQueue.main.async {
                        completion(object)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }

                print(error.localizedDescription)
            }
        }
    }

    public func filterByWord(_ word: String, completion: @escaping ([WordObject]) -> Void) {
        let ecdict = Table("ecdict")
        let wordExpression = Expression<String?>("word")
        let result = ecdict.filter(wordExpression.like("%\(word)%"))
        pareTableIntoArray(result, completion: completion)
    }

    public func filterByTag(_ tag: WordTag, completion: @escaping ([WordObject]) -> Void) {
        let ecdict = Table("ecdict")

        switch tag {
        case .collins:
            let oxfordExpression = Expression<String?>("collins")
            let result = ecdict.filter(oxfordExpression == "5")
            pareTableIntoArray(result, completion: completion)
        case .oxford:
            let collinsExpression = Expression<String?>("oxford")
            let result = ecdict.filter(collinsExpression == "1")
            pareTableIntoArray(result, completion: completion)
        default:
            let tagExpression = Expression<String?>("tag")
            let result = ecdict.filter(tagExpression.like("%\(tag.rawValue)%"))
            pareTableIntoArray(result, completion: completion)
        }
    }

    @available(*, deprecated, message: "Decoding all data is not a good way")
    public func loadAllWordObjects(_ db: Connection, completion: @escaping ([WordObject]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let ecdict = Table("ecdict")
            do {
                let objects: [WordObject] = try db.prepare(ecdict).map { row in
                    return try row.decode()
                }
                DispatchQueue.main.async {
                    completion(objects)
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
}

// MARK:- Helpers
private extension Vocabulary {
    func pareTableIntoArray(_ table: Table, completion: @escaping ([WordObject]) -> Void) {
        guard let db = db else { return }

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let rows = try db.prepare(table)
                let objects: [WordObject] = try rows.map { row in
                    return try row.decode()
                }
                DispatchQueue.main.async {
                    completion(objects)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([])
                }

                print(error.localizedDescription)
            }
        }
    }
}
