//
//  SpellingBeeViewModel.swift
//  You
//
//  Created by Oliver Gilcher on 2/3/25.
//

import Foundation


@MainActor
class SpellingBeeViewModel: ObservableObject {
    @Published var word : String = "baseball"
    
    func getLink() {
        Task {
            print(await DictionaryAPIManager.shared.fetchPronounciation(for: word))
        }
    }
}
