//
//  LoadingCircle.swift
//  ClearScoreTechnicalTask
//
//  Created by Jack Sherwood on 08/11/2019.
//  Copyright © 2019 Jack Sherwood. All rights reserved.
//

import UIKit

//creates the shapelayer
let shapeLayer = CAShapeLayer()

let scoreLabel: UILabel = {
    let label = UILabel()
    label.text = String(0)
    label.textAlignment = .center
    label.textColor = UIColor.red
    label.font = UIFont.boldSystemFont(ofSize: 32)
    return label
}()


class LoadingCircle: CAShapeLayer {
    
    func createLoadingCircle(view: UIView, completion: ((_ data: CAShapeLayer, _ underTrack: CAShapeLayer) -> Void)) {
        
        //Draws the circle
        let circlePath = UIBezierPath(arcCenter: view.center, radius: 150, startAngle:0 , endAngle: (CGFloat.pi * 2), clockwise: true)
        shapeLayer.path = circlePath.cgPath
        
        //Sets up the loading line
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 10
        
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        //Sets up the underneath track
        let trackLayer = CAShapeLayer()
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = CAShapeLayerLineCap.round
    
        
        completion(shapeLayer,trackLayer)
    }
    
    func loadingAnimation(score: Int) {
        print("Loading Circle")
        print(score)
        let loadingAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        let percentage = Float(score) / 700
        print(percentage)
        
        loadingAnimation.toValue = percentage
        loadingAnimation.duration = 2
        //Allows line to stay on completion
        loadingAnimation.fillMode = CAMediaTimingFillMode.forwards
        loadingAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(loadingAnimation, forKey: "AnimateCircle")
    }

}
