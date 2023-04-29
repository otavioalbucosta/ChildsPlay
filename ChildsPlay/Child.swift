import Foundation
import SwiftUI

enum states {
    case hasBallIsPlaying
    case hasBallCantPlay
    case waiting
    case resting
}


class Child: Identifiable{
    
    var id = UUID()
    var ball: Bool
    var timePlaying: Int
    var timeResting: Int
    var currentTime: Int = 0
    var isWaiting: Bool = false
    var canPlay: Bool = true
    var list: ChildrenList
    lazy var state: states = {      //basicamente pedindo para que o state sempre seja .waiting quando child for iniciada pela primeira vez. precisamos do lazy dado ao funcionamento do ARC
        return .waiting
    }()
    
    init(ball: Bool, timePlaying: Int, timeResting: Int, list: ChildrenList) {
        self.ball = ball
        self.timePlaying = timePlaying
        self.timeResting = timeResting
        self.list = list
    }
    
    func play() {
        state = .hasBallIsPlaying       //define estado do jogador. Isso afeta o gráfico na tela por causa do switch que tem lá na content view
        currentTime = timePlaying       //inicia o timer de "brincadeira" do usuário
        let time = Date()               //puxa o tempo atual
        var actualTime = time           //define uma variável com base no tempo atual
        isWaiting = false               //desliga a flag do isWaiting,
        
        while(Int(-time.timeIntervalSinceNow) < timePlaying){   //primeiro, invertemos o valor que representa quanto tempo se passou desde que chamamos time. convertemos o então para inteiro e comparamos com o tempo que a child ja brincou.
            if -actualTime.timeIntervalSinceNow >= 1{           //se quanto tempo ja se passou do inverso do temp atual foi maior ou igual a (ou seja, se ja tiver se passado pelo menos um segundo), esse if é satisfeito
                self.currentTime -= 1                           //tempo atual que falta para a criança terminar de brincar é decrementado
                actualTime = Date()                             //novo tempo atual é chamado
                DispatchQueue.main.async {
                    self.updateView()
                }
                print("Brincando, tempo restante: \(-time.timeIntervalSinceNow)")
            }
            //O sleep é no while, que é no processo principal, a Thread NUNCA da sleep
            //O sleep é feito pro while não gerar Threads incessantemente
            //            sleep(1)
        }
        canPlay = false                 //define a flag para que ele possa ser corretamente processado em outros passos
        state = .hasBallCantPlay        //define o state para que a tela mostre-o corretamente
    }
    
    func rest() {
        state = .resting                //idem a definição de state em play()
        currentTime = timeResting       //define o timer para o tempo que falta da child descansando
        let time = Date()               //chama a hora atual
        var actualTime = time           //define uma variavel baseada na hora atual
        
        while(Int(-time.timeIntervalSinceNow) < timeResting){   //primeiro, invertemos o valor que representa quanto tempo se passou desde que chamamos time. convertemos o então para inteiro e comparamos com o tempo que a child ja descansou.
            if -actualTime.timeIntervalSinceNow >= 1{           //praticamente igual ao que acontece em play()
                currentTime -= 1
                actualTime = Date()
                DispatchQueue.main.async {
                    self.updateView()
                }
                print("Descansando, tempo restante: \(-time.timeIntervalSinceNow)")
            }
            
            //            sleep(1)
        }
        canPlay = true      //ditto
        isWaiting = true    //ditto
        state = .waiting    //ditto
    }
    
}
