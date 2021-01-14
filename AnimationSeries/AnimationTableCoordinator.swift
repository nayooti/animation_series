import UIKit

protocol AnimationTableCoordinator: class {
    func showAnimationController(type: AnimationTableController.AnimationType)
}

class AnimationTableNav: UINavigationController {
    
    init() {
        let animationTable = AnimationTableController(style: .grouped)
        super.init(rootViewController: animationTable)
        animationTable.coordinator = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnimationTableNav: AnimationTableCoordinator {
    func showAnimationController(type: AnimationTableController.AnimationType) {
        
    }

}
