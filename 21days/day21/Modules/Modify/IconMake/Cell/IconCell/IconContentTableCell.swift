//
//  IconContentTableCell.swift
//  day21
//
//  Created by flion on 2019/6/28.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

fileprivate let kHorItemCount: Int = 5
fileprivate let kVerItemCount: Int = 3

typealias ClickMirrorBlock = (HabitMirror) -> Void

class IconContentTableCell: UITableViewCell, OMPCellReuseIdentify, OMPCellable {

    @IBOutlet weak var collectV: UICollectionView!
    
    fileprivate var flattedMirrors: [HabitMirror] = []
    fileprivate var clickMirrorBlock: ClickMirrorBlock?
    @IBOutlet weak var collectVHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let totalWidth = kScreenWidth - 15 * 2
        let itemWidth: CGFloat = totalWidth / 7.0
        let itemHeight = itemWidth
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectV.collectionViewLayout = layout
        collectV.backgroundColor = UIColor.red
        collectV.register(UINib(nibName: "MakeIconCollectCell", bundle: nil), forCellWithReuseIdentifier: MakeIconCollectCell.cellReuseIdentifier)
        collectV.delegate = self
        collectV.dataSource = self
        collectV.isPagingEnabled = true
        collectV.showsHorizontalScrollIndicator = false
        
        collectVHeight.constant = itemHeight * 3.01
    }

    func handleCell(doubleLevelMirrors: [[HabitMirror]], clickMirrorBlock: @escaping ClickMirrorBlock) {
        
        self.clickMirrorBlock = clickMirrorBlock
        
        var tempDoubleLevels = doubleLevelMirrors
        
        for (index, insideMirrors) in doubleLevelMirrors.enumerated() {
            var tempInsides = insideMirrors
            if insideMirrors.count % 3 == 1 {
                let supplyMirrors = [HabitMirror(icon: .apple, color: .color0, category: .other), HabitMirror(icon: .apple, color: .color0, category: .other)]
                tempInsides.append(contentsOf: supplyMirrors)
            } else if insideMirrors.count % 3 == 2 {
                let supplyMirror = HabitMirror(icon: .apple, color: .color0, category: .other)
                tempInsides.append(supplyMirror)
            }
            tempDoubleLevels[index] = tempInsides
        }
        
        let flatMirrors = tempDoubleLevels.flatMap { $0 }
        flattedMirrors.append(contentsOf: flatMirrors)
        collectV.reloadData()
    }
}


extension IconContentTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mirror = flattedMirrors[indexPath.item]
        guard mirror.category != .empty else { return }
        guard let block = clickMirrorBlock else { return }
        block(mirror)
    }
}

extension IconContentTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flattedMirrors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeIconCollectCell.cellReuseIdentifier, for: indexPath) as! MakeIconCollectCell
        
        let mirror = flattedMirrors[indexPath.item]
        cell.handleCell(mirror: mirror)
        return cell
    }
}
