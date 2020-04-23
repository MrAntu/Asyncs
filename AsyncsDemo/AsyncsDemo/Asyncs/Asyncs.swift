//
//  Asyncs.swift
//  AsyncsDemo
//
//  Created by weiwei.li on 2020/4/23.
//  Copyright © 2020 dd01.leo. All rights reserved.
//

import Foundation

public typealias Task = () -> Void

public struct Asycns {
    public static func async(_ task: @escaping Task) {
        _async(task, nil)
    }
    
    public static func async(_ task: @escaping Task, _ mainTask:@escaping Task) {
        _async(task, mainTask)
    }
    
    private static func _async(_ task: @escaping Task, _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
}

extension Asycns {
    @discardableResult
    public static func delay(_ seconds: Double, _ block: @escaping Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        return item
    }
    
    @discardableResult
    public static func asycnDelay(_ seconds: Double, _ block: @escaping Task) -> DispatchWorkItem {
        return _asycnDelay(seconds, block)
    }
    
    @discardableResult
    public static func asycnDelay(_ seconds: Double, _ block: @escaping Task, _ main: @escaping Task) -> DispatchWorkItem {
       return _asycnDelay(seconds, block, main)
    }
    
    private static func _asycnDelay(_ seconds: Double, _ block: @escaping Task,  _ main: Task? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        if let main = main {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
    
}
