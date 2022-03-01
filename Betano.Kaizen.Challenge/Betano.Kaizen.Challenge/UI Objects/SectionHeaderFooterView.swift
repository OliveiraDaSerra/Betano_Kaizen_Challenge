//
//  SectionHeaderFooterView.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation
import UIKit
import SnapKit

class BaseUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configure() {
        
    }
}

class SectionHeaderFooterView: UITableViewHeaderFooterView {

    private lazy var titleLabel: UILabel = {
        var lbl = configureElement(UILabel()) {
            $0.backgroundColor = .clear
        }
        return lbl
    }()

    private lazy var accessoryImage: UIImageView = {
        var iv = configureElement(UIImageView()) {
            $0.backgroundColor = .clear
            $0.contentMode = .scaleAspectFit
        }
        return iv
    }()

    private lazy var actionButton: UIButton = {
        var btn = configureElement(UIButton()) {
            $0.backgroundColor = .clear
            $0.addTarget(self, action: #selector(onActionButtonPressed(_:)), for: .touchUpInside)
            $0.isEnabled = true
        }
        return btn
    }()

    private var viewModelSection: ViewModelSection?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupUI()
    }

    private func setupUI() {
        isUserInteractionEnabled = true
        setBackgroundColor(.clear)

        // ACCESSORY IMAGE
        if accessoryImage.superview == nil { contentView.addSubview(accessoryImage) }
        accessoryImage.snp.removeConstraints()
        accessoryImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-20.0)
            make.width.height.equalTo(20.0)
        }

        // LABEL
        if titleLabel.superview == nil { contentView.addSubview(titleLabel) }
        titleLabel.snp.removeConstraints()
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20.0)
            make.trailing.equalTo(accessoryImage.snp.leading)
        }

        // BUTTON
        if actionButton.superview == nil { contentView.addSubview(actionButton) }
        actionButton.snp.removeConstraints()
        actionButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setBackgroundColor(_ bgColor: UIColor) {
        contentView.backgroundColor = bgColor
    }
    
    func update(with viewModelSection: ViewModelSection?) {
        self.viewModelSection = viewModelSection
        guard let viewModelSection = viewModelSection else { return }
        titleLabel.text = viewModelSection.titleData?.headerData?.title
        accessoryImage.image = UIImage(systemName: "chevron.\(viewModelSection.expanded ? "up" : "down")")
    }

    @objc private func onActionButtonPressed(_ button: UIButton) {
        guard let handler = viewModelSection?.handler else { return }
        handler(viewModelSection?.key, nil)
    }
}
