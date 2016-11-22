//
//  SecondViewController.swift
//  SevenPlayer
//
//  Created by caiyangzhenyu on 16/11/18.
//  Copyright © 2016年 caiyangzhenyu. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var player:AVPlayer!
    var picker:UIImagePickerController!
    var link = "11"
    @IBOutlet weak var collectVideo: UIButton!
    @IBAction func collecOnclick(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) == true {
            self.present(picker, animated: true) {
                
            }
        }
    }
    @IBAction func playerOnclick(_ sender: UIButton) {
        
       AFJS2.shareInstance.getJson(url: "http://172.16.72.58:8080/movie1", success: { (res) in
            print(res)
        
       }, fail: {(err) in
       
       })
    }
    
    @IBOutlet weak var playerBtn: UIButton!
    
    
    deinit {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) == true {
            picker = UIImagePickerController.init()
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraDevice = UIImagePickerControllerCameraDevice.rear
            picker.mediaTypes = [kUTTypeMovie as String]
            picker.videoQuality = UIImagePickerControllerQualityType.typeHigh
            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.video
            picker.delegate = self
            
        }else {
            print("没有摄像头")
        }
        
                // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let url = info[UIImagePickerControllerMediaURL] as! URL
        let ustr = url.path
        UISaveVideoAtPathToSavedPhotosAlbum(ustr, self, #selector(SecondViewController.video(_:didFinishSavingWithError:contextInfo:)), nil)
        dismiss(animated: true, completion: nil)
    }
    func video(_ videoPath: String, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
//        var title = "Success"
//        var message = "Video was saved"
        if error != nil {
//            title = "Error"
//            message = "Video failed to save"
        }else {
//            let url = URL.init(fileURLWithPath: videoPath)
            
            let config = URLSessionConfiguration.default
            let manager = AFURLSessionManager.init(sessionConfiguration: config)
            let filePath = URL.init(fileURLWithPath: videoPath)
            let request = AFHTTPRequestSerializer.init().multipartFormRequest(withMethod: "POST", urlString: "http://172.16.72.67:8080/upload", parameters: nil, constructingBodyWith: { (formData) in
                do {
                    try formData.appendPart(withFileURL: filePath, name: "upload")
                }catch {
                    print("gg")
                }
            }, error: nil)
            let req1 = request.copy() as! URLRequest
            let task = manager.uploadTask(withStreamedRequest:req1, progress: nil, completionHandler: { (res, obj, err) in
                if err == nil {
                    print(res)

                }
            })
            task.resume()
            
            
            
            

        }
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
