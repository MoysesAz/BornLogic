import UIKit


protocol HomeNavigationDelegate: AnyObject {
    func navigateToNextScreen(viewController: UIViewController)
}


protocol HomeScrollToRowDelegate: AnyObject {
    func scrollToRow(row: Int)
}
