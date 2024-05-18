import UIKit

class CategoryNameCell: UICollectionViewCell {
    static let id: String = "CategoryNameCell"

    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Default"
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)

        textLabel.textAlignment = .center
        return textLabel
    }()

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        corners()
        buildLayout()
    }

    private func textLabelConstraints() {
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.heightAnchor.constraint(equalTo: heightAnchor),
            textLabel.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    private func corners() {
        contentView.layer.cornerRadius = 8.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.masksToBounds = true
    }
}

extension CategoryNameCell: ViewCoding {
    func setAllConstraints() {
        textLabelConstraints()
    }
    
    func setHierarchy() {
        addSubview(textLabel)
    }
}
