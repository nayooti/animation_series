import UIKit

extension UIColor {
    static var randomSystemColor: UIColor {
        let colors: [UIColor] = [
            .systemBlue,
            .systemRed,
            .systemPink,
            .systemTeal,
            .systemOrange,
            .systemYellow,
            .systemOrange,
            .systemPurple
        ]
        
        let rand = Int.random(in: 0..<colors.count)
        return colors[rand]
    }
    
}
