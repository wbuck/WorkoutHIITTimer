//
//  RoundTimerTableViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-13.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit
import RealmSwift

class RoundTimerViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextView: TextFieldView!
    @IBOutlet weak var descriptionTextView: TextFieldView!
    @IBOutlet weak var warmupHeader: HeaderSwitchView!
    @IBOutlet weak var warmupTimePicker: TimePickerControlView!
    @IBOutlet weak var roundPicker: RoundPickerControlView!
    @IBOutlet weak var roundTimePicker: TimePickerControlView!
    @IBOutlet weak var restHeader: HeaderSwitchView!
    @IBOutlet weak var restTimePicker: TimePickerControlView!
    @IBOutlet weak var coolDownHeader: HeaderSwitchView!
    @IBOutlet weak var coolDownTimePicker: TimePickerControlView!
    @IBOutlet weak var alertRoundStartingSwitchView: SwitchControlView!
    @IBOutlet weak var alertRoundStartingSoundPicker: SoundPickerControlView!
    @IBOutlet weak var alertRoundEndingSwitchView: SwitchControlView!
    @IBOutlet weak var timerDirectionSegmentView: SegmentControlView!
    @IBOutlet weak var contentView: UIView!
    
    let realm = try! Realm()
    
    var timerRepository: RoundTimerRepository!
    var selectedTimerId: String?
    var roundTimer: RoundTimer!
    
    
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
        
        if let id = selectedTimerId {
            roundTimer = timerRepository.get(timer: UUID(uuidString: id)!)
        } else {
            roundTimer = RoundTimer()
        }
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
            if let timePickerView = control as? TimePickerControlView {
                timePickerView.separatorIsHidden = true
            }
        }
        assignRoundTimerValues()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("ROUND MEMORY WARNING")
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
       saveTimer()
    }
    
    private func assignRoundTimerValues() {
        nameTextView.value = roundTimer.timerName
        descriptionTextView.value = roundTimer.timerDescription
        // Warmup timer set up.
        warmupHeader.value = roundTimer.warmupTimerEnabled
        warmupTimePicker.value = roundTimer.warmupIntervalInSeconds.toTuple()
        
        // Round timer set up.
        roundPicker.value = roundTimer.rounds
        roundTimePicker.value = roundTimer.roundsIntervalInSeconds.toTuple()
        
        // Rest timer set up.
        restHeader.value = roundTimer.restTimerEnabled
        restTimePicker.value = roundTimer.restIntervalInSeconds.toTuple()
        
        // Cool down timer setup.
        coolDownHeader.value = roundTimer.coolDownTimerEnabled
        coolDownTimePicker.value = roundTimer.coolDownIntervalInSeconds.toTuple()
        
        // Options set up.
        alertRoundStartingSwitchView.value = roundTimer.startAlertEnabled
        alertRoundStartingSoundPicker.value = roundTimer.startAlertSound
        alertRoundEndingSwitchView.value = roundTimer.endAlertEnabled
        timerDirectionSegmentView.value = roundTimer.countDirection
    }
    
    private func assignUserInputToTimer() {
        // Timer details.
        roundTimer.timerName = nameTextView.value!
        roundTimer.timerDescription = descriptionTextView.value
        
        // Setup warmup timer.
        roundTimer.warmupTimerEnabled = warmupHeader.value
        roundTimer.warmupIntervalInSeconds.fromTuple(interval: warmupTimePicker.value)
        
        // Setup rounds.
        roundTimer.rounds = roundPicker.value
        roundTimer.roundsIntervalInSeconds.fromTuple(interval: roundTimePicker.value)
        
        // Setup rest.
        roundTimer.restTimerEnabled = restHeader.value
        roundTimer.restIntervalInSeconds.fromTuple(interval: restTimePicker.value)

        // Setup cooldown.
        roundTimer.coolDownTimerEnabled = coolDownHeader.value
        roundTimer.coolDownIntervalInSeconds.fromTuple(interval: coolDownTimePicker.value)
   
        // Options.
        roundTimer.endAlertEnabled = alertRoundEndingSwitchView.value
        roundTimer.startAlertEnabled = alertRoundStartingSwitchView.value
        roundTimer.startAlertSound = alertRoundStartingSoundPicker.value
        roundTimer.countDirection = timerDirectionSegmentView.value
    }
    
    
    private func saveTimer() {
        // TODO: - Remove this line.
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        _ = timerRepository.addOrUpdate(timer: roundTimer, updateFunc: assignUserInputToTimer)
        performSegue(withIdentifier: "GoToTimer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let roundTimerDisplayController = segue.destination as? RoundTimerDisplayViewController {
            roundTimerDisplayController.roundTimer = roundTimer
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







