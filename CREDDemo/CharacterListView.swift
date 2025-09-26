//
//  CharacterListView.swift
//  CREDDemo
//
//  Created by Pat Murphy on 9/25/25.
//

import SwiftUI

struct CharacterListView: View {
    private var viewModel = CharacterVM()
    
    var body: some View {
        @Bindable var viewModel = self.viewModel
        NavigationStack {
            List {
                ForEach(viewModel.characters, id: \.self) { (character) in
                    NavigationLink(destination: CharacterDetailView(character: character,viewModel:viewModel)) {
                        CharacterRow(character: character)
                    }
                }
            }
            .task {
                viewModel.loadMoreCharacters()
                await viewModel.fetchAI()
                await viewModel.fetchAISummary2(characters: viewModel.characters)
            }
            .navigationTitle("Characters")
            .appAlert($viewModel.appAlert)
        }
    }
    
    
}

#Preview {
    CharacterListView()
}

