//
//  ViewController.swift
//  BezierPathDrawCircleDemo
//
//  Created by Zark on 2019/9/25.
//  Copyright © 2019 Zark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        drawLayer()
        
        let r: CGFloat = 90
        let circle = UIView(frame: CGRect(origin: .zero, size: CGSize(width: r*2, height: r*2)))
        circle.backgroundColor = .systemBlue
        circle.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        circle.layer.cornerRadius = r
        view.addSubview(circle)
    }
    
    func drawLayer() {
        
        let viewWidth = UIScreen.main.bounds.width
        let viewHeight = UIScreen.main.bounds.height
        let path = UIBezierPath()
                
        let r1: CGFloat = 30
        let r2: CGFloat = 100
        let sinA: CGFloat = sin(r1 / (r1 + r2))
        let A: CGFloat = asin(sinA)
        let B: CGFloat = CGFloat.pi / 2 - A
        let cosA: CGFloat = cos(A)
        let horiW: CGFloat = r2 * cosA
        
        let magicN1 = magicN(CGFloat.pi * 2 / B)
        let magicN2 = magicN(CGFloat.pi * 2 / B)
        
        let cur1P = CGPoint(x: viewWidth/2 - (r1+r2)*cosA,
                            y: viewHeight/2)
        let cur1C1 = CGPoint(x: viewWidth/2 - (r1+r2)*cosA + r1*magicN1,
                             y: viewHeight/2)
        let cur1C2 = CGPoint(x: viewWidth/2 - horiW - r1*magicN1*sinA,
                             y: viewHeight/2 + r2*sinA - r1*magicN1*cosA)
        let cur1Des = CGPoint(x: viewWidth/2 - horiW,
                              y: viewHeight/2 + r2*sinA)
        
        let cur2C1 = CGPoint(x: viewWidth/2 - horiW + r2*magicN2*sinA,
                             y: viewHeight/2 + r2*sinA + r2*magicN2*cosA)
        let cur2C2 = CGPoint(x: viewWidth/2 - r2*magicN2,
                             y: viewHeight/2 + r2)
        let cur2Des = CGPoint(x: viewWidth/2,
                              y: viewHeight/2 + r2)
        
        let cur3C1 = CGPoint(x: viewWidth/2 + r2*magicN2,
                             y: viewHeight/2 + r2)
        let cur3C2 =  CGPoint(x: viewWidth/2 + horiW - r2*magicN2*sinA,
                              y: viewHeight/2 + r2*sinA  + r2*magicN2*cosA)
        let cur3Des = CGPoint(x: viewWidth/2 + horiW,
                              y: viewHeight/2 + r2*sinA)
        
        
        let cur4C1 = CGPoint(x: viewWidth/2 + horiW + r1*magicN1*sinA,
                             y: viewHeight/2 + r2*sinA - r1*magicN1*cosA)
        let cur4C2 = CGPoint(x: viewWidth/2 + (r1+r2)*cosA - r1*magicN1,
                             y: viewHeight/2)
        let cur4Des = CGPoint(x: viewWidth/2 + (r1+r2)*cosA,
                              y: viewHeight/2)
        
        path.move(to: cur1P)
        path.addCurve(to: cur1Des, controlPoint1: cur1C1, controlPoint2: cur1C2)
        path.addCurve(to: cur2Des, controlPoint1: cur2C1, controlPoint2: cur2C2)
        path.addCurve(to: cur3Des, controlPoint1: cur3C1, controlPoint2: cur3C2)
        path.addCurve(to: cur4Des, controlPoint1: cur4C1, controlPoint2: cur4C2)
        
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.systemPink.cgColor
        layer.strokeColor = UIColor.systemBlue.cgColor
        layer.lineWidth = 3
        
        self.view.layer.addSublayer(layer)
        
    }
    
    func otherL(_ hypot: CGFloat, _ otherL: CGFloat) -> CGFloat {
        return sqrt(hypot * hypot - otherL * otherL)
    }
    
    func magicN(_ n: CGFloat) -> CGFloat {
        // 一个圆划分为 n 个贝赛尔曲线
        return (4/3)*tan(CGFloat.pi/(2*n))
    }
    
 
}
