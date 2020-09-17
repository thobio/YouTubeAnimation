//
//  ViewController.swift
//  YouTubeAnimation
//
//  Created by Zerone Consulting on 17/09/20.
//  Copyright © 2020 Thobio Joseph. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFunc)))
    }
    @objc func handleFunc(){
        (0...10).forEach { (_) in
            generateAnimatedViews()
        }
    }
    fileprivate func generateAnimatedViews() {
        let image = drand48() > 0.5 ? UIImage(named: "like") : UIImage(named: "heart")
        let imageView = UIImageView(image: image)
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
        
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
    }
}
func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200))
    let endPoint = CGPoint(x: 400, y: 200)
    let randomYShift =  200 + drand48() * 300
    let c1 = CGPoint(x: 100, y: 100 - randomYShift)
    let c2 = CGPoint(x: 200, y: 300 + randomYShift)
    path.addCurve(to: endPoint, controlPoint1: c1, controlPoint2: c2)
    return path
}

class CurvedView:UIView{
    override func draw(_ rect: CGRect) {
        let path = customPath()
        path.stroke()
    }
}
