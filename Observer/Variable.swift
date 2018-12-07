//
//  Variable.swift
//  Observer
//
//  Created by roy.cao on 2018/12/7.
//  Copyright © 2018 roy.cao. All rights reserved.
//

import Foundation

public class Variable<T>: ObservableType {

    private let observable = Observable<T>()
    private let lock = NSLock()

    public var value: T {
        didSet {
            lock.lock(); defer { lock.unlock() }
            observable.publish(value)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    public func subscribe(_ observer: @escaping (T) -> Void) -> Disposable {
        observer(value)

        return observable.subscribe(observer)
    }
}
