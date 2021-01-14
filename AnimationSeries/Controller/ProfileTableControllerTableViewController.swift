import UIKit

class ProfileTableController: UITableViewController {

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
        tableView.deselectRow(at: indexPath, animated: false)
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





