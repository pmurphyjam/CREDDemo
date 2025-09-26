//
//  CharacterDetailView.swift
//  CREDDemo
//
//  Created by Pat Murphy on 9/25/25.
//

import SwiftUI
import SDWebImageSwiftUI
import CREDAPI

struct CharacterDetailView: View {
    private let placeholderImg = Image("placeholder")
    let character: CharactersListQuery.Data.Characters.Result?
    let viewModel: CharacterVM?
    
    var body: some View {
        VStack(alignment: .center) {
            WebImage(url: character?.image.flatMap(URL.init(string:))) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                placeholderImg
                    .resizable()
                    .scaledToFit()
            }
            .indicator(SDWebImageSwiftUI.Indicator.activity)
            .frame(width: 50, height: 50)
            Text(character?.name ?? "Name")
            Text(character?.gender ?? "Gender")
            Text(character?.species ?? "Species")
            Text(character?.status ?? "Status")
            Text(character?.type ?? "Type")
            Text(character?.origin?.name ?? "Origin")
            Text(character?.location?.name ?? "Location")
            Spacer()
            VStack {
                Text("AI Summary")
                Text(viewModel?.getModel() ?? "Model")
                Text(viewModel?.getQuestion() ?? "No Question")
                Spacer()
                Text(viewModel?.getAnswer() ?? "No Answer")
                Spacer()
            }
            .padding(.horizontal, 10)
        }
            
        Spacer()
    }
}
    
    
    
    

