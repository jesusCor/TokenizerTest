//
//  StringExtensions.swift
//  TokenizerTest
//
//  Created by Jesus Coronado on 05/01/2024.
//

import Foundation


extension String {
    // We'll use our own components function to allow passing an array of separators in one (keywords).
    func components<T>(separatedBy separators: [T]) -> [String] where T : StringProtocol {
        var result = [self]
        for separator in separators {
            result = result
                .map { $0.components(separatedBy: separator)}
                .flatMap { $0 }
        }
        return result
    }
}
