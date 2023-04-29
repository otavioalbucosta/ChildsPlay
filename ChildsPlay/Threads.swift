import Foundation
import SwiftUI

// Semáforo padrão do Swift
var basketSemaphore = DispatchSemaphore(value: 0)
var basketFullSemaphore: DispatchSemaphore!

protocol Thread {
    func run()
    func updateView()
}

extension Child: Thread {
    
    func run() {    //lógica base do semáforo
        DispatchQueue(label: "com.ChildsPlay.ChildsPlaying", qos: .utility, attributes: .concurrent).async {    //Cria as threads do Swift em modo assíncrono e manda elas rodarem em background.
            while(true){
                if self.ball == true {  // checa se a criança tem bola
                    self.play()                     // manda a criança brincar, tirando a bola
                    DispatchQueue.main.async {
                        self.updateView()
                    }
                    basketSemaphore.signal()        // avisa para o semáforo de poder TIRAR que bola está sendo DEVOLVIDA
                    basketFullSemaphore.wait()      // avisa para o semáforo de poder DEVOLVER a bola que uma foi DEVOLVIDA
                    _ = Basket.shared.addBall()     // avisa para o singleton da basket que uma bola foi DEVOLVIDA
                    self.ball = false               // criança não tem mais bola
                    DispatchQueue.main.async {
                        self.updateView()
                    }
                    self.rest()                     // criança está descansando, estando sem bola, que quebrará o loop assim que terminar de rodar
                    DispatchQueue.main.async {
                        self.updateView()
                    }
                } else {
                    basketSemaphore.wait()          // avisa para o semáforo de poder TIRAR que bola está sendo TIRADA
                    basketFullSemaphore.signal()    // avisa para o semáforo de poder DEVOLVER a bola que uma foi TIRADA
                    _ = Basket.shared.removeBall()  // decrementa quantidade de bolas no singleton
                    self.ball = true                // criança agora tem bola, que passará no if assim que terminar de rodar
                    DispatchQueue.main.async {
                        self.updateView()
                    }


                }
            }
        }
    }
    
    func updateView() {
        self.list.children = self.list.children.map({$0})
    }
    
}

extension Basket {
    func addBall() -> Bool {
        if ballCount < maxCapacity{
            ballCount += 1
            return true
        }else{

            print("Ball limit")
            return false
        }
        
    }
    
    
    func removeBall() -> Bool{
        if ballCount > 0 {
            ballCount -= 1
            return true
        }else{
            return false
        }

    }
}
