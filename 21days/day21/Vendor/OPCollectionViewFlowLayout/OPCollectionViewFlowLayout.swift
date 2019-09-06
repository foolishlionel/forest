//
//  OPCollectionViewFlowLayout.swift
//  day21
//
//  Created by flionel on 2019/2/19.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class OPCollectionViewFlowLayout: UICollectionViewFlowLayout {
    /// 一页展示行数
    var row: Int = 0
    /// 一页展示列数
    var column: Int = 0
    /// 行间距
    var rowSpacing: CGFloat = 0.0
    /// 列间距
    var columnSpacing: CGFloat = 0.0
    /// item大小
    var size: CGSize = .zero
    /// 一页的宽度
    var pageWidth: CGFloat = 0.0
    
    fileprivate var attriutesArray: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        super.prepare()
        
        if pageWidth == 0 {
            pageWidth = kScreenWidth
        }
        
        self.itemSize = size
        self.minimumLineSpacing = rowSpacing
        self.minimumInteritemSpacing = columnSpacing
        let count  = collectionView?.numberOfItems(inSection: 0) ?? 0
        for i in 0..<count {
            let indexPath = IndexPath.init(item: i, section: 0)
            let attriutes = layoutAttributesForItem(at: indexPath)
            attriutesArray.append(attriutes!)
        }
        
    }
    
    
    /// 返回搜有item的frame
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attriutesArray
    }
    
    /// 计算每个item的frame
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let index = indexPath.item
        let page = index / (row * column)
        // % 运算，确定x是0, 1, 2, 3...column-1
        let x: CGFloat = CGFloat(index % column) * (size.width + columnSpacing) + CGFloat(page) * pageWidth
        // / 运算，确定y是在哪一行，一行有column个，%确定在0, 1, 2...row-1行内的哪一行
        let y: CGFloat = CGFloat(index / column % row) * (size.height + rowSpacing)
        attribute.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
        return attribute
        
    }
    
    /// 返回总的可见尺寸
    /// 避免一页未排满，滑动显示不全
    fileprivate func collectionViewContentSize() -> CGSize {
        let width = ceil(CGFloat(attriutesArray.count) / (CGFloat(row) * CGFloat(column))) * pageWidth
        return CGSize.init(width: width, height: 0)
    }
}
