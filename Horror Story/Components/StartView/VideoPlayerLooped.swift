//
//  VideoPlayerLooped.swift
//  Horror Story
//
//  Created by Bruna Naomi Yamanaka Silva on 23/05/22.
//

import Foundation
import AVKit

class VideoPlayerLooped {

    public var videoPlayer:AVQueuePlayer?
    public var videoPlayerLayer:AVPlayerLayer?
    var playerLooper: NSObject?
    var queuePlayer: AVQueuePlayer?
    

    func playVideo(fileName:String, inView:UIView){

        if let path = Bundle.main.path(forResource: fileName, ofType: "mov") {

            let url = URL(fileURLWithPath: path)
            let playerItem = AVPlayerItem(url: url as URL)

            videoPlayer = AVQueuePlayer(items: [playerItem])
            playerLooper = AVPlayerLooper(player: videoPlayer!, templateItem: playerItem)
            videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
            videoPlayerLayer!.frame = inView.bounds
            videoPlayerLayer!.videoGravity = AVLayerVideoGravity.resize
            inView.layer.addSublayer(videoPlayerLayer!)
            videoPlayer?.play()
        }
    }

    func remove() {
        videoPlayerLayer?.removeFromSuperlayer()

    }
}
