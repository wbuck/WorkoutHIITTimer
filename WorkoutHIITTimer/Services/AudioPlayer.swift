//
//  AudioPlayer.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-04.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    
    private(set) var audioPlayer : AVAudioPlayer?
    
    func playSound(_ file : String, _ ext : String) {

        guard let url = Bundle.main.url(forResource: file,
                                        withExtension: ext) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = audioPlayer else { return }
            player.play()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}
