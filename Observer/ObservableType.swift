//
//  ObservableType.swift
//  Observer
//
//  Created by roy.cao on 2018/12/7.
//  Copyright © 2018 roy.cao. All rights reserved.
//

import Foundation

public protocol ObservableType {
    associatedtype Element

    func subscribe(_ observer: @escaping (Element) -> Void) -> Disposable
}
