import UIKit

extension HomeController: UITableViewDelegate {
}

extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count + 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.id, for: indexPath) as? CategoryCell else {
                fatalError("The TableView could not dequeue a CustomCell in ViewController.")
            }
            cell.viewModel = viewModel
            cell.homeScrollToRowDelegate = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineCell.id, for: indexPath) as? HeadlineCell else {
                fatalError("The TableView could not dequeue a CustomCell in ViewController.")
            }
            cell.homeNavigationDelegate = self
            guard let article = viewModel.headlineArticle else {
                return cell
            }
            cell.urlArticle = article.url
            cell.articleReload(article: article)
            cell.article = article
            return cell
        case 2..<viewModel.categories.count + 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogCell.id,
                                                           for: indexPath) as? CatalogCell else {
                fatalError("The TableView could not dequeue a CustomCell in ViewController.")
            }
            let index = indexPath.row - 2
            cell.titleLabel.text = viewModel.categories[index]

            let category = NewsCategory.allCases[index]

            if viewModel.articles(for: category).isEmpty {
                return cell
            }
            cell.category = category
            cell.catalogViewModelDelegate = viewModel
            cell.homeNavigationDelegate = self
            return cell

        default:
            fatalError("The TableView could not dequeue a CustomCell in ViewController.")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 50
        case 1:
            return 300
        case 2..<viewModel.categories.count + 2:
            return 250
        default:
            fatalError("TableView no have index")
        }
    }
}
