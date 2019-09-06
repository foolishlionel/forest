//
//  HabitCheckViewController.swift
//  day21
//
//  Created by flion on 2019/3/7.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol HabitCheckDelegate: class {
    func comfirmCheckHabit(habit: Habit)
}

class HabitCheckViewController: UIViewController {
    
    fileprivate var habit: Habit!
    fileprivate var delegate: HabitCheckDelegate?
    
    init(habit: Habit, delegate: HabitCheckDelegate?) {
        super.init(nibName: "HabitCheckViewController", bundle: nil)
        self.habit = habit
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let tap = UITapGestureRecognizer()
    
    @IBOutlet weak var bgContent: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var canObtainLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    fileprivate let imgView = UIImageView().then {
        $0.frame = CGRect(x: 100, y: kScreenHeight - 150, width: 200, height: 100)
        $0.backgroundColor = UIColor.red
    }
    
    fileprivate let emitterLayer = CAEmitterLayer().then {
        $0.emitterPosition = CGPoint.init(x: 120, y: kScreenHeight - 150)
        $0.emitterShape = kCAEmitterLayerLine
        $0.emitterMode = kCAEmitterLayerSurface
        $0.emitterSize = CGSize.init(width: 20, height: 20)
        
        var cellArray: [CAEmitterCell] = []
        for i in 0...10 {
            let emitterCell = CAEmitterCell()
            emitterCell.birthRate = Float(0.5 + 0.1 * CGFloat(i))
            emitterCell.speed = 1.5
            emitterCell.velocity = 150
            emitterCell.velocityRange = 30
            emitterCell.lifetime = 3.5
            emitterCell.lifetimeRange = 0.5
            emitterCell.spin = 1
            emitterCell.scale = 0.8
            emitterCell.scaleRange = 0.5
            emitterCell.emissionLongitude = 0
            emitterCell.emissionLatitude = .pi / 4
            emitterCell.yAcceleration = 120
            emitterCell.contents = UIImage(named: "home_gold")?.cgImage
            cellArray.append(emitterCell)
        }
        $0.emitterCells = cellArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTapGesture()
        
        bgContent.layer.cornerRadius = 5
        bgContent.layer.masksToBounds = true
        
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true
        
        habitNameLabel.text = habit.name
        
        iconImageView.image = UIImage(named: habit.mirror.icon.stringValue)
        iconImageView.backgroundColor = habit.mirror.color.cocoaColor
        checkButton.backgroundColor = kAppSkyBlueThemeColor
        checkButton.setTitleColor(UIColor.white, for: .normal)
        checkButton.layer.cornerRadius = 5
        checkButton.layer.masksToBounds = true
        
        let currentContinuousDays = HabitModuleHelper.continuousCheckDays(whenHabit: habit)
        let obtainIntegral = CheckInMapRule.goalIntegral(forContinuousDays: currentContinuousDays+1)
        canObtainLabel.text = "已连续打卡\(currentContinuousDays)天，今日打卡可获得\(obtainIntegral)个金币"
        
        
        view.addSubview(imgView)
        view.layer.addSublayer(emitterLayer)
    }
    
    fileprivate func setupTapGesture() {
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        tap.rx.event.subscribe { [weak self] _ in
            guard let wself = self else { return }
            wself.checkHabit(confirmCheck: false)
        }.disposed(by: disposeBag)
    }
    
    @IBAction func checkButtonClicked(_ sender: Any) {
        checkHabit(confirmCheck: true)
    }
    
    fileprivate func checkHabit(confirmCheck: Bool) {
        guard let DELEGATE = self.delegate else { return }
        guard let HABIT = habit else { return }
        
        dismiss(animated: true) {
            guard confirmCheck else { return }
            DELEGATE.comfirmCheckHabit(habit: HABIT)
        }
    }
}
