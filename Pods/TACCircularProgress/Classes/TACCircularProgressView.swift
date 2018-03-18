//
//  TACCircularProgressView.swift
//  CircularProgress
//
//  Created by TACME on 3/15/18.
//  Copyright © 2018 TACME. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class TACCircularProgressView: UIView {
    
    //MARK: - Inspectable Variables
    @IBInspectable open var progressColor : UIColor = UIColor.gray {
        didSet {
            self.tacCircularRingLayer.progressColor = self.progressColor
        }
    }
    
    @IBInspectable open var progressWidth : CGFloat = 10 {
        didSet {
            self.tacCircularRingLayer.progressWidth = self.progressWidth
        }
    }
    @IBInspectable open var innerProgressWidth:CGFloat = 5 {
        didSet {
            self.tacCircularRingLayer.innerProgressWidth = self.innerProgressWidth
        }
    }
    @IBInspectable open var value: CGFloat = 0 {
        didSet {
            if(value > maxValue && value != 0) {
                print("Value should be less then max value, Current MAX VALUE is \(maxValue) And VALUE is \(value)")
            }
            self.tacCircularRingLayer.value = self.value
        }
    }
    
    @IBInspectable open var innerProgressColor: UIColor = UIColor.white {
        didSet {
            self.tacCircularRingLayer.innerProgressColor = self.innerProgressColor
        }
    }
    
    @IBInspectable open var valueFont:UIFont = UIFont.systemFont(ofSize: 18) {
        didSet {
            self.tacCircularRingLayer.lblValueFont = valueFont
        }
    }
    
    @IBInspectable open var valueTextColor: UIColor = UIColor.black {
        didSet {
            self.tacCircularRingLayer.lblValueTextColor = valueTextColor
        }
    }
    
    @IBInspectable open var valueIndicator:String = "" {
        didSet {
            self.tacCircularRingLayer.lblValueIndicator = valueIndicator
        }
    }
    
    @IBInspectable open var maxValue : CGFloat = 100 {
        didSet {
            self.tacCircularRingLayer.lblMaxValue = maxValue
        }
    }
    @IBInspectable open var canShowDecimals:Bool = false {
        didSet {
            self.tacCircularRingLayer.canShowValueDecimal = canShowDecimals
        }
    }
    @IBInspectable open var numberOfDecimalPoint: Int = 2 {
        didSet {
            self.tacCircularRingLayer.numberOfDecimalPoints = numberOfDecimalPoint
        }
    }
    
    //MARK: -------------
    
    internal var tacCircularRingLayer : TACCircularProgressLayer {
        return self.layer as! TACCircularProgressLayer
    }
    override open class var layerClass: AnyClass {
        get {
            return TACCircularProgressLayer.self
         
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    open var isAnimating: Bool {
        get { return (self.layer.animation(forKey: "value") != nil) ? true : false }
    }
    
    internal func initialize() {
        self.layer.contentsScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale * 2
        self.tacCircularRingLayer.value = self.value
        self.tacCircularRingLayer.progressColor = self.progressColor
        self.tacCircularRingLayer.progressWidth = self.progressWidth
        self.tacCircularRingLayer.innerProgressColor = self.innerProgressColor
        self.tacCircularRingLayer.innerProgressWidth = self.innerProgressWidth
        self.tacCircularRingLayer.lblValueFont = self.valueFont
        self.tacCircularRingLayer.lblValueTextColor = self.valueTextColor
        self.tacCircularRingLayer.lblValueIndicator = self.valueIndicator
        self.tacCircularRingLayer.lblMaxValue = self.maxValue
        self.tacCircularRingLayer.canShowValueDecimal = self.canShowDecimals
        self.tacCircularRingLayer.numberOfDecimalPoints = self.numberOfDecimalPoint
        
        self.backgroundColor = UIColor.clear
    }
    
    public typealias progressCompletion = (()->Void)
    
    public func setProgress(value:CGFloat, animationDuration:TimeInterval, callback: progressCompletion? = nil) {
        if isAnimating { self.layer.removeAnimation(forKey: "value") }
        self.tacCircularRingLayer.animated = true
        self.tacCircularRingLayer.animationDuration = animationDuration
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            callback?()
        }
        self.value = value
        self.tacCircularRingLayer.value = value
        CATransaction.commit()
        
    }
    
}
