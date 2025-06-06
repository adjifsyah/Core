//
//  KeyedDecodingContainer.swift
//
//
//  Created by Apple Josal on 20/02/25.
//

import Foundation

extension KeyedDecodingContainer {
    public func decodeDynamicInt(forKey key: Key) -> Int {
        if let value = try? decode(Int.self, forKey: key) {
            return value
        } else if let doubleValue = try? decode(Double.self, forKey: key) {
            return Int(doubleValue)
        } else if let stringValue = try? decode(String.self, forKey: key), let convertedValue = Int(stringValue) {
            return convertedValue
        } else {
            return 0
        }
    }

    public func decodeDynamicDouble(forKey key: Key) -> Double {
        if let value = try? decode(Double.self, forKey: key) {
            return value
        } else if let intValue = try? decode(Int.self, forKey: key) {
            return Double(intValue)
        } else if let stringValue = try? decode(String.self, forKey: key), let convertedValue = Double(stringValue) {
            return convertedValue
        } else {
            return 0.0
        }
    }

    public func decodeDynamicString(forKey key: Key) -> String {
        if let value = try? decode(String.self, forKey: key) {
            return value
        } else if let intValue = try? decode(Int.self, forKey: key) {
            return String(intValue)
        } else if let doubleValue = try? decode(Double.self, forKey: key) {
            return String(doubleValue)
        } else {
            return ""
        }
    }
    
//    public func decodeDynamicModel<T: Decodable & DefaultInitializable>(
//        _ type: T.Type,
//        forKey key: Key
//    ) -> T {
//        if let value = try? decode(T.self, forKey: key) {
//            return value
//        } else {
//            return T()
//        }
//    }
}

protocol DefaultInitializable {
//    public init()
}
