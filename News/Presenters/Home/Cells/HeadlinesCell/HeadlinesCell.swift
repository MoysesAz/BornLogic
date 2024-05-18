import UIKit

class HeadlineCell: UITableViewCell {
    static let id: String = "HeadlineCell"
    weak var homeNavigationDelegate: HomeNavigationDelegate?
    var urlArticle: String?
    var article: Article?

    lazy var imageBackground: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.image = UIImage(named: "defaultImage")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGesture)
        return image
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Default"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.8)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.text = "Default"
        authorLabel.font = UIFont.systemFont(ofSize: 8, weight: .bold)
        authorLabel.textAlignment = .right
        authorLabel.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        return authorLabel
    }()

    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Default"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.4)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        buildLayout()
    }
}

extension HeadlineCell: ViewCoding {
    func setAllConstraints() {
        imageConstraints()
        titleLabelConstraints()
        authorLabelConstraints()
        descriptionLabelConstraints()
    }

    func setHierarchy() {
        contentView.addSubview(imageBackground)
        imageBackground.addSubview(titleLabel)
        imageBackground.addSubview(authorLabel)
        imageBackground.addSubview(descriptionLabel)
    }

    private func imageConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageBackground.heightAnchor.constraint(equalTo: heightAnchor),
            imageBackground.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageBackground.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -10),
        ])
    }

    private func authorLabelConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.bottomAnchor.constraint(equalTo: imageBackground.bottomAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: 0),
            authorLabel.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor, constant: 0),
        ])
    }

    private func descriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -5),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -20),
        ])
    }
}

extension HeadlineCell {
    public func articleReload(article: Article) {
        DispatchQueue.main.async {
            self.titleLabel.text = article.title
            self.authorLabel.text = article.author ?? "Default Author"
            self.descriptionLabel.text = article.description ?? "Default Description"
            self.imageBackground.downloaded(from: article.urlToImage ?? "", contentMode: .scaleToFill)
        }
    }

    @objc func imageTapped() {
        let viewModel = DetailsViewModel()
        viewModel.urlArticle = urlArticle
        let controller = DetailsController(viewModel: viewModel)
        homeNavigationDelegate?.navigateToNextScreen(viewController: controller)
        controller.contentView.reloadArticle(article: article!)
    }
}
