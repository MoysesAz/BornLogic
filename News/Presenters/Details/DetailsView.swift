import UIKit

protocol DetailsViewProtocol {
    var detailsEventDelegate: DetailsEventDelegate? {get set}

    func reloadArticle(article: Article)
}


protocol DetailsEventDelegate: AnyObject {
    func buttonUrlEvent()
}

class DetailsView: UIView {
    weak var detailsEventDelegate: DetailsEventDelegate?

    lazy var imageBackground: UIImageView = {
        let imageBackground = UIImageView()
        imageBackground.image = UIImage(named: "policia")
        imageBackground.contentMode = .scaleAspectFill
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        return imageBackground
    }()

    lazy var blurEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()

    lazy var featuredImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "policia")
        image.backgroundColor = .clear
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var dataLabel: UILabel = {
        let dataLabel = UILabel()
        dataLabel.text = "Default"
        dataLabel.textAlignment = .right
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        return dataLabel
    }()

    lazy var newsLabel: UILabel = {
        let newsLabel = UILabel()
        newsLabel.text = "Default"
        newsLabel.textAlignment = .left
        newsLabel.font = UIFont.preferredFont(forTextStyle: .body)
        newsLabel.numberOfLines = 0
        newsLabel.lineBreakMode = .byWordWrapping
        newsLabel.contentMode = .top
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        return newsLabel
    }()

    lazy var buttonUrl: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Read the full article", for: .normal)
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(buttonUrlEvent), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMove(toWindow newWindow: UIWindow?) {
        buildLayout()
    }
}


extension DetailsView: ViewCoding {
    func setAllConstraints() {
        imageBackgroundConstraints()
        blurEffectConstraints()
        featuredImageConstraints()
        dataLabelConstraints()
        newsLabelConstraints()
        buttonUrlConstraints()
    }
    
    func setHierarchy() {
        addSubview(imageBackground)
        addSubview(blurEffect)
        addSubview(featuredImage)
        addSubview(dataLabel)
        addSubview(newsLabel)
        addSubview(buttonUrl)
    }

    private func imageBackgroundConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageBackground.heightAnchor.constraint(equalTo: heightAnchor),
            imageBackground.widthAnchor.constraint(equalTo: widthAnchor),
            imageBackground.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    private func blurEffectConstraints() {
        NSLayoutConstraint.activate([
            blurEffect.centerXAnchor.constraint(equalTo: centerXAnchor),
            blurEffect.heightAnchor.constraint(equalTo: heightAnchor),
            blurEffect.widthAnchor.constraint(equalTo: widthAnchor),
            blurEffect.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    private func featuredImageConstraints() {
        NSLayoutConstraint.activate([
            featuredImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            featuredImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            featuredImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            featuredImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        ])
    }

    private func dataLabelConstraints() {
        NSLayoutConstraint.activate([
            dataLabel.topAnchor.constraint(equalTo: featuredImage.bottomAnchor),
            dataLabel.leadingAnchor.constraint(equalTo: featuredImage.leadingAnchor),
            dataLabel.trailingAnchor.constraint(equalTo: featuredImage.trailingAnchor),
        ])
    }

    private func newsLabelConstraints() {
        NSLayoutConstraint.activate([
            newsLabel.topAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 10),
            newsLabel.leadingAnchor.constraint(equalTo: dataLabel.leadingAnchor),
            newsLabel.trailingAnchor.constraint(equalTo: dataLabel.trailingAnchor),
        ])
    }


    private func buttonUrlConstraints() {
        NSLayoutConstraint.activate([
            buttonUrl.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonUrl.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            buttonUrl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            buttonUrl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
        ])
    }

}

extension DetailsView {
    @objc func buttonUrlEvent(_ sender: UIButton) {
        detailsEventDelegate?.buttonUrlEvent()
    }
}

extension DetailsView: DetailsViewProtocol{

    func reloadArticle(article: Article) {
        DispatchQueue.main.async {
            self.imageBackground.downloaded(from: article.urlToImage ?? "", contentMode: .scaleAspectFill)
            self.featuredImage.downloaded(from: article.urlToImage ?? "", contentMode: .scaleToFill)
            self.newsLabel.text = article.content
            self.dataLabel.text = article.publishedAt
        }
    }
}
