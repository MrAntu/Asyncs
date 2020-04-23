//
//  ViewController.swift
//  AsyncsDemo
//
//  Created by weiwei.li on 2020/4/23.
//  Copyright © 2020 dd01.leo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Asycns.async {
            print("!23123")
            print(Thread.current)
        }
        
        Asycns.async({ //异步线程
            print("111111")
            print(Thread.current)
        }) { //主线程
             print("2222222")
            print(Thread.current)
        }
        
       //子线程异步延迟
        let item = Asycns.asycnDelay(5, {
            print("44444")
            print(Thread.current)
            sleep(2)
        }) { //回到主线程
            print("55555")
            print(Thread.current)
        }
        //主线程异步延迟
        Asycns.delay(2) {
           print("333333")
           print(Thread.current)
            item.cancel()
       }
    }


}

