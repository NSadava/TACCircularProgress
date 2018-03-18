//
//  TACCircularProgressLayer.swift
//  CircularProgress
//
//  Created by TACME on 3/15/18.
//  Copyright © 2018 TACME. All rights reserved.
//

import Foundation
import UIKit

private extension CGFloat {
    var toRads: CGFloat { return self * .pi / 180 }
}

class TACCircularProgressLayer: CAShapeLayer {
    
    var startAngle:CGFloat = 0
    var endAngle:CGFloat = 360
    
    
    var animated = false
    var animationStyle: String = kCAMediaTimingFunctionEaseInEaseOut
    var animationDuration: TimeInterval = 3.0
    
    @NSManaged var value:CGFloat
    @NSManaged var progressWidth:CGFloat
    @NSManaged var progressColor : UIColor
    @NSManaged var innerProgressWidth : CGFloat
    @NSManaged var innerProgressColor : UIColor
    
    @NSManaged var lblValueFont: UIFont
    @NSManaged var lblValueTextColor : UIColor
    @NSManaged var canShowValueDecimal:Bool
    @NSManaged var numberOfDecimalPoints:Int
    @NSManaged var lblValueIndicator:String
    @NSManaged var lblMaxValue:CGFloat
    
    
    lazy private var lblValue:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "value" {
            return true
        }
        
        return super.needsDisplay(forKey: key)
    }
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        UIGraphicsPushContext(ctx)
        drawOuterRing()
        drawInnerRing()
        drawValueLabel()
        UIGraphicsPopContext()
    }
    
    
    func drawOuterRing() {
        let width = bounds.width
        let height = bounds.height
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let outerRadius = max(width, height)/2 - progressWidth/2
        
        let outerPath = UIBezierPath(arcCenter: center, radius: outerRadius, startAngle: startAngle.toRads, endAngle: endAngle.toRads, clockwise: true)
        
        outerPath.lineCapStyle = .butt
        outerPath.lineWidth = progressWidth
        
        progressColor.setStroke()
        outerPath.stroke()
    }
    
    func drawInnerRing() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let angleDiff: CGFloat = endAngle.toRads - startAngle.toRads
        let arcvalue = angleDiff / lblMaxValue
        let innerEndAngle = arcvalue * value + startAngle.toRads
        let innerRadius = max(bounds.width, bounds.height)/2 - progressWidth/2 //(max(bounds.width - progressWidth*2 - innerRingSpacing, bounds.height - progressWidth*2 - innerRingSpacing)/2) - innerProgressWidth/2
        
        let innerPath = UIBezierPath(arcCenter: center, radius: innerRadius, startAngle: startAngle.toRads, endAngle: innerEndAngle, clockwise: true)
        
        innerPath.lineWidth = innerProgressWidth
        innerPath.lineCapStyle = .round
        innerProgressColor.setStroke()
        innerPath.stroke()
        
    }
    
    override func action(forKey event: String) -> CAAction? {
        if event == "value" && self.animated {
            let animation = CABasicAnimation(keyPath: "value")
            animation.fromValue = self.presentation()?.value(forKey: "value")
            animation.timingFunction = CAMediaTimingFunction(name: animationStyle)
            animation.duration = animationDuration
            return animation
        }
        
        return super.action(forKey: event)
    }
    
    func drawValueLabel() {
        
        lblValue.font = lblValueFont
        lblValue.textColor = lblValueTextColor
        if(canShowValueDecimal) {
            lblValue.text = String(format: "%.\(numberOfDecimalPoints)f", value) + "\(lblValueIndicator)"
        } else {
            lblValue.text = "\(Int(value))\(lblValueIndicator)"
        }
        
        lblValue.textAlignment = .center
        lblValue.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        lblValue.drawText(in: self.bounds)
    }
    
}
