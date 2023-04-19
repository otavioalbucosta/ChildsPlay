//
//  ContentView.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import SwiftUI

class ChildrenList: ObservableObject{
    @Published var children: [Child] = []
    
    func willUpdate() {
        objectWillChange.send()
    }
}

struct ContentView: View {

    @ObservedObject var list: ChildrenList = ChildrenList()
    
    var body: some View {
        VStack {
            List {
                Section("Childs"){

                    ForEach(list.children, id: \.id) { child in
                            HStack{
                                VStack{
                                    Text("\(child.id))".prefix(5))
                                    Text("Tem bola? \(child.ball.description)")
                                    Text(child.isWaiting ? "Está esperando" : "Está ativo")
                                }
                                Spacer()
                                VStack{
                                    Text("Tempo restante \(child.ball ? "jogando" : "descansando"): \(child.currentTime)").padding()
                                }
                            }
                        }
                    
                }
                
            }
            .frame(height: UIScreen.main.bounds.height/2)
            HStack {
                Button("Add w Ball") {
                    var child = Child(ball: true,timePlaying: 5, timeResting: 5, list: list)
                    list.children.append(child)
                    DispatchQueue.global(qos: .background).async {
                        child.run()
                    }
                }
                Button("Add no Ball") {
                    var child = Child(ball: false,timePlaying: 5, timeResting: 5, list: list)
                    list.children.append(child)
                    DispatchQueue.global(qos: .background).async {
                        child.run()
                    }
                }
                
            }
            
            VStack{
                HStack(){
                    Text("Balls on basket: \(currentBasket.ballCount)")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack() {
                    Text("Maximum capacity: \(currentBasket.maxCapacity)")
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
