//
//  ColorContentTableCell.swift
//  day21
//
//  Created by flion on 2019/6/28.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import CHIPageControl

fileprivate let kColorCountInAPage: Int = 12

class ColorContentTableCell: UITableViewCell, OMPCellReuseIdentify, OMPCellable {
    
    var clickColorBlock: ClickColorBlock?
    
    @IBOutlet weak var collectV: UICollectionView!
    @IBOutlet weak var pageControl: CHIPageControlAleppo!
    
    fileprivate let habitColors: [HabitColor] = [
        .color0, .color1, .color2, .color3,
        .color4, .color5, .color6, .color7,
        .color8, .color9, .color10, .color11,
        .color12, .color13, .color14, .color15,
        .color16, .color17, .color18, .color19,
        .color20, .color21, .color22, .color23,
        .color24, .color25, .color26, .color27,
        .color28, .color29, .color9, .color14,
        .color23, .color8, .color11, .color3
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
        
        setupCollectV()
        setupPageControl()
    }

    fileprivate func setupCollectV() {
        collectV.register(UINib(nibName: "MakeColorCollectCell", bundle: nil), forCellWithReuseIdentifier: MakeColorCollectCell.cellReuseIdentifier)
        collectV.delegate = self
        collectV.dataSource = self
        collectV.isPagingEnabled = true
        collectV.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let itemWidth: CGFloat = (kScreenWidth - 30.0) / 6.01
        let itemHeight: CGFloat = 114.5 / 2.0
        layout.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
        collectV.collectionViewLayout = layout
        
    }
    
    
    fileprivate func setupPageControl() {
        pageControl.tintColor = UIColor.lightGray
        pageControl.currentPageTintColor = UIColor.gray
        pageControl.numberOfPages = pageNumber()
        pageControl.radius = 4
    }
}

extension ColorContentTableCell {
    fileprivate func pageNumber() -> Int {
        if habitColors.count % kColorCountInAPage == 0 {
            return habitColors.count / kColorCountInAPage
        } else {
            return habitColors.count / kColorCountInAPage + 1
        }
    }
}

extension ColorContentTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let block = clickColorBlock else { return }
        let color = habitColors[indexPath.item]
        block(color)
    }
}

extension ColorContentTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeColorCollectCell.cellReuseIdentifier, for: indexPath) as! MakeColorCollectCell
        
        let color = habitColors[indexPath.item]
        cell.handleCell(color: color)
        
        if indexPath.item % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.blue
        } else {
            if indexPath.item % 3 == 0 {
                cell.contentView.backgroundColor = UIColor.green
            } else {
                cell.contentView.backgroundColor = UIColor.red
            }
        }
        
        return cell
    }
}

extension ColorContentTableCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollWidth = kScreenWidth - 15.0 * 2
        
        let multiValue = scrollView.contentOffset.x / scrollWidth
        let scrollIndex: Int
        if abs(ceil(multiValue) - multiValue) < 0.1 {
            scrollIndex = Int(ceil(multiValue))
        } else {
            scrollIndex = Int(multiValue)
        }
        
        pageControl.set(progress: scrollIndex, animated: true)
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let scrollWidth = kScreenWidth - 15.0 * 2
//
//        let multiValue = scrollView.contentOffset.x / scrollWidth
//        let scrollIndex: Int
//        if abs(ceil(multiValue) - multiValue) < 0.1 {
//            scrollIndex = Int(ceil(multiValue))
//        } else {
//            scrollIndex = Int(multiValue)
//        }
//
//        pageControl.set(progress: scrollIndex, animated: true)
//    }
}
