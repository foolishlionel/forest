//
//  SettingViewController.swift
//  day21
//
//  Created by flion on 2018/10/13.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class SettingViewController: UIViewController {

    fileprivate let imgView = UIImageView().then {
        $0.frame = CGRect(x: 100, y: 150, width: 200, height: 100)
        $0.backgroundColor = UIColor.red
    }
    
    fileprivate let overlapLayer = CAEmitterLayer().then {
        
        //指定发射源的位置
        $0.emitterPosition = CGPoint.init(x: kScreenWidth / 2.0, y: -10)
        //指定发射源的大小
        $0.emitterSize  = CGSize.init(width: kScreenWidth, height: 0)
        //指定发射源的形状和模式
        $0.emitterShape = kCAEmitterLayerLine;
        $0.emitterMode  = kCAEmitterLayerOutline;
        
        let overlapCell = CAEmitterCell.init()
        
        //每秒多少个
        overlapCell.birthRate = 3.0;
        //存活时间
        overlapCell.lifetime = 2;
        //初速度，因为动画属于落体效果，所以我们只需要设置它在y方向上的加速度就行了。
        overlapCell.velocity = 10;
        //初速度范围
        overlapCell.velocityRange = 5;
        //y轴方向的加速度
        overlapCell.yAcceleration = 30;
        //以锥形分布开的发射角度。角度用弧度制。粒子均匀分布在这个锥形范围内。
        overlapCell.emissionRange = 5;
        //设置降落的图片
        overlapCell.contents  = UIImage(named: "home_gold1")?.cgImage
        //图片缩放比例
        overlapCell.scale = 0.5;
        //开始动画
        $0.emitterCells = [overlapCell]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.addSubview(imgView)
//        imgView.layer.addSublayer(overlapLayer)
        overlapLayer.frame = view.frame
        view.layer.addSublayer(overlapLayer)
        
        overlapAnimation()
        
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://free-api.heweather.net/s6/air/now?location=CN101010100&key=21f81f8ad6bc4155a05e5c4dac301eb2")
        let reqest = URLRequest.init(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: reqest) { (data, response, error) in
            ompLog(error)
            
            do {
                
//                let dict  = try JSONSerialization.jsonObject(with: data!)
                let json = try! JSON.init(data: data!)
                print(json)
                
                } catch {
                                                                    
            }
            
        }
        task.resume()
        
        
        
        
        let circle = OPCircleProgress.init(frame: CGRect.init(x: 30, y: 50, width: 250, height: 250))
        circle.center = CGPoint.init(x: 100, y: 200)
        circle.progress = 0.5
        view.addSubview(circle)
        
    }
}

extension SettingViewController {
    fileprivate func overlapAnimation() {
        overlapLayer.beginTime = CACurrentMediaTime() - 0.2
        overlapLayer.birthRate = 100
    }
}
