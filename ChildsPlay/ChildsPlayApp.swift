//
//  ChildsPlayApp.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import SwiftUI

@main
struct ChildsPlayApp: App {


    @State var useAlert = true
    @State var quantity: Int = 0
    var body: some Scene {
        WindowGroup {
            ContentView()
                .alert("Insira a capacidade máxima de bolas na cesta", isPresented: $useAlert) {
                    TextField("Insira aqui", value: $quantity, formatter: NumberFormatter())
                    Button("Ok") {
                        submit(quantity: quantity)
                    }
                    .buttonStyle(.automatic)

                }
        }
    }
    
    func submit(quantity: Int) {
        Basket.shared.setCapacity(quantity: quantity)
        basketFullSemaphore = DispatchSemaphore(value: Basket.shared.maxCapacity)
    }
}
