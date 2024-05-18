import UIKit

extension HomeController: HomeNavigationDelegate {
    func navigateToNextScreen(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeController: HomeScrollToRowDelegate {
    func scrollToRow(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        self.contentView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
