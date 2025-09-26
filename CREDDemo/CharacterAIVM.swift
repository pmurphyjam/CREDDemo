//
//  CharacterAIVM.swift
//  CREDDemo
//
//  Created by Pat Murphy on 9/25/25.
//

import SwiftUI
import Observation
import SwiftAI
import CREDAPI

@MainActor
@Observable
class CharacterAIVM : Identifiable {
    var id = UUID()
    
    private let llmSystem = SystemLLM()
    private let llmOpenAI = OpenaiLLM(apiToken:"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", model: "gpt-4o-mini")

    let model: String = "Open AI gpt-40-mini"
    var lastResponse: String = ""
    var question: String = "Question: Give me a summary of who is the main scientist in this dataset and how many characters are there?"
    
    func fetchCapitalOfFrance() async {
        do {
            let response = try await llmOpenAI.reply(to: "What is the capital of France?")
            lastResponse = response.content
            print(response.content)
        } catch {
            print("Failed to get reply: \(error)")
        }
    }
    
    func callAISummary(characters: [CharactersListQuery.Data.Characters.Result]) async {
        
        let characterData = convertCharactersToJSONArray(characters:characters)
        let jsonData: [String: Any] = [
            "characters":characterData,
            "series": "Rick and Morty"
        ]

        print(jsonData)
        let jsonString: String
        if let data = try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted),
           let string = String(data: data, encoding: .utf8) {
            jsonString = string
        } else {
            jsonString = "{}"
        }

        // Create a combined AI prompt with json string
        let prompt = """
           Here is a dataset in JSON format:

           \(jsonString)

           \(question)
           """
        //End of prompt
        
        do {
            let response = try await llmOpenAI.reply(to: prompt)
            lastResponse = response.content
            print("Answer is : ")
            print(lastResponse)
        } catch {
            print("Failed to get reply: \(error)")
        }
    }
    
    func convertCharactersToJSONArray(characters: [CharactersListQuery.Data.Characters.Result]) -> Array<Any>
    {
        let characterData = characters.map { c in
            [
                "name": c.name ?? "",
                "species": c.species ?? "",
                "status": c.status ?? "",
                "gender": c.gender ?? "",
                "image": c.image ?? "",
                "type": c.type ?? "",
                "typename": c.__typename ?? "",
                "origin": c.origin?.name ?? "",
                "location": c.location?.name ?? ""
            ]
        }
        return characterData
    }
    
}
