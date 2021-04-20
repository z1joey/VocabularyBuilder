//
//  SpeechManager.swift
//  SpeechManager
//
//  Created by Yi Zhang on 2021/4/20.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

private let language: String = "en-US"

public class SpeechManager: NSObject {
    private var audioEngine: AVAudioEngine
    private var speechRecognizer: SFSpeechRecognizer
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var inputNode: AVAudioInputNode

    public override init() {
        audioEngine = AVAudioEngine()
        inputNode = audioEngine.inputNode
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: language))!
    }

    public func requestAuthorization(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    completion(true)
                case .denied:
                    completion(false)
                    print("User denied access to speech recognition")
                case .restricted:
                    completion(false)
                    print("Speech recognition restricted on this device")
                case .notDetermined:
                    completion(false)
                    print("Speech recognition not yet authorized")
                @unknown default:
                    fatalError()
                }
            }
        }
    }

    public func recognizeLastWord(_ completion: @escaping (SpeechWord?)->Void) {
        startRecording { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
                completion(nil)
                return
            }

            if let segment = result?.bestTranscription.segments.last {
                completion(SpeechWord(segment: segment))
                return
            }

            completion(nil)
        }
    }

    public func startRecording(_ completion: @escaping (SFSpeechRecognitionResult?, Error?)->Void) {
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil

        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            completion(nil, error)
        }

        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true

        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }

        guard let myRecognizer = SFSpeechRecognizer() else {
            print("Speech recognition is not supported for your current locale.")
            return
        }

        if !myRecognizer.isAvailable {
            print("Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            return
        }

        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { result, error in
            var isFinal = false

            if let result = result {
                isFinal = result.isFinal
                completion(result, nil)
            }

            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.stopRecording()

                completion(nil, error)
            }
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
        } catch {
            completion(nil, error)
        }
    }

    public func stopRecording() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            inputNode.removeTap(onBus: 0)

            recognitionRequest = nil
            recognitionTask = nil
        }
    }

    public func speak(_ text: String, rate: Float = 0.1) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = rate
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
