//
//  CGRect+Ext.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/29.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

extension CGRect: ExpressibleByStringLiteral {
    
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public init(stringLiteral value: StringLiteralType) {
        self.init()
        
        let rect: CGRect
        if value[value.startIndex] != "{" {
            let comp = value.components(separatedBy: ",")
            if comp.count == 4 {
                rect = CGRectFromString("{{\(comp[0]), \(comp[1]), \(comp[2]), \(comp[3])}}")
            } else {
                rect = CGRect.zero
            }
        } else {
            rect = CGRectFromString(value)
        }
        
        self.size = rect.size
        self.origin = rect.origin
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public typealias UnicodeScalarLiteralType = StringLiteralType
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public var top: CGFloat {
        get { return origin.y }
        set(value) { origin.y = value }
    }
    
    public var left: CGFloat {
        get { return origin.x }
        set(value) { origin.x = value }
    }
    
    public var bottom: CGFloat {
        get { return origin.y + size.height }
        set(value) { origin.y = value - size.height }
    }
    
    public var right: CGFloat {
        get { return origin.x + size.width }
        set(value) { origin.x = value - size.width }
    }
    
    public var width: CGFloat {
        get { return size.width }
        set(value) { size.width = value }
    }
    
    public var height: CGFloat {
        get { return size.height }
        set(value) { size.height = value }
    }
    
    public var centerX: CGFloat {
        get { return origin.x + size.width / 2 }
        set(value) { origin.x = value - size.width / 2 }
    }
    
    public var centerY: CGFloat {
        get { return origin.y + size.height / 2 }
        set(value) { origin.y = value - size.height / 2 }
    }
    
    public var center: CGPoint {
        get { return CGPoint(x: centerX, y: centerY) }
        set(value) {
            centerX = value.x
            centerY = value.y
        }
    }
}
