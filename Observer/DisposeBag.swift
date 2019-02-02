//
//  DisposeBag.swift
//  Observer
//
//  Created by roy.cao on 2018/12/7.
//  Copyright © 2018 roy.cao. All rights reserved.
//

import Foundation

public final class DisposeBag {

    private var lock = SpinLock()
    internal private(set) var disposables = Bag<Disposable>()

    private var isDisposed = false

    public init() {  }

    public func append(_ disposable: Disposable) {
        p_append(disposable)?.dispose()
    }

    private func p_append(_ disposable: Disposable) -> Disposable? {
        lock.lock(); defer { lock.unlock() }

        if isDisposed {
            return disposable
        }
        disposables.append(disposable)

        return nil
    }

    private func dispose() {
        let oldDisposables = p_dispose()

        oldDisposables.forEach {
            $1.dispose()
        }
    }

    private func p_dispose() -> Bag<Disposable> {
        lock.lock(); defer { lock.unlock() }

        let oldDisposables = disposables

        disposables.removeAll()
        isDisposed = true

        return oldDisposables
    }

    deinit {
        self.dispose()
    }
}
