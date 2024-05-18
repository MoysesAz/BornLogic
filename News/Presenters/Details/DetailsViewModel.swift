import UIKit

protocol DetailsViewModelProtocol: DetailsEventDelegate {
}

class DetailsViewModel: DetailsViewModelProtocol {
    var urlArticle: String?
}

extension DetailsViewModel: DetailsEventDelegate {
    func buttonUrlEvent() {
        if let url = URL(string: urlArticle ?? "") {
            UIApplication.shared.open(url)
        }
    }
    

}

