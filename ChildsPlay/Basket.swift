import Foundation

class Basket: ObservableObject {
    
    static var shared = Basket()
    
    @Published var ballCount: Int
    @Published var maxCapacity: Int
    
    func setCapacity(quantity: Int) {
        self.maxCapacity = quantity
    }
    
    init(ballCount: Int = 0, maxCapacity: Int = 0) {
        self.ballCount = ballCount
        self.maxCapacity = maxCapacity
    }

}
