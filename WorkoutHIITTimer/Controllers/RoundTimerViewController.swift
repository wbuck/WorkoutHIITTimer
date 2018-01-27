//
//  RoundTimerTableViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-13.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit
import RealmSwift

class RoundTimerViewController: UIViewController, TimersController {

    @IBOutlet weak var nameTextView: TextFieldView!
    @IBOutlet weak var descriptionTextView: TextFieldView!
    @IBOutlet weak var warmupHeader: HeaderSwitchView!
    @IBOutlet weak var warmupTimePicker: TimePickerControlView!
    @IBOutlet weak var warmupCountDirection: SegmentControlView!
    @IBOutlet weak var roundPicker: RoundPickerControlView!
    @IBOutlet weak var roundTimePicker: TimePickerControlView!
    @IBOutlet weak var roundCountDirection: SegmentControlView!
    @IBOutlet weak var restHeader: HeaderSwitchView!
    @IBOutlet weak var restTimePicker: TimePickerControlView!
    @IBOutlet weak var restCountDirection: SegmentControlView!
    @IBOutlet weak var coolDownHeader: HeaderSwitchView!
    @IBOutlet weak var coolDownTimePicker: TimePickerControlView!
    @IBOutlet weak var coolDownCountDirection: SegmentControlView!
    @IBOutlet weak var alertRoundStartingSwitchView: SwitchControlView!
    @IBOutlet weak var alertRoundStartingSoundPicker: SoundPickerControlView!
    @IBOutlet weak var alertRoundHalfwaySwitchView: SwitchControlView!
    @IBOutlet weak var alertRoundHalfwaySoundPicker: SoundPickerControlView!
    @IBOutlet weak var alertRoundEndingSwitchView: SwitchControlView!
    @IBOutlet weak var contentView: UIView!
    
    let realm = try! Realm()
    
    var timers: Timers?
    var roundTimer: RoundTimer?
    
    // The key represents the tag of each picker
    // view control. The value is the name of
    // the height constraint.
    let pickerHeightConstraintNames = [1 : "WarmupTimePickerHeight",
                                       2 : "RoundPickerHeight",
                                       3 : "RoundTimePickerHeight",
                                       4 : "RestTimePickerHeight",
                                       5 : "CoolDownTimePickerHeight",
                                       6 : "AlertStartingSoundPickerHeight",
                                       7 : "AlertHalfwaySoundPickerHeight"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        for control in contentView.subviews {
            switch(control) {
            case let header as HeaderSwitchView:
                header.delegate = self
            case let picker as ExpandablePickerView:
                picker.delegate = self
            default:
                break;
            }
        }
        assignRoundTimerValues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("ROUND MEMORY WARNING")
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        
        if roundTimer == nil {
            saveTimer()
        }
        else {
            updateTimer()
        }
    }
    
    private func assignRoundTimerValues() {
        guard let timer = roundTimer else { return }
        nameTextView.value = timer.timerDetails?.timerName
        descriptionTextView.value = timer.timerDetails?.timerDescription
        // Warmup timer set up.
        warmupHeader.value = timer.warmupTimerEnabled
        if let warmupTimer = timer.warmupTimer {
            warmupTimePicker.value = warmupTimer.intervalInSeconds.toTuple()
            warmupCountDirection.value = warmupTimer.timerDirection
        }
        // Round timer set up.
        roundPicker.value = timer.rounds
        if let mainTimer = timer.roundTimer {
            roundTimePicker.value = mainTimer.intervalInSeconds.toTuple()
            roundCountDirection.value = mainTimer.timerDirection
        }
        // Rest timer set up.
        restHeader.value = timer.restTimerEnabled
        if let restTimer = timer.restTimer {
            restTimePicker.value = restTimer.intervalInSeconds.toTuple()
            restCountDirection.value = restTimer.timerDirection
        }
        // Cool down timer setup.
        coolDownHeader.value = timer.coolDownTimerEnabled
        if let coolDownTimer = timer.coolDownTimer {
            coolDownTimePicker.value = coolDownTimer.intervalInSeconds.toTuple()
            coolDownCountDirection.value = coolDownTimer.timerDirection
        }
        // Alerts set up.
        alertRoundStartingSwitchView.value = (timer.timerAlerts?.startAlertEnabled)!
        alertRoundStartingSoundPicker.value = (timer.timerAlerts?.startAlertSound)!
        alertRoundHalfwaySwitchView.value = (timer.timerAlerts?.halfwayAlertEnabled)!
        alertRoundHalfwaySoundPicker.value = (timer.timerAlerts?.halfwayAlertSound)!
        alertRoundEndingSwitchView.value = (timer.timerAlerts?.endAlertEnabled)!
    }
    
    private func assignInputToTimer(timer: RoundTimer) {
        // Timer details.
        timer.timerDetails = TimerDetails()
        timer.timerDetails?.timerName = nameTextView.value!
        timer.timerDetails?.timerDescription = descriptionTextView.value
        timer.timerDetails?.timerType = .round
        
        // Setup warmup timer.
        timer.warmupTimerEnabled = warmupHeader.value
        if warmupHeader.value {
            timer.warmupTimer = SubTimer()
            timer.warmupTimer?.intervalInSeconds.fromTuple(interval: warmupTimePicker.value)
            timer.warmupTimer?.timerDirection = warmupCountDirection.value
        }
        // Setup rounds.
        timer.rounds = roundPicker.value
        timer.roundTimer = SubTimer()
        timer.roundTimer?.intervalInSeconds.fromTuple(interval: roundTimePicker.value)
        timer.roundTimer?.timerDirection = roundCountDirection.value
        
        // Setup rest.
        timer.restTimerEnabled = restHeader.value
        if restHeader.value {
            timer.restTimer = SubTimer()
            timer.restTimer?.intervalInSeconds.fromTuple(interval: restTimePicker.value)
            timer.restTimer?.timerDirection = restCountDirection.value
        }
        // Setup cooldown.
        timer.coolDownTimerEnabled = coolDownHeader.value
        if coolDownHeader.value {
            timer.coolDownTimer = SubTimer()
            timer.coolDownTimer?.intervalInSeconds.fromTuple(interval: coolDownTimePicker.value)
            timer.coolDownTimer?.timerDirection = coolDownCountDirection.value
        }
        
        // Alerts.
        timer.timerAlerts = TimerAlerts()
        timer.timerAlerts?.endAlertEnabled = alertRoundEndingSwitchView.value
        timer.timerAlerts?.endAlertSound = "End Beep"
        timer.timerAlerts?.halfwayAlertEnabled = alertRoundHalfwaySwitchView.value
        timer.timerAlerts?.halfwayAlertSound = alertRoundHalfwaySoundPicker.value
        timer.timerAlerts?.startAlertEnabled = alertRoundStartingSwitchView.value
        timer.timerAlerts?.startAlertSound = alertRoundStartingSoundPicker.value
    }
    
    private func updateTimer(){
        guard let timer = roundTimer else { return }
        do {
            try self.realm.write {
                self.assignInputToTimer(timer: timer)
            }
        }
        catch {
            print("Failed to save data to DB. \((error as NSError).userInfo.description)")
        }
    }
    
    private func saveTimer() {
        // TODO: - Remove this line.
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let timer = RoundTimer()
        assignInputToTimer(timer: timer)
        do {
            try self.realm.write {
                self.timers?.roundTimers.append(timer)
            }
        }
        catch {
            print("Failed to save data to DB. \((error as NSError).userInfo.description)")
        }
    }
}

extension RoundTimerViewController: HeaderSwitchViewDelegate {
    
    func headerValueChanged(_ sender: HeaderSwitchView, value: Bool) {
        print("Switch \(value)")
    }
}

extension RoundTimerViewController: PickerControlViewDelegate {
    
    func pickerControlViewTapped(_ sender: PickerView) {
        
        let constraintName = pickerHeightConstraintNames[sender.id]
        // Find constraint with the specified id.
        let heightConstraint = sender.constraints.filter { (constraint) -> Bool in
            return constraint.identifier == constraintName
        }
        
        // Determine next postion (expanded or collapsed).
        let nextPosition: PickerViewState = sender.pickerViewState == .collapsed ?
            .expanded : .collapsed
        
        heightConstraint.first?.constant =  CGFloat(nextPosition.rawValue)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}







