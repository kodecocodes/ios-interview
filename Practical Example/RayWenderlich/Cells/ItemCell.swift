//
//  ItemCell.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    static let reuseID = "ItemCell"
    
    var artworkImageView = RWImageView(frame: .zero)
    var titleLabel = RWLabel(textAlignment: .left, fontSize: 20, weight: .bold, textColor: .label)
    var technologyLabel = RWLabel(textAlignment: .left, fontSize: 14, weight: .light, textColor: .secondaryLabel)
    var descriptionLabel = RWLabel(textAlignment: .left, fontSize: 14, weight: .regular, textColor: .secondaryLabel)
    var footerLabel = RWLabel(textAlignment: .left, fontSize: 14, weight: .light, textColor: .secondaryLabel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setLibraryCell(with item: Item) {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 5
        
        artworkImageView.downloadImage(from: item.attributes.cardArtworkUrl)
        titleLabel.text = item.attributes.name
        titleLabel.numberOfLines = 2
        
        technologyLabel.text = item.attributes.technologyTripleString
        descriptionLabel.text = item.attributes.descriptionPlainText
        descriptionLabel.numberOfLines = 2
        
        footerLabel.text = "\(item.attributes.releasedAt.convertToDate()!.convertToMonthDayYearFormat()) • \(item.attributes.contentType.localizedCapitalized) \(item.attributes.duration.convertToDuration())"
    }
    
    func setPersistedCell(with item: Item) {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 5
        
        artworkImageView.downloadImage(from: item.attributes.cardArtworkUrl)
        titleLabel.text = item.attributes.name
        titleLabel.numberOfLines = 2
        
        technologyLabel.text = item.attributes.technologyTripleString
        descriptionLabel.text = item.attributes.descriptionPlainText
        descriptionLabel.numberOfLines = 2
        
        footerLabel.text = "\(item.attributes.releasedAt.convertToDate()!.convertToMonthDayYearFormat()) • \(item.attributes.contentType.localizedCapitalized) \(item.attributes.duration.convertToDuration())"
    }
    
    private func configure() {
        contentView.addSubviews(
            artworkImageView,
            titleLabel,
            technologyLabel,
            descriptionLabel,
            footerLabel
        )
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            artworkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            artworkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            artworkImageView.widthAnchor.constraint(equalToConstant: 50),
            artworkImageView.heightAnchor.constraint(equalTo: artworkImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: artworkImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 52),

            technologyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            technologyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            technologyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            technologyLabel.heightAnchor.constraint(equalToConstant: 18),

            descriptionLabel.topAnchor.constraint(equalTo: technologyLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: artworkImageView.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 18),

            footerLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            footerLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            footerLabel.trailingAnchor.constraint(equalTo: artworkImageView.trailingAnchor),
            footerLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        descriptionLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - (contentView.layoutMargins.left * 2)
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}


