//
//  ViewController.swift
//  iOS3-HW11 - Федышин Матвей
//
//  Created by matt_spb on 13.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var smallCircleLabel: UILabel!
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var isWorkTime = true
    var isStarted = false {
        willSet {
            print(newValue)
        }
    }

    lazy var timer = Timer()
    var timeCount = 0

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: - Actions

    @IBAction func resetButtonAction(_ sender: UIButton) {
        timer.invalidate()
        isWorkTime = true
        isStarted = false
        updateViews()
    }


    @IBAction func playButtonAction(_ sender: UIButton) {
        if isStarted {
            isStarted.toggle()
            timer.invalidate()
        } else {
            isStarted.toggle()
            startTimer()
        }
        setButtonImage()
    }

    // MARK: - Timer

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }

    @objc func countDown() {
        timeCount -= 1

        if timeCount == 0 {
            isWorkTime.toggle()
            updateViews()
        }

        let time = convertSecondsToMinutesAndSeconds(timeCount)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        stopwatchLabel.text = timeString
    }

    private func convertSecondsToMinutesAndSeconds(_ seconds: Int) -> (Int, Int) {
        return (seconds / 60, seconds % 60)
    }

    private func makeTimeString(minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }

    // MARK: - Setup Views

    private func setButtonImage() {
        if !isStarted {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .default)

            let largePlayIcon = UIImage(systemName: "play", withConfiguration: largeConfig)

            playButton.setImage(largePlayIcon, for: .normal)

        } else {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .default)

            let largePauseIcon = UIImage(systemName: "pause", withConfiguration: largeConfig)

            playButton.setImage(largePauseIcon, for: .normal)
        }
    }
    private func setupPlayButton() {
        setButtonImage()
        playButton.layer.masksToBounds = true
        playButton.layer.cornerRadius = playButton.bounds.height / 2

        if isWorkTime {
            playButton.tintColor = Colors.greenRGB
        } else {
            playButton.tintColor = Colors.redRGB
        }
    }

    private func setupStopwatchLabel() {

        if isWorkTime {
            timeCount = TimeCount.workTime
            let time = convertSecondsToMinutesAndSeconds(timeCount)
            let timeString = makeTimeString(minutes: time.0, seconds: time.1)
            stopwatchLabel.text = timeString
            stopwatchLabel.textColor = Colors.greenRGB
        } else {
            timeCount = TimeCount.restTime
            let time = convertSecondsToMinutesAndSeconds(timeCount)
            let timeString = makeTimeString(minutes: time.0, seconds: time.1)
            stopwatchLabel.text = timeString
            stopwatchLabel.textColor = Colors.redRGB
        }
    }

    private func setColors() {
        if isWorkTime {
            timerLabel.layer.borderColor = Colors.green
            smallCircleLabel.layer.borderColor = Colors.green
            resetButton.tintColor = Colors.greenRGB
        } else {
            timerLabel.layer.borderColor = Colors.red
            smallCircleLabel.layer.borderColor = Colors.red
            resetButton.tintColor = Colors.redRGB
        }
    }

    private func updateViews() {
        setupPlayButton()
        setupStopwatchLabel()
        setColors()
    }

    private func setupViews() {
        setupPlayButton()
        setupStopwatchLabel()
        setColors()

        timerLabel.layer.masksToBounds = true
        timerLabel.layer.cornerRadius = timerLabel.bounds.height / 2
        timerLabel.layer.borderWidth = 5

        smallCircleLabel.layer.masksToBounds = true
        smallCircleLabel.layer.cornerRadius = smallCircleLabel.bounds.height / 2
        smallCircleLabel.layer.borderWidth = 2.5
        smallCircleLabel.layer.borderColor = Colors.green
    }
}

// MARK: - Const

private enum TimeCount {
    static var workTime: Int {
//        return 25 * 60
        return 1 * 10
    }

    static var restTime: Int {
//        return 5 * 60
        return 1 * 10
    }
}

private enum Colors {
    static var green: CGColor {
        return CGColor(red: 0.39, green: 0.78, blue: 0.65, alpha: 1.00)
    }

    static var red: CGColor {
        return CGColor(red: 0.98, green: 0.43, blue: 0.43, alpha: 1.00)
    }

    static var greenRGB = #colorLiteral(red: 0.3921568627, green: 0.7843137255, blue: 0.6470588235, alpha: 1)
    static var redRGB = #colorLiteral(red: 0.9803921569, green: 0.431372549, blue: 0.431372549, alpha: 1)
}
