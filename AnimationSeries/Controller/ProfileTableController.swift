import UIKit

class ProfileTableController: UITableViewController {
    
    let transitionAnimator = ProfileOpenAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profiles"
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.rowHeight = ProfileCell.defaultHeight
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.description())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.description(), for: indexPath) as! ProfileCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let profileCell = tableView.cellForRow(at: indexPath) as! ProfileCell
        let cellRect = tableView.rectForRow(at: indexPath)
        let cellRectInView = tableView.convert(cellRect, to: view)
        
        let profileDetailController = ProfileDetailViewController()
        profileDetailController.transitioningDelegate = self
        let originFrame = profileCell.contentView.frame
        let convertedFrame = profileCell.convert(profileCell.frame, to: tableView) //tableView.convert(originFrame, to: tableView.superview!)
        print(originFrame)
        print(convertedFrame)
        transitionAnimator.presenting = true
    
        transitionAnimator.originFrame = cellRectInView //CGRect(x: 30, y: 300, width: view.frame.width, height: ProfileCell.defaultHeight)
        self.present(profileDetailController, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ProfileTableController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}


class ProfileCell: UITableViewCell {
    static let defaultHeight: CGFloat = 85
    
    lazy var profileImage: RoundedRectView = {
        let view = RoundedRectView()
        view.backgroundColor = UIColor.systemBlue
        return view
    }()
    
    lazy var cirlce: CircleView = {
        let view = CircleView()
        view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.25)
        return view
    }()
    
    lazy var titleBar: RoundedRectView = {
        let view = RoundedRectView()
        view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.25)
        return view
    }()
    
    lazy var detailBar: RoundedRectView = {
        let view = RoundedRectView()
        view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.25)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        [profileImage, cirlce, titleBar, detailBar].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        cirlce.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 15).isActive = true
        cirlce.topAnchor.constraint(equalTo: profileImage.topAnchor).isActive = true
        cirlce.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cirlce.widthAnchor.constraint(equalTo: cirlce.heightAnchor).isActive = true
        
        titleBar.leadingAnchor.constraint(equalTo: cirlce.trailingAnchor, constant: 15).isActive = true
        titleBar.topAnchor.constraint(equalTo: cirlce.topAnchor).isActive = true
        titleBar.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        titleBar.heightAnchor.constraint(equalTo: cirlce.heightAnchor).isActive = true
        
        detailBar.leadingAnchor.constraint(equalTo: cirlce.leadingAnchor).isActive = true
        detailBar.topAnchor.constraint(equalTo: titleBar.bottomAnchor, constant: 8).isActive = true
        detailBar.trailingAnchor.constraint(equalTo: titleBar.trailingAnchor).isActive = true
        detailBar.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor).isActive = true
        
    }
}

class ProfileOpenAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 3.0
    var presenting = true
    var originFrame = CGRect.zero
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        let profileView = presenting ? toView : transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : profileView.frame
        let finalFrame = presenting ? profileView.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        if presenting {
            profileView.transform = scaleTransform
            profileView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            profileView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(profileView)
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.0,
            animations: {
                profileView.transform = self.presenting ?
                    CGAffineTransform.identity : scaleTransform
                profileView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            }, completion: {_ in
                transitionContext.completeTransition(true)
            })
        
//        containerView.addSubview(toView)
//        toView.alpha = 0
//        UIView.animate(withDuration: duration, animations: {
//            toView.alpha = 1.0
//        }, completion: { _ in
//            transitionContext.completeTransition(true)
//        })
    }
}

class ProfileDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .green
    }
}



