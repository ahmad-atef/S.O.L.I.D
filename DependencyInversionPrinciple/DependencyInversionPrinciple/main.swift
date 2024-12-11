//
//  main.swift
//  DependencyInversionPrinciple
//
//  Created by Ahmad Atef on 11/12/2024.
//

import Foundation

protocol EmailServiceProtocol {
    func send(message: String, to recipient: String)
}

class EmailService: EmailServiceProtocol {
    func send(message: String, to recipient: String) {
        print("Sending message: \(message) \t to recipient: \(recipient)")
    }
}

class User {
    private let emailService: EmailServiceProtocol
    init(emailService: EmailServiceProtocol = EmailService()) {
        self.emailService = emailService
    }

    func sendWelcomeEmail() {
        emailService.send(message: "Welcome to Carly", to: "ahamd.atef@carly.com")
    }
}


let hrUser = User()
hrUser.sendWelcomeEmail()

class MockEmailService: EmailServiceProtocol {
    func send(message: String, to recipient: String) {
        print("Sending Mock message: \(message) \t to recipient: \(recipient)")
    }
}

let mockUser = User(emailService: MockEmailService())
mockUser.sendWelcomeEmail()
