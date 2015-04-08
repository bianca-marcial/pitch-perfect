//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Bianca Marcial on 3/24/15.
//  Copyright (c) 2015 Bianca Marcial. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioDelay: AVAudioUnitDelay!
    var audioReverb: AVAudioUnitReverb!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stopPlayers(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playSound(){
        stopPlayers()
        
        audioPlayer.currentTime = 0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float)  {
        stopPlayers()
        
        var audioPlayerNode = AVAudioPlayerNode()
        var timePitch = AVAudioUnitTimePitch()
        
        timePitch.pitch = pitch
        
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(audioPlayerNode, to: timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func playDelay(){
        stopPlayers()
        
        audioDelay = AVAudioUnitDelay()
        var audioPlayerNode = AVAudioPlayerNode()
        
        audioDelay.delayTime = 1.0
        audioDelay.feedback = 50
        setupAudioEngine(audioPlayerNode, effect: audioDelay)
        
        audioPlayerNode.play()
    }
    
    func playReverb(){
        stopPlayers()
        
        audioReverb = AVAudioUnitReverb()
        var audioPlayerNode = AVAudioPlayerNode()
        
        audioReverb.wetDryMix = 50
        setupAudioEngine(audioPlayerNode, effect: audioReverb)
        
        audioPlayerNode.play()
    }
    
    func setupAudioEngine(node: AVAudioPlayerNode, effect: AVAudioUnitEffect ){
        audioEngine.attachNode(node)
        audioEngine.attachNode(effect)
        
        audioEngine.connect(node, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        node.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
    }
    
    @IBAction func snailPushed(sender: UIButton) {
        //TODO: Make recorded audio go slower
        audioPlayer.rate = 0.5
        playSound()
        
    }
    
    @IBAction func rabbitPushed(sender: UIButton) {
        audioPlayer.rate = 1.5
        playSound()
    }

    @IBAction func chipmunkPushed(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthVaderPushed(sender: UIButton) {
        playAudioWithVariablePitch(-800)
    }
    
    @IBAction func echo(sender: UIButton) {
        //TODO: Add echo effect
        playDelay()
    }
    
    @IBAction func reverb(sender: UIButton) {
        playReverb()
    }
    @IBAction func stopPlayBack(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
