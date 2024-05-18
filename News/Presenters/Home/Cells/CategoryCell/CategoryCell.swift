import UIKit

class CategoryCell: UITableViewCell {
    static let id: String = "CategoryCell"
    weak var homeScrollToRowDelegate: HomeScrollToRowDelegate?
    weak var viewModel: CategoryViewModelDelegate?


    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "newspaper.fill")
        logo.tintColor = .systemRed
        logo.contentMode = .scaleToFill
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 180, height: 50)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryNameCell.self, forCellWithReuseIdentifier: CategoryNameCell.id)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        buildLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CategoryCell: ViewCoding {
    func setAllConstraints() {
        logoConstraints()
        collectionViewConstraints()
    }
    
    func setHierarchy() {
        contentView.addSubview(logo)
        contentView.addSubview(collectionView)
    }

    private func logoConstraints() {
        NSLayoutConstraint.activate([
            logo.heightAnchor.constraint(equalTo: heightAnchor),
            logo.widthAnchor.constraint(equalTo: heightAnchor),
            logo.topAnchor.constraint(equalTo: topAnchor),
            logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
    }

    private func collectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 5),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
    }
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.categories.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryNameCell.id, for: indexPath) as? CategoryNameCell else {
            fatalError("The TableView could not dequeue a CustomCell in ViewController.")
        }

        cell.textLabel.text = viewModel?.categories[indexPath.row]
        return cell
    }
}

extension CategoryCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeScrollToRowDelegate?.scrollToRow(row: indexPath.row + 2)
    }
}
