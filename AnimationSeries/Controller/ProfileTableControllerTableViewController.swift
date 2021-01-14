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
}


class ProfileCell: UITableViewCell {
    static let defaultHeight: CGFloat = 85
    
    lazy var profileImage: CircleView = {
        let view = CircleView()
        view.backgroundColor = UIColor.randomSystemColor
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
        [profileImage].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    
}



