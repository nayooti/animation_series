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
    func showAnimationController(type animationType: AnimationTableController.AnimationType) {
        
        var modalVC: UIViewController
        switch animationType {
        case .openProfile:
            modalVC = ProfileTableController()
        }
  
        let nav = UINavigationController(rootViewController: modalVC)
        modalVC.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close, target: self, action: #selector(closeButtonPressed(_:))
        )
        nav.modalPresentationStyle = .fullScreen
        topViewController?.present(nav, animated: true, completion: nil)
    }
    
    @objc private func closeButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
