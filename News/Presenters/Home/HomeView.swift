import UIKit

protocol HomeViewProtocol {
    var tableView: UITableView {get}
}

class HomeView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.id)
        tableView.register(CatalogCell.self, forCellReuseIdentifier: CatalogCell.id)
        tableView.register(HeadlineCell.self, forCellReuseIdentifier: HeadlineCell.id)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        return tableView
    }()

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMove(toWindow newWindow: UIWindow?) {
        buildLayout()
    }
    
}

extension HomeView: HomeViewProtocol{}

extension HomeView: ViewCoding {
    func setAllConstraints() {
        tableViewConstraints()
    }

    func setHierarchy() {
        self.addSubview(tableView)
    }
    
    private func tableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.heightAnchor.constraint(equalTo: heightAnchor),
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
}
