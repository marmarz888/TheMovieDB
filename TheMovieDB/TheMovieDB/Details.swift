//
//  Details.swift
//  TheMovieDB
//
//  Created by Mariano Manuel on 7/16/22.
//

import SwiftUI

struct Details: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var Poster: Data
    @Binding var Title: String
    @Binding var ReleaseDate: String
    @Binding var Overview: String
    @Binding var Rating: Double
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    Image(uiImage: UIImage(data: Poster)!)
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    Text(Title)
                        .font(.title)
                        .bold()
                    HStack {
                        Spacer()
                        Text(ReleaseDate)
                        Spacer()
                        
                        Text("\(Rating)")
                        Spacer()
                    }
                    Text("Overview: ")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(Overview)
                        .lineLimit(9)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Add Movie Or Show To Favorites")
                        let newItem = Item(context: viewContext)
                        newItem.title = Title
                        newItem.rating = Rating
                        newItem.poster = Poster
                        newItem.overview = Overview
                        newItem.date = ReleaseDate

                        do {
                            try viewContext.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        Details(Poster: .constant(Data()), Title: .constant("Title"), ReleaseDate: .constant("April 20, 2022"), Overview: .constant("Overview"), Rating: .constant(9.0))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
