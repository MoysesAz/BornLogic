import UIKit

class CatalogNewsCell: UICollectionViewCell {
    static let id: String = "CatalogNewsCell"
    weak var homeNavigationDelegate: HomeNavigationDelegate?

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.image = UIImage(named: "defaultImage")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Default"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.8)
        return titleLabel
    }()
    

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        buildLayout()
    }

    private func imageConstraints() {
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.heightAnchor.constraint(equalTo: heightAnchor),
            image.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }

    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}

extension CatalogNewsCell: ViewCoding {
    public func articleReload(article: Article) {
        DispatchQueue.main.async {
            self.titleLabel.text = article.title
            self.image.downloaded(from: article.urlToImage ?? "", contentMode: .scaleToFill)
        }
    }

    func setAllConstraints() {
        imageConstraints()
        titleLabelConstraints()
    }

    func setHierarchy() {
        contentView.addSubview(image)
        image.addSubview(titleLabel)
    }
}
