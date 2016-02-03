//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//:
//: ## High Shelf Filter
//: ### A high-Shelf filter takes an audio signal as an input, and cuts out the low-frequency components of the audio signal, allowing for the higher frequency components to "Shelf through" the filter.
//:
import XCPlayground
import AudioKit

let bundle = NSBundle.mainBundle()
let file = bundle.pathForResource("mixloop", ofType: "wav")
var player = AKAudioPlayer(file!)
player.looping = true

var highShelfFilter = AKHighShelfFilter(player)

//: Set the parameters here
highShelfFilter.cutOffFrequency = 10000 // Hz
highShelfFilter.gain = 0 // dB

AudioKit.output = highShelfFilter
AudioKit.start()

//: User Interface Set up

class PlaygroundView: AKPlaygroundView {
    
    //: UI Elements we'll need to be able to access
    var cutOffFrequencyLabel: Label?
    var gainLabel: Label?
    
    override func setup() {
        addTitle("High Shelf Filter")
        
        addLabel("Audio Player")
        addButton("Start", action: "start")
        addButton("Stop", action: "stop")
        
        addLabel("High Shelf Filter Parameters")
        
        addButton("Process", action: "process")
        addButton("Bypass", action: "bypass")
        
        cutOffFrequencyLabel = addLabel("Cut-off Frequency: 10000 Hz")
        addSlider("setCutOffFrequency:", value: 10000, minimum: 10000, maximum: 22050)
        
        gainLabel = addLabel("Gain: 0 dB")
        addSlider("setGain:", value: 0, minimum: -40, maximum: 40)
        
    }
    
    //: Handle UI Events
    
    func start() {
        player.play()
    }
    
    func stop() {
        player.stop()
    }
    
    func process() {
        highShelfFilter.start()
    }
    
    func bypass() {
        highShelfFilter.bypass()
    }
    func setCutOffFrequency(slider: Slider) {
        highShelfFilter.cutOffFrequency = Double(slider.value)
        let cutOffFrequency = String(format: "%0.1f", highShelfFilter.cutOffFrequency)
        cutOffFrequencyLabel!.text = "Cut-off Frequency: \(cutOffFrequency) Hz"
    }
    
    func setGain(slider: Slider) {
        highShelfFilter.gain = Double(slider.value)
        let gain = String(format: "%0.1f", highShelfFilter.gain)
        gainLabel!.text = "gain: \(gain) dB"
    }
    
}

let view = PlaygroundView(frame: CGRectMake(0, 0, 500, 550));
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
XCPlaygroundPage.currentPage.liveView = view

//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
