//
//  Disposable.swift
//  Observer
//
//  Created by roy.cao on 2018/12/7.
//  Copyright © 2018 roy.cao. All rights reserved.
//

import Foundation

public protocol Disposable {

    func dispose()
}

extension Disposable {

    public func dispose(by bag: DisposeBag) {
        bag.append(self)
    }
}
