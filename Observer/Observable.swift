//
//  Observable.swift
//  Observer
//
//  Created by roy.cao on 2018/12/7.
//  Copyright © 2018 roy.cao. All rights reserved.
//

import Foundation

class Observable<T>: ObservableType {

    internal private(set) var observers = Bag<(T) -> Void>()
    private let lock = SpinLock()

    public init() {  }

    public func subscribe(_ observer: @escaping (T) -> Void) -> Disposable {
        lock.lock(); defer { lock.unlock() }

        let token = observers.append(observer)

        return DisposableObserver { [weak self] in
            self?.removeItem(token)
        }
    }

    public func publish(_ value: T) {
        lock.lock(); defer { lock.unlock() }

        for (_, observer) in observers {
            observer(value)
        }
    }

    internal func removeItem(_ token: Token) {
        lock.lock(); defer { lock.unlock() }

        observers.removeValue(for: token)
    }
}

