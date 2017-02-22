//
//  MusicNotationCoreTests.swift
//  MusicNotationCore
//
//  Created by Kyle Sherman on 2/19/17.
//
//

import XCTest
import MusicNotationCore

class MusicNotationCoreTests: XCTestCase {

    func testValidMusic() {
        let timeSignature = TimeSignature(topNumber: 4, bottomNumber: 4, tempo: 120)
        let tone = Tone(noteLetter: .a, octave: .octave3) // Just because it's required by the API
        var staff = Staff(clef: .neutral, instrument: .drums)
        staff.appendMeasure(
            Measure(timeSignature: timeSignature, notes: [
                [
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone)
                ],
                [
                    Note(noteDuration: .quarter, tone: tone),
                    Note(noteDuration: .quarter),
                    Note(noteDuration: .quarter, tone: tone),
                    Note(noteDuration: .quarter)
                ]
                ])
        )
        staff.appendMeasure(
            Measure(timeSignature: timeSignature, notes: [
                [
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone),
                    Note(noteDuration: .eighth, tone: tone)
                ],
                [
                    Note(noteDuration: .quarter),
                    Note(noteDuration: .quarter, tone: tone),
                    Note(noteDuration: .quarter),
                    Note(noteDuration: .quarter, tone: tone)
                ]
                ])
        )
        for measureIndex in 0..<staff.measureCount {
            assertNoErrorThrown {
                let measure = try staff.measure(at: measureIndex)
                XCTAssertEqual(
                    MeasureDurationValidator.completionState(of: measure),
                    [.full, .full]
                )
            }
        }
    }
}