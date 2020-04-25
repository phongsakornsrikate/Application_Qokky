////
////  CountingLabel.swift
////  QokkyAppProject
////
////  Created by Phongsakorn Srikate on 25/2/2563 BE.
////  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
////
//
//import Foundation
//
//class CountingLabel: CountingLabel {
//
//    let counterVelocity: Float = 3.0
//    
//    enum CounterAnimationType {
//        case linear
//        case easeIn
//        case easeOut
//    }
//
//    enum CounterType {
//        case intType
//        case floatType
//    }
//
//    var startNumber: Float = 0.0
//    var endNumber: Float = 0.0
//
//    var progress: TimeInterval!
//    var duration: TimeInterval!
//    var lastUpdate: TimeInterval!
//
//    var timer: Timer?
//
//    var counterType: CounterType!
//    var counterAnimationType: CounterAnimationType!
//
//    var currentCounterValue: Float {
//        if progress >= duration {
//            return endNumber
//        }
//
//        let percentage = Float(progress / duration)
//        let update = updateCounter(counterValue: percentage)
//
//        return startNumber + (update * (endNumber - startNumber))
//    }
//
//    func count(from fromValue: Float, to toValue: Float, withDuration duration: TimeInterval, andAnimationType animationType: CounterAnimationType, andCounterType counterType: CounterType) {
//
//        self.startNumber = fromValue
//        self.endNumber = toValue
//        self.duration = duration
//        self.counterType = counterType
//        self.counterAnimationType = animationType
//        self.progress = 0
//        self.lastUpdate = Date.timeIntervalSinceReferenceDate
//
//        invalidateTimer()
//
//        if duration == 0 {
//            updateText(value: toValue)
//            return
//        }
//
//        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CountingLabel.updateValue), userInfo: nil, repeats: true)
//    }
//
//    @objc func updateValue() {
//        let now = Date.timeIntervalSinceReferenceDate
//        progress = progress + (now - lastUpdate)
//        lastUpdate = now
//
//        if progress >= duration {
//            invalidateTimer()
//            progress = duration
//        }
//
//        updateText(value: currentCounterValue)
//    }
//
//    func updateText(value: Float) {
//        switch counterType! {
//        case .intType:
//            self.text = "\(Int(value))%"
//        case .floatType:
//            self.text = String(format: "%.2f%", value)
//        }
//    }
//
//    func updateCounter(counterValue: Float) -> Float {
//        switch counterAnimationType! {
//        case .linear:
//            return counterValue
//        case .easeIn:
//            return pow(counterValue, counterVelocity)
//        case .easeOut:
//            return 1.0 - pow(1.0 - counterValue, counterVelocity)
//        }
//    }
//
//    func invalidateTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
//}
