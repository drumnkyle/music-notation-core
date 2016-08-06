//
//  Key.swift
//  MusicNotationKit
//
//  Created by Kyle Sherman on 7/11/15.
//  Copyright © 2015 Kyle Sherman. All rights reserved.
//

public struct Key {
	
	private let type: KeyType
	private let noteLetter: NoteLetter
	private let accidental: Accidental?
	
	public init(noteLetter: NoteLetter, accidental: Accidental? = nil, type: KeyType = .major) {
		self.noteLetter = noteLetter
		self.accidental = accidental
		self.type = type
	}
}


extension Key: CustomDebugStringConvertible {
	public var debugDescription: String {
		return "\(noteLetter) \(type)"
	}
}

extension Key: Equatable {
    public static func ==(lhs: Key, rhs: Key) -> Bool {
        if lhs.type == rhs.type &&
            lhs.noteLetter == rhs.noteLetter &&
            lhs.accidental == rhs.accidental {
            return true
        } else {
            return false
        }
    }
}

