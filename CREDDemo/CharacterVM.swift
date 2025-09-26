//
//  CharacterVM.swift
//  CREDDemo
//
//  Created by Pat Murphy on 9/24/25.
//

import SwiftUI
import Apollo
import CREDAPI
internal import Combine

@MainActor
@Observable
class CharacterVM: Identifiable {
    var id = UUID()
    var characters = [CharactersListQuery.Data.Characters.Result]()
    var appAlert: AppAlert?
    var loaded:Bool = false
    
    var charactersAIVM = CharacterAIVM()
    
    func fetchAI() async {
        await charactersAIVM.fetchCapitalOfFrance()
    }
    
    func fetchAISummary2(characters: [CharactersListQuery.Data.Characters.Result]) async {
        await charactersAIVM.callAISummary(characters:characters)

    }
    
    func getModel() -> String! {
        return "Model: " + charactersAIVM.model
    }
    
    func getQuestion() -> String {
        charactersAIVM.question
    }
    
    func getAnswer() -> String {
        charactersAIVM.lastResponse
    }
    
    func loadMoreCharacters() {
        if(!loaded) {
            Network.shared.apollo.fetch(query: CharactersListQuery()) { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let graphQLResult):
                    loaded = true
                    if let characterConnection = graphQLResult.data?.characters {
                        self.characters.append(contentsOf: (characterConnection.results?.compactMap({ $0 }))!)
                    }
                    
                    if let errors = graphQLResult.errors {
                        self.appAlert = .errors(errors: errors)
                    }
                case .failure(let error):
                    self.appAlert = .errors(errors: [error])
                }
            }
        }
    }
    
}

