//
//  CategoryContentTableCell.swift
//  day21
//
//  Created by flion on 2019/6/28.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

typealias ClickCategoryBlock = (Int) -> Void

class CategoryContentTableCell: UITableViewCell, OMPCellReuseIdentify, OMPCellable {

    fileprivate var selectIndex: Int = 0 {
        didSet { collectV.reloadData() }
    }
    
    @IBOutlet weak var collectV: UICollectionView!
    
    fileprivate var categories: [HabitCategory] = []
    fileprivate var clickCategory: ClickCategoryBlock? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
        collectV.register(UINib(nibName: "IconCategoryCell", bundle: nil), forCellWithReuseIdentifier: IconCategoryCell.cellReuseIdentifier)
        collectV.isScrollEnabled = false
        collectV.delegate = self
        collectV.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth: CGFloat = (kScreenWidth - 15.0 * 2) / 6.0
        let itemHeight: CGFloat = 30.0
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectV.collectionViewLayout = layout
    }

    func handleCell(doubleLevelMirrors: [[HabitMirror]], clickCategoryBlock: ClickCategoryBlock? = nil) {
        
        clickCategory = clickCategoryBlock
        
        let types = doubleLevelMirrors.map { $0.first!.category }
        categories.append(contentsOf: types)
        selectIndex = 0
        collectV.reloadData()
    }
}

extension CategoryContentTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectIndex = indexPath.item
        
        if let block = clickCategory {
            block(indexPath.item)
        }
    }
}

extension CategoryContentTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCategoryCell.cellReuseIdentifier, for: indexPath) as! IconCategoryCell
        let type = categories[indexPath.item]
        cell.nameLabel.text = type.chName
        
        let cellIndex = indexPath.item
        if selectIndex == cellIndex {
            cell.nameLabel.textColor = UIColor.orange
        } else {
            cell.nameLabel.textColor = UIColor.darkText
        }
        
        return cell
    }
}
