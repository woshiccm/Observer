//
//  Bag.swift
//  Observer
//
//  Created by roy.cao on 2018/12/7.
//  Copyright © 2018 roy.cao. All rights reserved.
//

import Foundation

typealias Token = Int

struct Bag<T> {

    internal private(set) var items = [Token: T]()
    private var currentToken: Token = 0

    @discardableResult
    mutating func append(_ item: T) -> Token {
        let token = self.currentToken
        self.currentToken += 1
        items[token] = item

        return token
    }

    mutating func removeValue(for token: Token) {
        items.removeValue(forKey: token)
    }

    mutating func removeAll() {
        items.removeAll(keepingCapacity: false)
    }

    public var isEmpty: Bool {
        return self.items.isEmpty
    }
}

extension Bag: Sequence {

    func makeIterator() -> DictionaryIterator<Token, T> {
        return items.makeIterator()
    }
}

