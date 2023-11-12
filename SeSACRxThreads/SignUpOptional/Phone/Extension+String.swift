//
//  Extension+String.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/11/01.
//

import Foundation

//For Phone Number Format: no Text other than number input

extension String {
    var decimalFilteredString: String {
        return String(unicodeScalars.filter(CharacterSet.decimalDigits.contains))
    }
    
    func formated(by patternString: String) -> String {
        let digit: Character = "#"
 
        let pattern: [Character] = Array(patternString)
        let input: [Character] = Array(self.decimalFilteredString)
        var formatted: [Character] = []
 
        var patternIndex = 0
        var inputIndex = 0
 
        // 2
        while inputIndex < input.count {
            let inputCharacter = input[inputIndex]
 
            // 2-1
            guard patternIndex < pattern.count else { break }
 
            switch pattern[patternIndex] == digit {
            case true:
                // 2-2
                formatted.append(inputCharacter)
                inputIndex += 1
            case false:
                // 2-3
                formatted.append(pattern[patternIndex])
            }
 
            patternIndex += 1
        }
 
        // 3
        return String(formatted)
    }
}
