//
//  Character+Extension.swift
//  OMPToolKit
//
//  Created by flion on 2018/11/10.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
// MARK: - Properties
public extension Character {
    /// Check if character is emoji
    /// - example: Character("😊").isEmoji -> true
    public var isEmoji: Bool {
        let scalarValue = String(self).unicodeScalars.first!.value
        switch scalarValue {
            case 0x3030, 0x00AE, 0x00A9, // Special Character > 特殊字符
            0x1D000...0x1F77F, // Emoticons > 情感符
            0x2100...0x27BF, // Misc symbols and Dingbats >
            0xFE00...0xFE0F, // Variation Selectors > 变异选择符
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs > 补充的符号和象形文字
            return true
        default:
            return false
        }
    }
    
    /// Check if character is number
    /// - example: Character("1").isNummber
    public var isNumber: Bool {
        return Int(String(self)) != nil
    }
    
    /// Check if character is a letter(字母)
    /// - example: (1) Character("4").isLetter -> false, (2) Character("a").isLetter -> True
    public var isLetter: Bool {
        return String(self).rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// Check if character is lowercased
    /// - example: (1) Character("a").isLowercased -> true, (2) Character("A").isLowercased -> false
    public var isLowercased: Bool {
        return String(self) == String(self).lowercased()
    }
    
    /// Check if character is uppercased
    /// - example: (1) Character("a").isUppercased -> true, (2) Character("A").isUppercased -> true
    public var isUppercased: Bool {
        return String(self) == String(self).uppercased()
    }
    
    /// Check if character is white space(空格)
    /// - example: (1) Character(" ").isWhiteSpace -> true, (2) Character("A").isWhiteSpace -> false
    public var isWhiteSpace: Bool {
        return String(self) == " "
    }
    
    /// Integer value from character (if applicable)
    /// - example: (1) Character("1").int -> 1, (2) Character("A").int -> nil
    public var int: Int? {
        return Int(String(self))
    }
    
    // String value from character
    public var string: String {
        return String(self)
    }
    
    /// Return the character lowercased
    public var lowercased: Character {
        return String(self).lowercased().first!
    }
    
    /// Return the character uppercased
    public var uppercased: Character {
        return String(self).uppercased().first!
    }
}


// MARK: - Methods
public extension Character {
    /// Random character
//    public static func randomAlphanumeric() -> Character {
//        return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()!
//    }
}

// MARK: - Operater
public extension Character {
    /// Repeat character multiple times
    /// - example: Character("=") * 10 -> "=========="
    /// - Parameters:
    ///     - lhs: charater to repeat.
    ///     - rhs: number of times to repeat character.
    /// - Returns: strign with charater repeated n times.
    public static func * (lhs: Character, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: String(lhs), count: rhs)
    }
    
    /// Repeat character mltiple tiems
    /// - exmaple: 10 * Character("-") -> "----------"
    /// - Parameter:
    ///     - lhs: number of times to repeat character.
    ///     - rhs: character to repeat
    /// - Returns: string with character repeated n times
    public static func * (lhs: Int, rhs: Character) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: String(rhs), count: lhs)
    }
}
