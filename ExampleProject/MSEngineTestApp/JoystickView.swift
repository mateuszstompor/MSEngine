//
//  JoystickView.swift
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 05/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

import UIKit

@objc class JoystickView: UIView, UIGestureRecognizerDelegate {
    
    private var joyLayer: CALayer?
    private var pangest: UIPanGestureRecognizer?
    
    var delegate: JoystickEventHandler?
    
    var currentPosition: CGPoint {
        get {
            let distancetocenterX = Float(pangest!.location(in: self).x - self.bounds.width/2)
            let distancetocenterY = Float(pangest!.location(in: self).y - self.bounds.height/2)
            let xPos = CGFloat(distancetocenterX)/(self.bounds.width/2.0)
            let yPos = -CGFloat(distancetocenterY)/(self.bounds.height/2.0)
            return CGPoint(x: xPos, y: yPos)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.prepareAppearance()
    }
    
    private func prepareAppearance() {
        self.alpha = 0.3

        let sizeinside = 50
        let insideCircleSize = CGSize(width: sizeinside, height: sizeinside)
        
        let layerCircle = CAShapeLayer()
        let centerPoint = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        layerCircle.path = UIBezierPath(roundedRect: CGRect(x: centerPoint.x-insideCircleSize.width/2, y: centerPoint.y-insideCircleSize.height/2, width: insideCircleSize.width, height: insideCircleSize.height), cornerRadius: insideCircleSize.width/2).cgPath
        layerCircle.fillColor = UIColor.gray.cgColor
        self.layer.addSublayer(layerCircle)
        self.joyLayer = layerCircle
        
        self.layer.cornerRadius = self.frame.width/2
        self.pangest = UIPanGestureRecognizer(target: self, action: #selector(panGest(_:)))
        self.pangest?.delegate = self
        self.pangest?.maximumNumberOfTouches = 1
        self.pangest?.minimumNumberOfTouches = 1
        self.addGestureRecognizer(self.pangest!)
    }
    
    @objc private func panGest (_ panget: UIPanGestureRecognizer){
        
        switch panget.state {
        case .ended:
            self.delegate?.joyTouchRecognitionDidEnd?(sender: self)
            self.joyLayer?.position = CGPoint(x: 0.0, y: 0.0)
            return
        case .began:
            self.delegate?.joyTouchRecognitionDidStart?(sender: self)
        default:
            break
        }
        
        var locationInSuperLayer = pangest!.location(in: self)
        
        locationInSuperLayer = CGPoint(x: locationInSuperLayer.x-self.bounds.width/2, y: locationInSuperLayer.y-self.bounds.height/2)
        self.joyLayer?.position = locationInSuperLayer
        self.delegate?.joyPositionDidChanged?(sender: self)
    }
}

@objc protocol JoystickEventHandler {
    @objc optional func joyTouchRecognitionDidStart(sender: JoystickView)
    @objc optional func joyTouchRecognitionDidEnd(sender: JoystickView)
    @objc optional func joyPositionDidChanged(sender: JoystickView)
}
