//
//  TopicCell.swift
//  WhatsNewJourneyTestApp
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import SnapKit
import BackbaseDesignSystem
import Resolver

final class TopicCell: UITableViewCell, Reusable {
    
    @LazyInjected
    private var configuration: WhatsNew.Configuration
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        backgroundColor = .clear
        selectionStyle = .none
        layoutMargins = UIEdgeInsets.zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for topic: Topic) {
        let row = configuration.topics.topicsRowProvider(topic)
        addAccessiblityIdentifiers(topicId: "\(row.id)")
        setup(titleLabel, with: row.title)
        setup(descriptionLabel, with: row.description)
        setupIcon(iconView, with: row.icon)
        addSubviews()
        layoutViews()
        
    }
    
    // MARK: - Private
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var iconView: IconView = {
        let iconView = IconView()
        let paddingValue = DesignSystem.shared.sizer.sm
        iconView.padding = UIEdgeInsets(top: paddingValue, left: paddingValue, bottom: paddingValue, right: paddingValue)
        return iconView
    }()
    
    private func addAccessiblityIdentifiers(topicId: String?) {
        guard let topicId = topicId else {
            return
        }
        accessibilityIdentifier = "TopicCell_\(topicId)"
        titleLabel.accessibilityIdentifier = "TopicTitle_\(topicId)"
        descriptionLabel.accessibilityIdentifier = "TopicDescription_\(topicId)"
        iconView.accessibilityIdentifier = "TopicIconView_\(topicId)"
    }
    
    private func addSubviews () {
        contentView.subviews.forEach {$0.removeFromSuperview()}
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(iconView)
    }
    private func layoutViews() {
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().inset(DesignSystem.shared.spacer.md)
            make.height.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(DesignSystem.shared.spacer.md)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(DesignSystem.shared.spacer.md)
            make.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(DesignSystem.shared.spacer.xs)
            make.bottom.lessThanOrEqualToSuperview().inset(DesignSystem.shared.spacer.md)
        }
    }
    
    private func setup(_ label: UILabel, with styleableText: TopicRowItem.StyleableText?) {
        guard let styleableText = styleableText else {
            label.isHidden = true
            return
        }
        
        label.isHidden = false
        
        switch styleableText {
        case let .text(text, textStyle):
            label.text = text
            textStyle?(label)
        }
    }
    
    private func setupIcon(_ iconView: IconView, with styleableIcon: TopicRowItem.StyleableIcon?) {
        guard let styleableIcon = styleableIcon else {
            iconView.isHidden = true
            return
        }
        iconView.isHidden = false
        
        switch styleableIcon {
        case let .icon(icon, iconViewStyle):
            if let img = UIImage.named(icon, in: .design) {
                iconView.image = img
                iconViewStyle?(iconView)
            } else {
                iconView.image = UIImage.named(DesignSystem.Assets.icAssignment, in: .design)
                iconViewStyle?(iconView)
            }
        }
        
    }
    
}
