//
//  ViewController.swift
//  SevenPlayer
//
//  Created by caiyangzhenyu on 16/11/17.
//  Copyright © 2016年 caiyangzhenyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PLPlayerDelegate {
    var player:PLPlayer!
    
    @IBAction func starting(_ sender: UIButton) {
         self.player.play()
    }
    @IBOutlet weak var pview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let option = PLPlayerOption.default()
        option.setOptionValue(15, forKey: PLPlayerOptionKeyTimeoutIntervalForMediaPackets)
        let url = URL.init(string: "http://127.0.0.1:8080/assets/1.mov")
        self.player = PLPlayer.init(url: url, option: option)
       
        self.player.delegate = self
        pview.addSubview(self.player.playerView!)
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        print(state)
    }
    func player(_ player: PLPlayer, stoppedWithError error: Error?) {
        print(error ?? "11")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

