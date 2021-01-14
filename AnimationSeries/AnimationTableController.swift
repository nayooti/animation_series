import UIKit

class AnimationTableController: UITableViewController {
    
    weak var coordinator: AnimationTableCoordinator?

    var cells: [CellModel] = [
        CellModel(title: "Open Profile", detailText: "Non linear transformation", animationType: .openProfile)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()    
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        
        cell.textLabel?.text = cells[indexPath.row].title
        cell.detailTextLabel?.text = cells[indexPath.row].detailText
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animationType = cells[indexPath.row].animationType
        coordinator?.showAnimationController(type: animationType)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension AnimationTableController {
    
    struct CellModel {
        var title: String
        var detailText: String?
        var animationType: AnimationType
    }
    
    enum AnimationType {
        case openProfile
    }
}

