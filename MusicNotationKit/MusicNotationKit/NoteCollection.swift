//
//  NoteCollection.swift
//  MusicNotationKit
//
//  Created by Kyle Sherman on 6/15/15.
//  Copyright © 2015 Kyle Sherman. All rights reserved.
//

/**
 This is a protocol that represents anything that represents one or more notes.
 i.e. `Note` and `Tuplet` both conform to this.
 */
public protocol NoteCollection {

    var noteCount: Int { get }
}

public func ==(lhs: NoteCollection, rhs: NoteCollection) -> Bool {
    if let left = lhs as? Note,
        let right = rhs as? Note,
        left == right {
        return true
    } else if let left = lhs as? Tuplet,
        let right = rhs as? Tuplet,
        left == right {
        return true
    } else {
        return false
    }
}
