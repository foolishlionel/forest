//
//  HabitCheckRangeCell.swift
//  day21
//
//  Created by flion on 2019/2/13.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

fileprivate let kHabitCheckRangeCollectCellReuseId = "kHabitCheckRangeCollectCellReuseId"

class HabitCheckRangeCell: UITableViewCell, OMPCellable {
    
    @IBOutlet weak var checkTimeRangeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    fileprivate var checkRange: HabitCheckTimeRange = .anyTime
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
        initCollectionView()
    }

    fileprivate func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HabitCheckRangeCollectCell", bundle: nil), forCellWithReuseIdentifier: kHabitCheckRangeCollectCellReuseId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 65, height: 65)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 3
        
        collectionView.collectionViewLayout = layout
    }
    
    
    
}

extension HabitCheckRangeCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectIndex = indexPath.item
        let userInfo = ["selectIndex": selectIndex]
        TableCellAction(key: ModifyHabitCellActions.chooseCheckRangeAction, sender: self, userInfo: userInfo).invoke()
    }
}


extension HabitCheckRangeCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHabitCheckRangeCollectCellReuseId, for: indexPath) as? HabitCheckRangeCollectCell
        cell?.handleCell(currentIndex: indexPath.item, selectIndex: checkRange.rawValue)
        return cell!
    }
}

extension HabitCheckRangeCell: ConfigurableCell {
    func configure(with vm: HabitCheckRangeCellViewModel) {
        checkRange = vm.checkRange
        handleCheckTimeLabel(range: vm.checkRange)
        collectionView.reloadData()
    }
    
    fileprivate func handleCheckTimeLabel(range: HabitCheckTimeRange) {
        let timeRangeString: String
        switch range {
        case .morning:
            timeRangeString = "08:00 ~ 10:00"
        case .afternoon:
            timeRangeString = "12:00 ~ 18:00"
        case .evening:
            timeRangeString = "17:00 ~ 21:00"
        default:
            timeRangeString = "任意时间"
        }
        checkTimeRangeLabel.text = timeRangeString
    }
}
