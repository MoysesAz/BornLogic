import UIKit

class CatalogCell: UITableViewCell {
    static let id: String = "CatalogCell"
    weak var homeNavigationDelegate: HomeNavigationDelegate?
    
    weak var catalogViewModelDelegate: CatalogViewModelDelegate?

    var category: NewsCategory? {
        didSet {
            collectionView.reloadData()
        }
    }

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Default"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        titleLabel.backgroundColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 200, height: 170)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CatalogNewsCell.self,
                                forCellWithReuseIdentifier: CatalogNewsCell.id)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator =  false
        return collectionView
    }()

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        buildLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CatalogCell: ViewCoding {
    func setAllConstraints() {
        titleLabelConstraints()
        collectionViewConstraints()
    }

    func setHierarchy() {
        contentView.addSubview(collectionView)
        contentView.addSubview(titleLabel)
    }

    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }

    private func collectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
}

extension CatalogCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let newCategory = category else {
            return 0
        }
        return catalogViewModelDelegate?.articles(for: newCategory).count ?? 10

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogNewsCell.id, for: indexPath) as? CatalogNewsCell else {
            fatalError("The TableView could not dequeue a CustomCell in ViewController.")
        }

        guard let newCategory = category else {
            return cell
        }

        guard let articles = catalogViewModelDelegate?.articles(for: newCategory) else {
            return cell
        }

        cell.articleReload(article: articles[indexPath.row])
        
        return cell
    }
}

extension CatalogCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let newCategory = category else {
            return
        }


        guard let articles = catalogViewModelDelegate?.articles(for: newCategory) else {
            return
        }

        let viewModel = DetailsViewModel()
        viewModel.urlArticle = articles[indexPath.row].url
        let controller = DetailsController(viewModel: viewModel)
        homeNavigationDelegate?.navigateToNextScreen(viewController: controller)
        controller.contentView.reloadArticle(article: articles[indexPath.row])

    }
}
