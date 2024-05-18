import UIKit

class DetailsController: UIViewController {
    var viewModel: DetailsViewModelProtocol
    var contentView: DetailsViewProtocol

    init(contentView: some DetailsViewProtocol = DetailsView(),
         viewModel: some DetailsViewModelProtocol = DetailsViewModel()) {
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
        contentView.detailsEventDelegate = viewModel
    }
}


