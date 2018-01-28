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
        nameTextView.value = timer.timerName
        descriptionTextView.value = timer.timerDescription
        // Warmup timer set up.
        warmupHeader.value = timer.warmupTimerEnabled
        warmupTimePicker.value = timer.warmupIntervalInSeconds.toTuple()
        warmupCountDirection.value = timer.warmupCountDirection
        
        // Round timer set up.
        roundPicker.value = timer.rounds
        roundTimePicker.value = timer.roundsIntervalInSeconds.toTuple()
        roundCountDirection.value = timer.roundsCountDirection
        
        // Rest timer set up.
        restHeader.value = timer.restTimerEnabled
        restTimePicker.value = timer.restIntervalInSeconds.toTuple()
        restCountDirection.value = timer.restCountDirection
        
        // Cool down timer setup.
        coolDownHeader.value = timer.coolDownTimerEnabled
        coolDownTimePicker.value = timer.coolDownIntervalInSeconds.toTuple()
        coolDownCountDirection.value = timer.coolDownCountDirection
        
        // Alerts set up.
        alertRoundStartingSwitchView.value = timer.startAlertEnabled
        alertRoundStartingSoundPicker.value = timer.startAlertSound
        alertRoundHalfwaySwitchView.value = timer.halfwayAlertEnabled
        alertRoundHalfwaySoundPicker.value = timer.halfwayAlertSound
        alertRoundEndingSwitchView.value = timer.endAlertEnabled
    }
    
    private func assignUserInputToTimer(timer: RoundTimer) {
        // Timer details.
        timer.timerName = nameTextView.value!
        timer.timerDescription = descriptionTextView.value
        
        // Setup warmup timer.
        timer.warmupTimerEnabled = warmupHeader.value
        timer.warmupIntervalInSeconds.fromTuple(interval: warmupTimePicker.value)
        timer.warmupCountDirection = warmupCountDirection.value
        
        // Setup rounds.
        timer.rounds = roundPicker.value
        timer.roundsIntervalInSeconds.fromTuple(interval: roundTimePicker.value)
        timer.roundsCountDirection = roundCountDirection.value
        
        // Setup rest.
        timer.restTimerEnabled = restHeader.value
        timer.restIntervalInSeconds.fromTuple(interval: restTimePicker.value)
        timer.restCountDirection = restCountDirection.value

        // Setup cooldown.
        timer.coolDownTimerEnabled = coolDownHeader.value
        timer.coolDownIntervalInSeconds.fromTuple(interval: coolDownTimePicker.value)
        timer.coolDownCountDirection = coolDownCountDirection.value
   
        // Alerts.
        timer.endAlertEnabled = alertRoundEndingSwitchView.value
        timer.halfwayAlertEnabled = alertRoundHalfwaySwitchView.value
        timer.halfwayAlertSound = alertRoundHalfwaySoundPicker.value
        timer.startAlertEnabled = alertRoundStartingSwitchView.value
        timer.startAlertSound = alertRoundStartingSoundPicker.value
    }
    
    private func updateTimer(){
        guard let timer = roundTimer else { return }
        do {
            try self.realm.write {
                self.assignUserInputToTimer(timer: timer)
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
        assignUserInputToTimer(timer: timer)
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







