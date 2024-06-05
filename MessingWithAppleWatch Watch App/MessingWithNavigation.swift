//
//  MessingWithNavigation.swift
//  MessingWithAppleWatch Watch App
//
//  Created by Fabio Freitas on 10/05/24.
//

import SwiftUI
import CoreData
import WidgetKit

struct MessingWithNavigation: View {
    @Environment(\.managedObjectContext) var ctx
    
    @State var modalIsOpen = false
    
    
    var body: some View {
        TabView {
            VStack {
                Button("Save on Core Data") {
                    do {
                        let s = SampleEntity(context: ctx)
                        s.date = Date()
                        try ctx.save()
                        WidgetCenter.shared.reloadAllTimelines()
                        print("saved")
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .tabItem { Text("core data")}
            
            
            ZStack {
                Color.black
                    .ignoresSafeArea()
                Text("I am tab one")
                    .foregroundStyle(Color.purple.gradient)
            }
            .tabItem { Text("First") }
            
            ZStack {
                Color.black
                    .ignoresSafeArea()
                NavigationStack {
                    VStack {
                        Text("I am tab two")
                            .foregroundStyle(Color.teal.gradient)
                        NavigationLink("Navigate pls", value: "")
                    }
                    .navigationDestination(for: String.self, destination: { _ in
                        ZStack {
                            Color.black
                                .ignoresSafeArea()
                            ScrollView {
                                ForEach(Array(stride(from: 1, to: 10, by: 1)), id: \.self) { n in
                                    Button(action: {
                                        let n = Int.random(in: 10...99)
                                        SampleUserDefaultStorage.shared
                                            .saveNumber(n: n)
                                       print("Saved")
                                    }, label: {
                                        Text("Sample \(n)")
                                            .foregroundStyle(Color.pink.gradient)
                                    })
                                    Divider()
                                        .padding(.vertical)
                                }
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Right") {}
                            }
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Left") {}
                            }
                        }
                    })
                }
            }
            .tabItem { Text("Second") }
            
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Text("I am tab three")
                        .foregroundStyle(Color.cyan.gradient)
                    Button("Open modal") {
                        modalIsOpen.toggle()
                    }
                }
                .sheet(isPresented: $modalIsOpen, content: {
                    Text("I am a modal")
                        .foregroundStyle(Color.orange.gradient)
                })
                
            }
            
            .tabItem { Text("Third") }
            
            
        }
    }
}

#Preview {
    MessingWithNavigation()
        .environment(\.managedObjectContext, CoreDataStack.preview.persistentContainer.viewContext)
}
