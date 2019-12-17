//
//  ActivitySpinner.swift
//  romanisme
//
//  Created by Alex Aron on 15/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class ActivitySpinner: UIView {

    var isAnimating: Bool = false
    var hidesWhenStopped: Bool = true

    override var layer: CAShapeLayer {
        get {
            return super.layer as! CAShapeLayer
        }
    }

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    private func setPath() {
        layer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: layer.lineWidth / 2, dy: layer.lineWidth / 2)).cgPath
    }

    lazy private var animationLayer: CAShapeLayer = {
        return CAShapeLayer()
    }()

    public init() {
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        animationLayer.frame = frame
        animationLayer.fillColor = nil
        animationLayer.strokeColor = UIColor.black.cgColor
        animationLayer.lineWidth = 1
        animationLayer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: animationLayer.lineWidth / 2, dy: animationLayer.lineWidth / 2)).cgPath
        animationLayer.masksToBounds = true
        self.layer.addSublayer(animationLayer)
        addAnimation(forLayer: animationLayer)
        pause(layer: animationLayer)
        self.isHidden = true
   }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Pose {
        let secondsSincePriorPose: CFTimeInterval
        let start: CGFloat
        let length: CGFloat
        init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
            self.secondsSincePriorPose = secondsSincePriorPose
            self.start = start
            self.length = length
        }
    }
    
    class var poses: [Pose] {
        get {
            return [
                Pose(0.0, 0.000, 0.7),
                Pose(0.6, 0.500, 0.5),
                Pose(0.6, 1.000, 0.3),
                Pose(0.6, 1.500, 0.1),
                Pose(0.2, 1.875, 0.1),
                Pose(0.2, 2.250, 0.3),
                Pose(0.2, 2.625, 0.5),
                Pose(0.2, 3.000, 0.7),
            ]
        }
    }
    
    func addAnimation(forLayer layer: CAShapeLayer) {
        var time: CFTimeInterval = 0
        var times = [CFTimeInterval]()
        var start: CGFloat = 0
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()
        let poses = type(of: self).poses
        let totalSeconds = poses.reduce(0) { $0 + $1.secondsSincePriorPose }
        for pose in poses {
            time += pose.secondsSincePriorPose
            times.append(time / totalSeconds)
            start = pose.start
            rotations.append(start * 2 * .pi)
            strokeEnds.append(pose.length)
        }
        times.append(times.last!)
        rotations.append(rotations[0])
        strokeEnds.append(strokeEnds[0])
        animateKeyPath(keyPath: "strokeEnd", duration: totalSeconds, times: times, values: strokeEnds, layer: layer)
        animateKeyPath(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations, layer: layer)
    }

    func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat], layer: CALayer) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        animation.calculationMode = .linear
        animation.duration = duration
        animation.repeatCount = .infinity
        layer.add(animation, forKey: animation.keyPath)
    }
    
    public func pauseed(layer: CAShapeLayer) {
           let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
           layer.timeOffset = pausedTime
           isAnimating = false
       }


    public func pause(layer: CAShapeLayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        isAnimating = false
    }

    public func resume(layer: CAShapeLayer) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        isAnimating = true
    }
    

    public func startAnimating () {
        if isAnimating { return }
        if hidesWhenStopped { self.isHidden = false }
        resume(layer: animationLayer)
    }

    public func stopAnimating () {
        if hidesWhenStopped { self.isHidden = true }
        pause(layer: animationLayer)
        
    }

}
