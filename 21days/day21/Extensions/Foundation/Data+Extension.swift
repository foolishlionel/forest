//
//  Data+Extension.swift
//  OMPToolKit
//
//  Created by flion on 2018/11/12.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension Data {
    /// Return data as an array of bytes
    public var bytes: [UInt8] {
        return [UInt8](self)
    }
}

// MARK: - Methods
public extension Data {
    /// String by encoding Data using the given encoding (if applicable - 可适用的、可应用的)
    /// - Parameter encoding: encoding
    /// - Returns: String by encoding Data using the given encoding (if applicable)
    public func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    /// Return a Foundation object from given JSON data.
    /// - Parameter options: Options for reading the JSON data and creating the Foundation object.
    ///     - For possible values, see `JSONSerialzation.ReadingOptions`.
    /// - Returns: A foundation object from the JSON data in the receiver, or nil if an error occurs
    /// - Throws: An `NSErrror` if the receiver does not represent a valid JSON object
    public func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}
