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
