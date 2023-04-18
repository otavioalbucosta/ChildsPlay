//
//  ContentView.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            List {
                Section("Childs"){
                    
                }
            }
            .frame(height: UIScreen.main.bounds.height/2)
            VStack{
                HStack(){
                    Text("Balls on basket: ")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack() {
                    Text("Maximum capacity: ")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
