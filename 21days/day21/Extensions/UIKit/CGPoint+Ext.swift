//
//  CGPoint+Ext.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/29.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

extension CGPoint: ExpressibleByStringLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public init(stringLiteral value: StringLiteralType) {
        self.init()
        let point: CGPoint
        if value[value.startIndex] != "{" {
            point = CGPointFromString("{\(value)}}")
        } else {
            point = CGPointFromString(value)
        }
        self.x = point.x
        self.y = point.y
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public typealias UnicodeScalarLiteralType = StringLiteralType
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: value)
    }
}
