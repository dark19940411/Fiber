//
//  StringHelper.swift
//  Fiber
//
//  Created by turtle on 2017/8/6.
//
//

import Foundation

extension String {
    func turnToURL() -> URL? {
        return URL(string: self)
    }
}
