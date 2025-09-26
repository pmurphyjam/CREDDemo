//
//  CharacterRow.swift
//  CREDDemo
//
//  Created by Pat Murphy on 9/25/25.
//

import SwiftUI
import CREDAPI
import SDWebImageSwiftUI

struct CharacterRow: View {
    let character: CharactersListQuery.Data.Characters.Result?
    private let placeholderImg = Image("placeholder")
    
    var body: some View {
        HStack {
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
            
            VStack(alignment: .leading) {
                Text(character?.name ?? "Name")
                Text(character?.gender ?? "Gender")
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
        .padding(4)
    }
    
}

//#Preview {
//    CharacterRow()
//}

