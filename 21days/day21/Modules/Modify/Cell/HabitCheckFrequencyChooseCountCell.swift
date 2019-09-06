//
//  HabitCheckFrequencyChooseCountCell.swift
//  day21
//
//  Created by flion on 2019/6/19.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit
import RxSwift
import RxCocoa

class HabitCheckFrequencyChooseCountCell: UITableViewCell, OMPCellable, OMPMarginCellable {
    
    @IBOutlet weak var bgContentView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var interactView: UIView!
    @IBOutlet weak var one: UIView!
    @IBOutlet weak var two: UIView!
    @IBOutlet weak var three: UIView!
    @IBOutlet weak var four: UIView!
    @IBOutlet weak var five: UIView!
    @IBOutlet weak var six: UIView!
    @IBOutlet weak var seven: UIView!
    @IBOutlet weak var eight: UIView!
    @IBOutlet weak var nine: UIView!
    @IBOutlet weak var ten: UIView!
    
    fileprivate lazy var numberViews: [UIView] = {
        return [one, two, three, four, five, six, seven, eight, nine, ten]
    }()
    fileprivate var currentTapIndex = 1
    
    fileprivate let tapGesture = UITapGestureRecognizer()
    fileprivate let panGesture = UIPanGestureRecognizer()
    fileprivate let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
        makeSuperViewConstraints()
        
        privateInit()
        privateActions()
    }
    
}

extension HabitCheckFrequencyChooseCountCell {
    
    fileprivate func privateInit() {
        addButton.backgroundColor = kAppLightSkyBlueThemeColor
        
        interactView.layer.cornerRadius = 5
        interactView.layer.masksToBounds = true
        
        for number in numberViews {
            number.backgroundColor = kAppTableCellComponentColor
        }
    }
    
    fileprivate func privateActions() {
        
        addButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let wself = self else { return }
            let nextTapIndex: Int
            if wself.currentTapIndex >= 10 {
                nextTapIndex = wself.currentTapIndex
            } else {
                nextTapIndex = wself.currentTapIndex + 1
            }
            wself.didTapAtIndex(index: nextTapIndex)
        }).disposed(by: disposeBag)
        
        interactView.isUserInteractionEnabled = true
        
        interactView.addGestureRecognizer(panGesture)
        panGesture.rx.event.subscribe(onNext: { [weak self] pan in
            guard let wself = self else { return }
            wself.handlePan(pan: pan)
        }).disposed(by: disposeBag)
        
        interactView.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.subscribe(onNext: { [weak self] tap in
            guard let wself = self else { return }
            wself.handleTap(tap: tap)
        }).disposed(by: disposeBag)
    }
    
    fileprivate func handlePan(pan: UIPanGestureRecognizer) {
        let point = pan.location(in: interactView)
        didTapAtPosition(point: point)
    }
    
    fileprivate func handleTap(tap: UITapGestureRecognizer) {
        let point = tap.location(in: interactView)
        didTapAtPosition(point: point)
    }
    
    fileprivate func didTapAtPosition(point: CGPoint) {
        let tapAreaWidth = kScreenWidth - 10 * 2
        let oneDayTapWidth = tapAreaWidth / 10.0
        // 向上取整
        let tapCount = Int(ceil(point.x / oneDayTapWidth))
        didTapAtIndex(index: tapCount)
    }
    
    fileprivate func didTapAtIndex(index: Int) {
        let info = ["tapCount": index]
        TableCellAction(key: ModifyHabitCellActions.tapAtPointForRepeatCount, sender: self, userInfo: info).invoke()
    }
}

extension HabitCheckFrequencyChooseCountCell: ConfigurableCell {
    
    func configure(with vm: HabitFrequencyCountViewModel) {
        currentTapIndex = vm.tapIndex
        for number in numberViews {
            if number.tag <= vm.tapIndex {
                number.backgroundColor = kAppLightSkyBlueThemeColor
            } else {
                number.backgroundColor = kAppTableCellComponentColor
            }
        }
    }
}
