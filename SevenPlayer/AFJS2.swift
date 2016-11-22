//
//  AFJS2.swift
//  SevenPlayer
//
//  Created by caiyangzhenyu on 16/11/21.
//  Copyright © 2016年 caiyangzhenyu. All rights reserved.
//

import UIKit
typealias clouse = (_ dic:NSDictionary)->Void
typealias clouse1 = (_ err:NSError)->Void
class AFJS2: NSObject {
    static let shareInstance = AFJS2()
//    GET
    func getJson(url:String,success:@escaping clouse, fail:@escaping clouse1) {
        let manager = AFHTTPSessionManager.init()
        manager.requestSerializer = AFJSONRequestSerializer.init()
        manager.get(url, parameters: nil, progress: nil, success: { (task,res) in
            guard let dic = res as? NSDictionary else {
                return
            }
            success(dic)
            
        },failure:{ (operation,err) in
            fail(err as NSError)
           
        }
        )
    }
//    POST
    func postJson(param:Any,url:String, success:@escaping clouse, fail:@escaping clouse1) {
        let manager = AFHTTPSessionManager.init()
        manager.requestSerializer = AFJSONRequestSerializer.init()
        
        manager.post(url, parameters: param, progress: nil, success: { (task,res) in
            guard let dic = res as? NSDictionary else {
                return
            }
            success(dic)
        }, failure: {(operation,err) in
            fail(err as NSError)
        })
    }
//    UPLOAD
    func uploadTask() {
        
    }
    
    
}

