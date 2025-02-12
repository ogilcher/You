//
//  Word.swift
//  You
//
//  Created by Oliver Gilcher on 2/3/25.
//

struct Word: Codable {
    let meta: Meta
    let hwi: HWI
}

/// Object containing Members
struct Meta: Codable {
    let id: String
    let uuid: String
    let src: String // source data for entry - ignore
    let section: String // section (alpha - main alphabetical, biog - biographical, geog - geographical, fw&p - foreign words
    let stems: [String] // headwords, variants, inflections and defined run-on phrases
    let offensive: Bool // whether or not the word is offensive
}

/// Unused "HOM" - Homograph which holds a number of headwords

/// Headword Information, holds how it would be stored in library context and it's audio information
struct HWI: Codable {
    let hw: String
    let prs: PRS
}

/// Pronounciation
/// Optional (this does not occur in all cases)
struct PRS: Codable {
    let mw: String
    let sound: Sound
}

struct Sound: Codable {
    let audio: String
}
