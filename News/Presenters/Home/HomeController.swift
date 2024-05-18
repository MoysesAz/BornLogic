import UIKit
import Combine

class HomeController: UIViewController {
    var viewModel: HomeViewModelProtocol
    var contentView: HomeViewProtocol
    var cancellables = Set<AnyCancellable>()


    init(contentView: some HomeViewProtocol = HomeView(),
         viewModel: some HomeViewModelProtocol = HomeViewModel()) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        guard let homeView = contentView as? UIView else {
            return
        }
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        bindAll()
    }
}
