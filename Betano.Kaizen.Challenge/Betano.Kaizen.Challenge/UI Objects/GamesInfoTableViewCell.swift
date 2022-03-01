//
//  GamesInfoTableViewCell.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation
import UIKit
import SnapKit

//class GamesInfoTableViewCell: UITableViewCell, ReusableView {
class GamesInfoTableViewCell: UITableViewCell {

    // MARK: - Properties

    private var collectionView: UICollectionView!
    private var collectionViewFlowLayout: UICollectionViewLayout?
    private var fields: [FieldBase]?

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setupUI()
    }

    private func commonInit() {
        setupUI()
    }

    private func setupUI() {
        // > Content View Config
        contentView.backgroundColor = .white
    }

    private func setupCollectionView(collectionViewLayout: UICollectionViewLayout?) {
        guard let collectionViewLayout = collectionViewLayout else { return }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()

        if collectionView?.superview == nil { contentView.addSubview(collectionView) }

        collectionView.snp.removeConstraints()
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func registerCells() {
        collectionView.registerNoNibCell(GameInfoCollectionViewCell.self)
    }

    func update(with fields: [FieldBase]?,
                collectionViewLayout: UICollectionViewLayout?) {
        // Properties Values Update
        self.fields = fields
        self.collectionViewFlowLayout = collectionViewLayout

        // Apply the CollectionView setup
        setupCollectionView(collectionViewLayout: collectionViewFlowLayout)

        // It RELOADS the data
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView DATASOURCE Methods

extension GamesInfoTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let fields = fields else { return 0 }
        return fields.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fields = fields,
              let elem = fields[indexPath.row],
              let cell = dequeueCell(on: collectionView, indexPath: indexPath) as? GameInfoCollectionViewCell else { return UICollectionViewCell() }
        cell.update(with: elem)
        return cell
    }
    
    // MARK: - Support Methods
    private func dequeueCell(on collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: GameInfoCollectionViewCell.typeName,
                                                  for: indexPath)
    }
}

// MARK: - UICollectionView DELEGATE Methods

extension GamesInfoTableViewCell: UICollectionViewDelegate {
    
}
