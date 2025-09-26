# CREDDemo

Fetches data from Rick & Morty API - https://rickandmortyapi.com/graphyql

Uses Apollo GraphQL iOS SDK as a Swift Package.

List View : CharactersListView 
Displays a list of characters.

CharactersDetailView : displays individual attributes of a character and displays the AI response for a Summary of the main character and how many there are.

CharacterAIVM : Character AI View Model : calls ChatGPT or SystemLLM (Apples) to get a summary of all the characters and who is the main scientist.

CharacterVM : Character View Model : loadMoreCharacters call the Apollo fetch CharactersListQueury to fetch all the characters from the GraphQL server.

CharacterRow : used to display a cell in the CharacterListView

Easy to call the LLM using SwiftAI and easy to switch between different LLM's if necessary. Easy to change the question in CharacterAIVM.

Any Questions : email : pmurphyjam@gmail.com