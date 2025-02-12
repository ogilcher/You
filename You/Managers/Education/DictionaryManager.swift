//
//  DictionaryManager.swift
//  You
//
//  Created by Oliver Gilcher on 2/3/25.
//

import Foundation

final class DictionaryAPIManager {
    static let shared = DictionaryAPIManager()
    
    private let apiKey = "49b6ef5e-bac7-432a-9dbd-166abca3f9e4"
    private let randomWordURL = "https://random-word-api.herokuapp.com/word?number=1"

    private init() {}
    
    func fetchRandomWord() async -> String {
        guard let data: [String] = await WebServiceManager.shared.downloadData(fromURL: randomWordURL) else {
            return "" }
        return data.first ?? ""
    }
    
    func fetchWord(for word: String) async -> Word {
        let wordList = await fetchWordList(for: word, from: "https://dictionaryapi.com/api/v3/references/sd4/json/\(word)?key=\(apiKey)")
        return (wordList?.first)!
    }
    
    private func fetchWordList(for word: String, from url: String) async -> [Word]? {
        return await WebServiceManager.shared.downloadData(fromURL: url)
    }
    
    func fetchPronounciation(for word: String) async -> String {
        let word = await fetchWord(for: word)
        
        let baseFileName : String = word.hwi.prs.sound.audio
        var subDir : String
        
        if (baseFileName.hasPrefix("bix")) {
            subDir = "bix"
        } else if (baseFileName.hasPrefix("gg")) {
            subDir = "gg"
        } else {
            subDir = String(baseFileName[baseFileName.startIndex])
        }
        
        return "https://media.merriam-webster.com/audio/prons/en/us/mp3/\(subDir)/\(baseFileName).mp3"
    }
}
