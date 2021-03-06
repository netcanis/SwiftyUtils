//
//  Created by Tom Baranes on 24/04/16.
//  Copyright © 2016 Tom Baranes. All rights reserved.
//

import Foundation

// MARK: - Subscript

extension String {

    public subscript(integerIndex: Int) -> Character {
        return self[index(startIndex, offsetBy: integerIndex)]
    }

    public subscript(integerRange: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: integerRange.lowerBound)
        let end = index(startIndex, offsetBy: integerRange.upperBound)
        return String(self[start..<end])
    }

}

// MARK: - Misc

extension String {

    public var length: Int {
        return self.characters.count
    }

    public func contains(_ text: String, compareOption: NSString.CompareOptions) -> Bool {
        return self.range(of: text, options: compareOption) != nil
    }

}

// MARK: - Validator

extension String {

    public var isNumeric: Bool {
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        return hasNumbers && !hasLetters
    }

    public var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

}

// MARK: - Computed Properties

extension String {

    public var uncamelized: String {
        let upperCase = CharacterSet.uppercaseLetters
        return self.unicodeScalars.map {
            upperCase.contains($0) ? "_" + String($0).lowercased(): String($0)
        }.joined()
    }

    public var capitalizedFirst: String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }

    public mutating func trim() {
        self = trimmed()
    }

    public mutating func truncate(limit: Int) {
        self = truncated(limit: limit)
    }

}

// MARK: - Transform

extension String {

    public func trimmed() -> String {
        return components(separatedBy: NSCharacterSet.whitespacesAndNewlines).joined(separator: "")
    }

    public func truncated(limit: Int) -> String {
        if self.length > limit {
            var truncatedString = self[0..<limit]
            truncatedString = truncatedString.appending("...")
            return truncatedString
        }
        return self
    }

    public func split(intoChunksOf chunkSize: Int) -> [String] {
        var output = [String]()
        let splittedString = characters
            .map { $0 }
            .split(intoChunksOf: chunkSize)
        splittedString.forEach {
            output.append($0.map { String($0) }.joined(separator: ""))
        }
        return output
    }

}
