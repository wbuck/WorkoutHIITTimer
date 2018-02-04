//
//  TimerViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-28.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit
import AsyncTimer

class RoundTimerDisplayViewController: UIViewController {
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var controlsContainerView: UIView!
    @IBOutlet weak var startButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var workoutLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var workoutLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundTitleLabel: UILabel!
    @IBOutlet weak var roundIndicatorLabel: UILabel!
    @IBOutlet weak var timeIndicatorLabel: UILabel!
    @IBOutlet weak var timeRemainingIndicatorLabel: UILabel!
    @IBOutlet weak var totalTimeIndicatorLabel: UILabel!
    private var currentTimerIndex: Int = 0
    private let mainMenuSegue = "GoToMainMenu"
    private var timers = [TimerControl]()
    var roundTimer: RoundTimer!
    private var currentRound: Int = 0 {
        didSet {
            roundIndicatorLabel.text = "\(currentRound)"
        }
    }
    private var totalTimeInSeconds: Int = 0 {
        didSet {
            totalTimeIndicatorLabel.text = formatTime(from: totalTimeInSeconds)
        }
    }
    private var elapsedTimeInSeconds: Int = 0 {
        didSet {
            timeIndicatorLabel.text = formatTime(from: Int(elapsedTimeInSeconds))
        }
    }
    private var remainingTimeInSeconds: Int = 0 {
        didSet {
            timeRemainingIndicatorLabel.text = formatTime(from: Int(remainingTimeInSeconds))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTimers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startStopButton.circleButton(backgroundColor: UIColor.clear, borderWidth: 2, borderColor: UIColor(named: "TimerOrange"))
        resetButton.circleButton(backgroundColor: UIColor.clear, borderWidth: 2, borderColor: UIColor(named: "TimerWhite"))
        quitButton.circleButton(backgroundColor: UIColor.clear, borderWidth: 2, borderColor: UIColor(named: "TimerWhite"))
        drawBorderedLabel(workoutLabel, backgroundColor: UIColor.clear, cornerRadius: 5, borderWidth: 2, borderColor: UIColor.clear)
        navigationController?.isNavigationBarHidden = true
        roundIndicatorLabel.text = "rounds".uppercased()
        currentRound = 0
        updateInterface()
        changeSizeBasedOnOrientation()
    }
    
    private func updateInterface() {
        let timer = timers[currentTimerIndex]
        changeWorkoutLabel(timer)
        if timer.timerDirection == .up {
            elapsedTimeInSeconds = 0
            remainingTimeInSeconds = Int(timer.totalTimeInSeconds)
        } else {
            elapsedTimeInSeconds = Int(timer.totalTimeInSeconds)
            remainingTimeInSeconds = Int(timer.totalTimeInSeconds)
        }
        totalTimeInSeconds = 0
        currentRound = 0
        startStopButton.setTitle("START", for: .normal)
    }
    
    private func changeWorkoutLabel(_ timer: TimerControl) {
        workoutLabel.text = timer.displayName
        workoutLabel.layer.borderColor = timer.borderColor.cgColor
        workoutLabel.textColor = timer.textColor
    }
    
    // Create all of the required timers.
    private func createTimers() {
        timers.removeAll()
        let direction = roundTimer.countDirection
        if roundTimer.warmupTimerEnabled {
            let warmup = TimerControl(type: .warmupTimer, name: "Warmup",
                                      direction: direction, interval: roundTimer.warmupIntervalInSeconds)
            warmup.delegate = self
            timers.append(warmup)
        }
        for _ in 1...roundTimer.rounds {
            let round = TimerControl(type: .roundTimer, name: "Workout",
                                     direction: direction, interval: roundTimer.roundsIntervalInSeconds)
            round.delegate = self
            timers.append(round)
            if roundTimer.restTimerEnabled {
                let rest = TimerControl(type: .restTimer, name: "Rest",
                                        direction: direction, interval: roundTimer.restIntervalInSeconds)
                rest.delegate = self
                timers.append(rest)
            }
        }
        if roundTimer.coolDownTimerEnabled {
            let coolDown = TimerControl(type: .coolDownTimer, name: "Cooldown",
                                        direction: direction, interval: roundTimer.coolDownIntervalInSeconds)
            coolDown.delegate = self
            timers.append(coolDown)
        }
    }
    /*
     private func formatTime(from seconds: Int) -> String {
     let f = (seconds / 60, (seconds % 60))
     print("minutes \(f.0) seconds \(f.1)")
     let time = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
     let hour = time.0 < 10 ? "0\(time.0)" : "\(time.0)"
     let minute = time.1 < 10 ? "0\(time.1)" : "\(time.1)"
     let second = time.2 < 10 ? "0\(time.2)" : "\(time.2)"
     return "\(hour):\(minute):\(second)"
     }
     */
    private func formatTime(from seconds: Int) -> String {
        let time = (seconds / 60, (seconds % 60))
        let minute = time.0 < 10 ? "0\(time.0)" : "\(time.0)"
        let second = time.1 < 10 ? "0\(time.1)" : "\(time.1)"
        return "\(minute):\(second)"
    }
    
    private func drawBorderedLabel(_ label: UILabel, backgroundColor: UIColor?, cornerRadius: Float, borderWidth: Float, borderColor: UIColor?) {
        label.layer.cornerRadius = CGFloat(cornerRadius)
        label.layer.masksToBounds = true
        label.layer.borderWidth = CGFloat(borderWidth)
        label.backgroundColor = backgroundColor
        label.layer.borderColor = borderColor?.cgColor
    }
    
    private func resizeStartButton(new size: CGFloat, font ofSize: CGFloat){
        startButtonHeightConstraint.constant = size
        startButtonWidthConstraint.constant = size
        startStopButton.titleLabel?.font = UIFont.systemFont(ofSize: ofSize)
        buttonStackView.layoutIfNeeded()
    }
    
    private func resizeWorkoutLabel(new size: CGSize, font ofSize: CGFloat) {
        workoutLabelWidthConstraint.constant = size.width
        workoutLabelHeightConstraint.constant = size.height
        workoutLabel.font = UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.semibold)
        workoutLabel.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        changeSizeBasedOnOrientation()
    }
    
    // Handle orientation changes.
    private func changeSizeBasedOnOrientation() {
        if UIDevice.current.orientation.isLandscape {
            resizeStartButton(new: 70, font: 13)
            startStopButton.circleButton(backgroundColor: UIColor.clear, borderWidth: 2, borderColor: UIColor(named: "TimerOrange"))
            buttonStackView.spacing = 60
            resizeWorkoutLabel(new: CGSize(width: 135, height: 38), font: 18)
        }
        else {
            resizeStartButton(new: 124, font: 20)
            startStopButton.circleButton(backgroundColor: UIColor.clear, borderWidth: 2, borderColor: UIColor(named: "TimerOrange"))
            buttonStackView.spacing = 40
            resizeWorkoutLabel(new: CGSize(width: 160, height: 46), font: 24)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func startStopButtonPressed(_ sender: UIButton) {
        let timer = timers[currentTimerIndex]
        if timer.timerState == .running {
            timer.pause()
            sender.setTitle(TimerFunctions.resume.rawValue, for: .normal)
        }
        else if timer.timerState == .paused {
            timer.resume()
            sender.setTitle(TimerFunctions.pause.rawValue, for: .normal)
        }
        else {
            timer.start()
            sender.setTitle(TimerFunctions.pause.rawValue, for: .normal)
        }
        
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        timers[currentTimerIndex].stop()
        currentTimerIndex = 0
        createTimers()
        updateInterface()
    }
    
    @IBAction func quitButtonPressed(_ sender: UIButton) {
        timers[currentTimerIndex].stop()
        performSegue(withIdentifier: mainMenuSegue, sender: self)
    }
}

extension RoundTimerDisplayViewController: TimerChangedDelegate {
    
    func timerValueChanged(_ timerControl: TimerControl, elapsedTimeInSeconds: TimeInterval, totalTimeInSeconds: TimeInterval) {
        if timerControl.timerDirection == .up {
            self.elapsedTimeInSeconds = Int(elapsedTimeInSeconds)
            remainingTimeInSeconds = Int(totalTimeInSeconds - elapsedTimeInSeconds)
            self.totalTimeInSeconds += 1
        } else {
            // Add 1 to the display value so that 0 isnt
            // shown as the last value for a timer.
            let remainingTime = Int(totalTimeInSeconds - elapsedTimeInSeconds) + 1
            self.elapsedTimeInSeconds = remainingTime
            remainingTimeInSeconds = remainingTime
            self.totalTimeInSeconds += 1
        }
        
    }
    
    func timerComplete(_ timerControl: TimerControl) {
        // Queue up the next timer to display.
        if let index = timers.index(0, offsetBy: currentTimerIndex + 1, limitedBy: timers.endIndex - 1) {
            currentTimerIndex = index
            let nextTimer = timers[currentTimerIndex]
            changeWorkoutLabel(nextTimer)
            nextTimer.start()
        } else if timerControl.timerDirection == .down {
            // Setting the display to 0 when the final timer expires.
            // This fixes the issue where 1 second is left showing
            // on the display when the last timer finishes.
            elapsedTimeInSeconds = 0
            remainingTimeInSeconds = 0
        }
    }
}

class TimerControl {
    private var timer: AsyncTimer!
    private(set) var timerType: TimerType
    private(set) var timerDirection: Count
    let totalTimeInSeconds: TimeInterval
    private(set) var elapsedTimeInSeconds: TimeInterval = 0
    private(set) var isTimerComplete: Bool = false
    private(set) var displayName: String
    private(set) var borderColor: UIColor!
    private(set) var textColor: UIColor!
    var delegate: TimerChangedDelegate?
    var timerState: TimerState {
        get {
            if timer.isRunning { return TimerState.running }
            else if timer.isPaused { return TimerState.paused }
            else { return TimerState.stopped }
        }
    }
    
    init(type: TimerType, name: String, direction: Count, interval: TimeInterval) {
        timerType = type
        displayName = name.uppercased()
        totalTimeInSeconds = interval
        timerDirection = direction
        selectedColorTheme()
        createTimer()
    }
    
    private func selectedColorTheme() {
        switch timerType {
        case .warmupTimer:
            borderColor = UIColor(named: "TimerYellow") ?? UIColor.yellow
        case .restTimer:
            borderColor = UIColor(named: "TimerGreen") ?? UIColor.green
        case .coolDownTimer:
            borderColor = UIColor(named: "TimerBlue") ?? UIColor.blue
        default:
            borderColor = UIColor(named: "TimerOrange") ?? UIColor.orange
        }
        textColor = UIColor(named: "TimerWhite") ?? UIColor.white
    }
    
    private func createTimer() {
        timer = AsyncTimer(queue: .main, interval: .seconds(1), repeats: true, block: {
            if self.elapsedTimeInSeconds == self.totalTimeInSeconds {
                self.timer.stop()
                self.isTimerComplete = true
                self.delegate?.timerComplete(self)
            } else {
                self.elapsedTimeInSeconds += 1
                self.delegate?.timerValueChanged(self, elapsedTimeInSeconds: self.elapsedTimeInSeconds, totalTimeInSeconds: self.totalTimeInSeconds)
            }
        })
    }
    
    func start() {
        timer.start()
    }
    
    func stop() {
        timer.stop()
    }
    
    func pause() {
        timer.pause()
    }
    
    func resume() {
        timer.resume()
    }
    
    func reset() {
        timer.restart()
    }
}











