//
//  DisposableObserver.swift
//  Observer
//
//  Created by roy.cao on 2018/12/7.
//  Copyright © 2018 roy.cao. All rights reserved.
//

import Foundation

internal typealias OnDispose = () -> Void

class DisposableObserver: Disposable {

    var onDispose: OnDispose?

    init(_ onDispose: @escaping OnDispose) {
        self.onDispose = onDispose
    }

    deinit {
        dispose()
    }

    func dispose() {
        onDispose?()
        onDispose = nil
    }
}
