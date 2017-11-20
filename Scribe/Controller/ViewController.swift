//
//  ViewController.swift
//  Scribe
//
//  Created by Jibran Syed on 10/29/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate
{
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var audioPlayer: AVAudioPlayer!
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.spinner.isHidden = true
    }
    
    
    func requestSpeechAuth()
    {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized
            {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a")
                {
                    // Play sound
                    do
                    {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    }
                    catch
                    {
                        debugPrint(error)
                    }
                    
                    // Analyze sound
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request, resultHandler: { (result, inError) in
                        if let error = inError
                        {
                            print("There was an error: ")
                            debugPrint(error)
                        }
                        else // no error
                        {
                            self.textField.text = result?.bestTranscription.formattedString
                        }
                        
                        
                    })
                }
            }
        }
    }
    
    
    
    
    @IBAction func onPlayTranscribeBtnPressed(_ sender: Any) 
    {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        self.requestSpeechAuth()
    }
    
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) 
    {
        player.stop()
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
    }
    
    
}

