//
//  main.swift
//  InterfaceSegregationPrinciple
//
//  Created by Ahmad Atef on 11/12/2024.
//

import Foundation

protocol Acceleretable {
    var speed: Float { get set }
}

class Car: Acceleretable, Speedometer {
    var speed: Float = 0
    
    let transmission: Transmission
    let radioManager: RadioManagement
    
    init(
        speed: Float = 0 ,
        transmission: Transmission = SixSpeedTransmitter(),
        radioManager: RadioManagement = DefaultRadioManager()
    ) {
        self.speed = speed
        self.transmission = transmission
        self.radioManager = radioManager
    }
}

/// This type is responsible for regulating the current speed for the car.
/// It is the same as used in eScoters, if the speed went higher than the max allowed speed which is 20 Km/hr
/// this type is responsible for setting the current speed to the max.
class SpeedRegulator {
    var acceleratable: Acceleretable
    let maxSpeed: Float
    
    init(acceleratable: Acceleretable, maxSpeed: Float) {
        self.acceleratable = acceleratable
        self.maxSpeed = maxSpeed
    }

    func regulate() {
        if acceleratable.speed > maxSpeed {
            acceleratable.speed = maxSpeed
        }
    }
}

let car = Car()
car.speed = 100
print(car.speed)
let speedReulator = SpeedRegulator(acceleratable: car, maxSpeed: 20)
speedReulator.regulate()
print(car.speed)


protocol Speedometer {
    var speed: Float { get }
}

protocol Transmission {
    var currentGear: Int { get set }
    var totalGearCount: Int { get }
    func shiftUp()
    func shiftDown()
}

class SixSpeedTransmitter: Transmission {
    var currentGear: Int = 1
    var totalGearCount: Int = 6

    func shiftUp() {
        guard currentGear < totalGearCount else { return }
        self.currentGear += 1
    }

    func shiftDown() {
        // minimum is 1
        guard currentGear > 1 else { return }
        currentGear -= 1
    }
}

class TransimisionController {
    var carTransmitter: Transmission
    let speedometer: Speedometer
    
    init(carTransmitter: Transmission, speedometer: Speedometer) {
        self.carTransmitter = carTransmitter
        self.speedometer = speedometer
    }
    
    func control() {
        // car speed : 45
        // current gear: 1
        // after controlling, the current gear should go up
        if speedometer.speed > maxSpeed(for: carTransmitter.currentGear) {
            carTransmitter.shiftUp()
        } else if speedometer.speed < minimumSpeedFor(currentGear: carTransmitter.currentGear) {
            carTransmitter.shiftDown()
        }
    }
    
    private func maxSpeed(for gear: Int) -> Float {
        Float(carTransmitter.currentGear * 20)
    }
    
    private func minimumSpeedFor(currentGear: Int) -> Float {
        let lessOneGear = currentGear - 1
        return Float(lessOneGear * 20)
    }
}
let speedometer = Car() // car is a spedometer, or you can create a quick type here
let transmissionController = TransimisionController(
    carTransmitter: car.transmission,
    speedometer: car
)
car.speed = 50
print("Speed: \(car.speed) \t Current Gear: \(car.transmission.currentGear)")
transmissionController.control()
print("Speed: \(car.speed) \t Current Gear: \(car.transmission.currentGear)")
transmissionController.control()
print("Speed: \(car.speed) \t Current Gear: \(car.transmission.currentGear)")
transmissionController.control()
print("Speed: \(car.speed) \t Current Gear: \(car.transmission.currentGear)")
transmissionController.control()




enum RadioStatus {
    case on
    case off
}

protocol RadioManagement {
    var status: RadioStatus { get set }
    var currentStation: String { get set }
    func turnOffRadio()
}

class DefaultRadioManager: RadioManagement {
    var status: RadioStatus = .on
    var currentStation: String = "98.2"
    
    func turnOffRadio() {
        status = .off
        currentStation = ""
    }
}


class RadioController {
    let speedometer: Speedometer
    let radioManagement: RadioManagement
    
    init(speedometer: Speedometer, radioManagement: RadioManagement) {
        self.speedometer = speedometer
        self.radioManagement = radioManagement
    }

    func update() {
        if speedometer.speed > 100 {
            radioManagement.turnOffRadio()
        }
    }
}

let fiatCar = Car()
let radionController = RadioController(
    speedometer: fiatCar,
    radioManagement: fiatCar.radioManager
)

fiatCar.speed = 20
print("speed: \(fiatCar.speed)")
radionController.update()
print("Current Radio Station: \(fiatCar.radioManager.currentStation), Radio Status: \(fiatCar.radioManager.status)")

fiatCar.speed = 80
print("speed: \(fiatCar.speed)")
radionController.update()
print("Current Radio Station: \(fiatCar.radioManager.currentStation), Radio Status: \(fiatCar.radioManager.status)")


fiatCar.speed = 101
print("speed: \(fiatCar.speed)")
radionController.update()
print("Current Radio Station: \(fiatCar.radioManager.currentStation), Radio Status: \(fiatCar.radioManager.status)")
