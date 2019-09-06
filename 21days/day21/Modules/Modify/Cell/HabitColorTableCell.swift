//
//  HabitColorTableCell.swift
//  day21
//
//  Created by flion on 2019/2/27.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit
import CHIPageControl

fileprivate let kColorCountInAPage: Int = 12

class HabitColorTableCell: UITableViewCell, OMPCellable {

    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var collectViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pageControl: CHIPageControlAleppo!
    fileprivate var choosedColor: HabitColor = .color6
    
    fileprivate let layout = UICollectionViewFlowLayout().then {
        // 水平方向：左右边距20, 一行共6个cell，间距为10
        let subItemHeight = ((kScreenWidth - 24) - 8 * 5) / 6
        let itemWidth = kScreenWidth - 24
        // 垂直方向：共3行，间距10
        let itemHeight = subItemHeight * 2 + 8
        $0.itemSize = CGSize(width: itemWidth, height: itemHeight)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
    }
    
    fileprivate let habitColors: [HabitColor] = [
        .color0, .color1, .color2, .color3,
        .color4, .color5, .color6, .color7,
        .color8, .color9, .color10, .color11,
        .color12, .color13, .color14, .color15,
        .color16, .color17, .color18, .color19,
        .color20, .color21, .color22, .color23,
        .color24, .color25, .color26, .color27,
        .color28, .color29
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectView.register(UINib(nibName: "HabitSelectColorCollectCell", bundle: nil), forCellWithReuseIdentifier: "HabitSelectColorCollectCell")
        collectView.delegate = self
        collectView.dataSource = self
        collectView.collectionViewLayout = layout
        collectView.isPagingEnabled = true
        collectView.showsHorizontalScrollIndicator = false
        
        let subItemHeight = ((kScreenWidth - 24) - 8 * 5) / 6
        collectViewHeight.constant = subItemHeight * 2 + 8 * 1
        
        setupPageControl()
    }
    
    fileprivate func setupPageControl() {
        pageControl.tintColor = UIColor.lightGray
        pageControl.currentPageTintColor = UIColor.gray
        pageControl.numberOfPages = pageNumber()
    }
}

extension HabitColorTableCell: ConfigurableCell {
    func configure(with vm: HabitColorCellViewModel) {
        if choosedColor == vm.choosedColor { return }
        choosedColor = vm.choosedColor
        let index = habitColors.index(of: choosedColor) ?? 0
        let pageControlIndex = pageIndex(index: index)
        pageControl.set(progress: pageControlIndex, animated: true)
        collectView.scrollToItem(at: IndexPath(row: pageControlIndex, section: 0), at: .right, animated: false)
        collectView.reloadData()
    }
}

extension HabitColorTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  pageNumber()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "HabitSelectColorCollectCell", for: indexPath) as! HabitSelectColorCollectCell
        
        let colorTuples = habitColors.map { color -> (HabitColor, Bool) in
            let isSelect = color == self.choosedColor
            return (color, isSelect)
        }
        
        let index = indexPath.item
        if index < pageNumber()-1 {
            let sliceIndex = index * kColorCountInAPage
            let subTuples = Array(colorTuples[sliceIndex..<(sliceIndex + kColorCountInAPage)])
            cell.handleCell(colorTuples: subTuples)
        } else {
            let sliceIndex = index * kColorCountInAPage
            let restCount = colorTuples.count - sliceIndex
            let subTuples = Array(colorTuples[sliceIndex..<(sliceIndex + restCount)])
            cell.handleCell(colorTuples: subTuples)
        }
        
        cell.clickColor = { [weak self] color in
            guard let wself = self else { return }
            let colorValue = color.rawValue
            let userInfo = ["colorValue": colorValue]
            TableCellAction(key: ModifyHabitCellActions.chooseColorAction, sender: wself, userInfo: userInfo).invoke()
        }
        
        return cell
    }
}

extension HabitColorTableCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollWidth = kScreenWidth - 24
        let scrollIndex = Int(scrollView.contentOffset.x / scrollWidth)
        pageControl.set(progress: scrollIndex, animated: true)
    }
}

extension HabitColorTableCell {
    fileprivate func pageNumber() -> Int {
        if habitColors.count % kColorCountInAPage == 0 {
            return habitColors.count / kColorCountInAPage
        } else {
            return habitColors.count / kColorCountInAPage + 1
        }
    }
    
    fileprivate func pageIndex(index: Int) -> Int {
        return index / kColorCountInAPage
    }
}
