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
     @State var toggleCreateChildSheet: Bool = false

     var body: some View {
          VStack {
               List {
                    Section("Childs"){
                         ForEach(list.children, id: \.id) { child in
                              HStack{
                                   switch child.state {
                                   case .waiting:
                                        Animation(name: "child", totalFrames: 1) .scaledToFit()
                                        Spacer()
                                        Text("Esperando bola")
                                   case .hasBallIsPlaying:
                                        Animation(name: "brinq", totalFrames: 2) .scaledToFit()
                                        Spacer()
                                        VStack {
                                             Text("Tempo jogando") .padding() .multilineTextAlignment(.leading)
                                             Text("\(String(child.currentTime))")
                                        }
                                   case .hasBallCantPlay:
                                        Animation(name: "child", totalFrames: 1) .scaledToFit()
                                        Spacer()
                                        VStack {
                                             Text("Esperado cesto esvaziar") .padding() .multilineTextAlignment(.leading)
                                             Text("\(String(child.currentTime))")
                                        }
                                   case .resting:
                                        Animation(name: "comida", totalFrames: 4) .scaledToFit()
                                        Spacer()
                                        VStack {
                                             Text("Tempo descansando") .padding() .multilineTextAlignment(.leading)
                                             Text("\(String(child.currentTime))")
                                        }
                                   }
                              }.frame(height: UIScreen.main.bounds.height / 12)
                         }

                    }

               }
               .frame(height: UIScreen.main.bounds.height/4*3)
               HStack {
                    Button("Add kid") {
                         toggleCreateChildSheet.toggle()

                    }.sheet(isPresented: $toggleCreateChildSheet) { ChildSheet(list: list) }
               }

               VStack{
                    HStack(){
                         Text("Balls on basket: \(Basket.shared.ballCount)")
                              .multilineTextAlignment(.leading)
                         Spacer()
                    }
                    HStack() {
                         Text("Maximum capacity: \(Basket.shared.maxCapacity)")
                              .multilineTextAlignment(.leading)
                         Spacer()
                    }
                    if Basket.shared.ballCount > 0 {
                         Image("basket2")
                    } else {
                         Image("basket1")
                    }
               }
               Spacer()
          }
          .padding()
     }
}

struct ChildSheet: View {
     @Environment(\.dismiss) var dismiss

     @State var timePlaying: String	= ""
     @State var timeResting: String	= ""
     @State var hasBall: Bool		= false
     @ObservedObject var list: ChildrenList

     var body: some View {
          VStack {
               TextField("Tempo de jogo", text: $timePlaying)
                    .padding()
                    .textFieldStyle(.roundedBorder)
               TextField("Tempo de descanso", text: $timeResting)
                    .padding()
                    .textFieldStyle(.roundedBorder)
               Toggle("Tem bola", isOn: $hasBall)
                    .padding()
               Button("Construir a criança com o poder do pentacampeonato") {
                    let child = Child(ball: hasBall,timePlaying: Int(timePlaying) ?? 0, timeResting: Int(timeResting) ?? 0, list: list)
                    list.children.append(child)
                    DispatchQueue.global(qos: .background).async {
                         child.run()
                    }
                    dismiss()
               }
          }
     }
}

struct Animation: View {
     @State private var currentFrame: Int = 1
     var name: String
     var totalFrames: Int

     let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()

     var body: some View {
          VStack {
               Image("\(name)\(currentFrame)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onReceive(timer) { _ in
                         if self.currentFrame < totalFrames {
                              self.currentFrame += 1
                         } else {
                              self.currentFrame = 1
                         }
                    }
          }
     }
}
struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
          ContentView()
     }
}
