//
//  VideoPlayer.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation
import AVFoundation

protocol VideoPlayerDelegate: AnyObject {
    func videoPlayer(_ player: VideoPlayer, didUpdatedStatus status: AVPlayer.Status)
    func videoPlayer(_ player: VideoPlayer, didUpdatedProgress progress: Double)
    func didReachedEnd(_ player: VideoPlayer)
    func didFailedToReachEnd(_ player: VideoPlayer)
}

extension VideoPlayerDelegate {
    func videoPlayer(_ player: VideoPlayer, didUpdatedStatus status: AVPlayer.Status) { }
    func videoPlayer(_ player: VideoPlayer, didUpdatedProgress progress: Double) { }
    func didReachedEnd(_ player: VideoPlayer) { }
    func didFailedToReachEnd(_ player: VideoPlayer) { }
}

let videoContext: UnsafeMutableRawPointer? = nil

class VideoPlayer: NSObject {
    weak var delegate:VideoPlayerDelegate?
    
    private var assetPlayer:AVPlayer?
    private var playerItem:AVPlayerItem?
    private var urlAsset:AVURLAsset?
    private var videoOutput:AVPlayerItemVideoOutput?
    
    private(set) var assetDuration:Double = 0
    private weak var playerView:PlayerView?
    
    private var autoPlay:Bool = true
    
    // MARK: - Init
    convenience init(urlAsset:URL, view: PlayerView, autoplay: Bool = true) {
        self.init()
        
        playerView = view
        autoPlay = autoplay
        
        if let playView = playerView {
            playView.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        }
        
        initialSetupWithURL(url: urlAsset)
        prepareToPlay()
    }
    
    override init() {
        super.init()
    }
    
    // MARK: - Public
    
    var isPlaying: Bool {
        return (assetPlayer?.rate ?? 0) > 0
    }
    
    var playerRate:Float = 1 {
        didSet {
            if let player = assetPlayer {
                player.rate = playerRate > 0 ? playerRate : 0.0
            }
        }
    }
    
    func pause() {
        if let player = assetPlayer {
            player.pause()
        }
    }
    
    func play() {
        if let player = assetPlayer {
            if (player.currentItem?.status == .readyToPlay) {
                player.play()
                player.rate = playerRate
            }
        }
    }
    
    func cleanUp() {
        if let item = playerItem {
            item.removeObserver(self, forKeyPath: "status")
        }
        NotificationCenter.default.removeObserver(self)
        assetPlayer = nil
        playerItem = nil
        urlAsset = nil
    }
    
    // MARK: - Private
    
    private func prepareToPlay() {
        guard let asset = urlAsset else { return }
        let keys = ["tracks"]
        asset.loadValuesAsynchronously(forKeys: keys) { [weak self] in
            DispatchQueue.main.async {
                self?.startLoading()
            }
        }
    }
    
    private func startLoading(){
        guard let asset = urlAsset else { return }
        assetDuration = CMTimeGetSeconds(asset.duration)
        let videoOutputOptions = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_444YpCbCr10BiPlanarFullRange)]
        videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: videoOutputOptions)
        playerItem = AVPlayerItem(asset: asset)
        
        guard let item = playerItem else { return }
        item.addObserver(self, forKeyPath: "status", options: .initial, context: videoContext)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFailedToPlayToEnd), name:NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: nil)
        
        guard let output = videoOutput else { return }
        item.add(output)
        item.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithm.varispeed
        assetPlayer = AVPlayer(playerItem: item)
        
        assetPlayer?.rate = playerRate
        
        addPeriodicalObserver()
        playerView?.playerLayer.player = assetPlayer
        
    }
    
    private func addPeriodicalObserver() {
        guard let player = assetPlayer else { return }
        let timeInterval = CMTimeMake(value: 1, timescale: 1)
        player.addPeriodicTimeObserver(forInterval: timeInterval, queue: .main) { [weak self] (time) in
            self?.playerDidChangeTime(time: time)
        }
    }
    
    private func playerDidChangeTime(time:CMTime) {
        guard let player = assetPlayer else { return }
        let timeNow = CMTimeGetSeconds(player.currentTime())
        let progress = timeNow / assetDuration
        delegate?.videoPlayer(self, didUpdatedProgress: progress)
    }
    
    @objc private func playerItemDidReachEnd() {
        delegate?.didReachedEnd(self)
        guard let player = assetPlayer else { return }
        player.seek(to: CMTime.zero)
    }
    
    @objc private func didFailedToPlayToEnd() {
        delegate?.didFailedToReachEnd(self)
    }
    
    private func playerDidChangeStatus(status:AVPlayer.Status) {
        delegate?.videoPlayer(self, didUpdatedStatus: status)
        guard status == .readyToPlay else { return }
        if autoPlay && assetPlayer?.rate == 0 {
            play()
        }
    }
    
    deinit {
        cleanUp()
    }
    
    private func initialSetupWithURL(url:URL) {
        let options = [AVURLAssetPreferPreciseDurationAndTimingKey : true]
        urlAsset = AVURLAsset(url: url, options: options)
    }
 
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if context == videoContext {
            if let key = keyPath {
                if key == "status", let player = assetPlayer {
                    playerDidChangeStatus(status: player.status)
                }
            }
        }
    }
}
