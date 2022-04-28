import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var bar: UIProgressView!

    var player: AVAudioPlayer!

    let eggTimes = ["Soft": 4, "Medium": 5, "Hard": 6]
    var totalTime = 0
    var secondsPassed = 0

    var timer = Timer()

    @IBAction func hardnessSelected(_ sender: UIButton) {

        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        bar.progress = 0.0
        secondsPassed = 0
        statusLabel.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

        @objc func updateTimer() {
            if secondsPassed < totalTime {
                secondsPassed += 1
                bar.progress = Float(secondsPassed) / Float(totalTime)
            } else {
                timer.invalidate()
                statusLabel.text = "Done"
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }
        }
}
