//
//  Argument.swift
//  CountOnMe
//
//  Created by Gilles David on 21/07/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct Argument {
    var arg: String = ""
    
    mutating func addChar(_ char: String) -> String {
        let argTmp = self.arg + char
        self.arg = argTmp
        
//        let string = "🇩🇪€4€9"
//        let matched = matches(for: "[0-9]", in: string)
//        print("===1",matched)


//        let str = "a311dadsddabc"
//                 // 1. Create a regular expression rule
//        let pattern = "^[a-z].*[a-z]$"
//        // 2. Create a regular expression object
//        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
//            return ""
//        }
//                 // 3. Match the contents of the string
//       let results =  regex.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))
//        
//                 // 4. Traverse the array and get the result [NSTextCheckingResult]
//        for result in results {
//            print(result.range)
//            let string = (str as NSString).substring(with: result.range)
//            print("===2",string)
//        }


//        do {
//         let input = "My name is Taylor Swift"
//         let regex = try NSRegularExpression(pattern: "My name is (.*)", options: NSRegularExpression.Options.caseInsensitive)
//         let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
//
//         if let match = matches.first {
//          let range = match.range(at:1)
//          if let swiftRange = Range(range, in: input) {
//           let name = input[swiftRange]
//          }
//         }
//            print("===3",matches)
//        } catch {
//         // regex was bad!
//        }
        
        return argTmp
        
    }
    
    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.compactMap {
                Range($0.range, in: text).map { String(text[$0]) }
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
extension String {
    func matches(regex: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.caseInsensitive]) else { return [] }
        let matches  = regex.matches(in: self, options: [], range: NSMakeRange(0, self.count))
        return matches.compactMap { match in
            return String(self[Range(match.range, in: self)!])
        }
    }
    
    func match(_ regex: String) -> [[String]] {
            let nsString = self as NSString
            return (try? NSRegularExpression(pattern: regex, options: []))?.matches(in: self, options: [], range: NSMakeRange(0, count)).map { match in
                (0..<match.numberOfRanges).map { match.range(at: $0).location == NSNotFound ? "" : nsString.substring(with: match.range(at: $0)) }
            } ?? []
        }
}
