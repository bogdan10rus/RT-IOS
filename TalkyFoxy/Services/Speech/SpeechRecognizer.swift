//
//  SpeechRecognizer.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import RxSwift
import AVFoundation
import Speech

class SpeechRecognizer: NSObject {
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    private let request = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    private let isListeningSubject = BehaviorSubject<Bool>(value: false)
    private let isSpeakingSubject = BehaviorSubject<Bool>(value: false)
    private let recognizedTextSubject = BehaviorSubject<String?>(value: nil)
    
    var isSpeaking: Observable<Bool> {
        return isSpeakingSubject
            .asObserver()
    }
    
    var isListening: Observable<Bool> {
        return isListeningSubject
            .asObserver()
    }
    
    var recognizedText: Observable<String> {
        return recognizedTextSubject
            .compactMap { $0 }
    }
    
    override init() {
        super.init()
        
        self.requestSpeechAuthorization()
        
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        try? audioSession.setMode(AVAudioSession.Mode.spokenAudio)
        
        speechSynthesizer.delegate = self
    }
    
    func speak(text: String) {
        speechSynthesizer.stopSpeaking(at: .immediate)
        
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        speechSynthesizer.speak(speechUtterance)
    }
    
    func listen() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            print("Speech recognition is not supported for your current locale.")
            return
        }
        
        if !myRecognizer.isAvailable {
            print("Speech recognition is not currently available. Check back at a later time.")
            return
        }
        
        isListeningSubject.onNext(true)
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { [unowned self] result, error in
            if let result = result {
                recognizedTextSubject.onNext(result.bestTranscription.formattedString)
            } else if let error = error {
                print(error)
            }
        })
    }
    
    func stopListening() {
        isListeningSubject.onNext(false)
        
        recognitionTask?.finish()
        recognitionTask = nil
        
        request.endAudio()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
}

extension SpeechRecognizer: SFSpeechRecognizerDelegate, AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        isSpeakingSubject.onNext(true)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeakingSubject.onNext(false)
    }
}

private extension SpeechRecognizer {
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    break
                default:
                    break
                }
            }
        }
    }
}
