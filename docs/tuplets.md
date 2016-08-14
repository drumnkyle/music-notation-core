# Tuplet Design

## Groupings
Most of then you see a grouping of 3, 5, 6, 7, or 9. However, You may also see a grouping of 2, 4, or 8 if you are a time signature where the top number is an odd number. Also, most places that go over tuplets list the following groupings:
- Duplet (2)
- Triplet (3)
- Quadruplet (4)
- Quintuplet (5)
- Sextuplet (6)
- Septuplet (7)
- Octuplet (8)
- Nontuplet (9)

But they all end with etc. Therefore, I don't think we should validate the number. It seems that it can really be any arbitrary number.

## Definition
A complete tuplet definition requires knowing how many of what duration fits into the space of how many of a certrain duration. This is how you define the ratio.
You can see a simple dialog box that shows this very clearly [here](https://usermanuals.finalemusic.com/Finale2014Mac/Content/Finale/TPDLG.htm).

Usually the two note durations would be the same, but you can do the calculation with any duration. For instance, you would normally define a standard eighth note triplet in 4/4 as "3 eighth notes in the space of 2 eighth notes". However, you could also define that as "3 eighth notes in the space of 1 quarter note". The ratio here would be 3:2.

## Standard Ratios
There are certain ratios that are standard, like a triplet would usually have a ratio of 3:2. However, there are also non-standard ratios where you can use whatever you'd like, such as 8:5. It would be good to have the standard ratios defined so that, for instance, a user can create a triplet and not have to define the full ratio.

There should only be a need to list the standard ratios for 2-9. In this case, we can just list them in `Tuplet` struct. This way, if the second number is not specific in the initializer and the first number is one of these, we can fill in the second number according to th static list of default ratios.

## Validation
A tuplet needs to always be full. This means if it is a 3:2 ratio, it needs to have 3 notes in it. However, the notes can be rests. Because of this, the only mutating function should be to replace a note, not remove or add.
You may also have notes of different durations as part of the tuplet as seen [here](http://www2.siba.fi/muste1/index.php?id=100&la=en) where you have triplets with eighth notes and tied quarter notes.

Because of these rules, some type of validation must be done in the initializer to ensure the given notes equate to a full tuplet. This must be built into the `Tuplet` struct.

## API Design
### API Definition
**Open**: Naming is still up for debate. Having trouble with that.
```swift
struct Tuplet {
    /// The notes that make up the tuplet
    public private(set) var notes: [Note]
    /// The number of notes of the specified duration that this tuplet contains
    public let baseNoteCount: Int
    /// The duration of the notes that define this tuplet
    public let baseNoteDuration: NoteDuration
    /// The number of notes that this tuplet fits in the space of
    public let noteCountFit: Int
    
    init(_ count: Int, _ duration: NoteDuration, inSpaceOf baseCount: Int? = nil, _ baseDuration: NoteDuration? = nil, notes: [Note]) throws
    mutating func replaceNote(at index: Int, with note: Note) throws
}
```
### Secondary duration
We can choose to allow a second duration to be specified like in [Finale](https://usermanuals.finalemusic.com/Finale2014Mac/Content/Finale/TPDLG.htm). However, in order to put the ratio on top, it seems like you need to convert to the same duration?

**Open**: Why have a second duration? Don't we need to convert to the same duration for the ratio?

If we do have a second duration, the initializer would function in the following way:
- The second duration is optional and will default to the same as the first duration.
- If the second duration is not the same as the first, we will need to internally convert it into the same as the first duration, so that we can use a standard ratio notation.

### Usage
If you would like to use a standard ratio, you can specify only the first number and duration. Then, `Tuplet` will validate whether the number specified is a standard (2-9) and if it is, it will automatically set the second number to the static ratio.

*Standard Ratio*
```swift
let standardTriplet = try! Tuplet(3, .eighth, notes: [eighthNote, eighthNote, eighthNote])
```
*Standard Ratio w/Odd definition*
```swift
let standardTriplet = try! Tuplet(3, .eighth, inSpaceOf: 1, .quarter, notes: [eighthNote, eighthNote, eighthNote])
```

*Custom Ratio*
```swift
let customOctuplet = try! Tuplet(
    8,
    .eighth,
    inSpaceOf: 5,
    .eighth, 
    notes: [eighthNote, eighthNote, eighthNote, eighthNote, eighthNote, eighthNote, eighthNote, eighthNote]
)
```

## Sources
http://www2.siba.fi/muste1/index.php?id=100&la=en
https://usermanuals.finalemusic.com/Finale2014Mac/Content/Finale/TPDLG.htm
https://usermanuals.finalemusic.com/Finale2014Mac/Content/Finale/SIMPLETUPLETS.htm
https://musescore.org/en/handbook/tuplet
http://www.rpmseattle.com/of_note/create-a-tuplet-of-any-ratio-in-sibelius/