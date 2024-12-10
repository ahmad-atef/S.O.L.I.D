//
//  main.swift
//  OpenClosePrinciple
//
//  Created by Ahmad Atef on 10/12/2024.
//

import Foundation

print("Example (1) Implementing Open/Close Principle with Inheritance")

class Question {

    
    let prompt: String
    let id: Int
    var answer: Any?
    
    init(prompt: String, id: Int) {
        self.prompt = prompt
        self.id = id
    }
    
    var field: String { fatalError("Template property, Must override!") }
    
    func display() {
        print("\(prompt) \n \t \(field)")
    }
    
    func answer(_ input: Any) {
        print("\t\t --> \(input)")
        self.answer = input
        if validate(input) {
            print("✅")
        } else {
            print("❌")
        }
    }
    
    func validate(_ input: Any) -> Bool {
        fatalError("Template method, Must override!")
    }
}


class TextQuestion: Question {
    override var field: String {
        return "[TextField]"
    }
    
    override func validate(_ input: Any) -> Bool {
        guard let input = input as? String else { return false }
        return input.count > 0
    }
}

class BooleanQuestion: Question {
    override var field: String {
        return "[Switch]"
    }
    
    override func validate(_ input: Any) -> Bool {
        guard let input = input as? Bool else { return false }
        return input
    }
}

class NumericQuestion: Question {
    override var field: String {
        return "[Stepper]"
    }
    override func validate(_ input: Any) -> Bool {
        guard let input = input as? Int else { return false }
        return input > 0
    }
}

class FileQuestion: Question {
    override var field: String {
        return "[FilePicker]"
    }
    override func validate(_ input: Any) -> Bool {
        guard let input = input as? URL else { return false }
        return input.isFileURL
    }
}

class QuestionSolver {
    static func solve(_ question: Question) {
        switch question.id {
        case 1:
            question.answer("Atef")
        case 2:
            question.answer("The Shawshank Redemption")
        case 3:
            question.answer(0)
        case 4:
            question.answer(true)
        case 5:
            question.answer(URL(fileURLWithPath: "/Users/atef/Desktop/swift-quiz/swift-quiz/main.swift"))
        default:
            fatalError()
        }
    }
}

class Quiz {
    let questions: [Question]
    init(questions: [Question]) {
        self.questions = questions
    }
}

class QuizSolver {
    let quiz: Quiz
    
    init(quiz: Quiz) {
        self.quiz = quiz
    }
    
    func solve() {
        quiz.questions.forEach { question in
            question.display()
            QuestionSolver.solve(question)
        }
    }
}

let quiz = Quiz(
    questions: [
        TextQuestion(prompt: "What is your name?", id: 1),
        TextQuestion(prompt: "What is favorite Movie?", id: 2),
        NumericQuestion(prompt: "How many pets do you have?", id: 3),
        BooleanQuestion(prompt: "Are you married ?", id: 4),
        FileQuestion(prompt: "Upload your resume", id: 5)
    ]
)

QuizSolver(quiz: quiz).solve()



print("Example (2) Implementing Open/Close Principle with Protocol Oriented Programming")

protocol Printable {
    func printDetails() -> String
}

class Car: Printable {
    let make: String
    let model: String
    let price: Double
    
    init(make: String, model: String, price: Double) {
        self.make = make
        self.model = model
        self.price = price
    }
    
    func printDetails() -> String {
        "\(model) • \(make) • \(price)"
    }
}

class Bike: Printable {
    let brand: String
    let type: String
    let price: Double
    
    init(brand: String, type: String, price: Double) {
        self.brand = brand
        self.type = type
        self.price = price
    }
    
    func printDetails() -> String {
        "\(type) • \(brand) • \(price)`"
    }
}

let car = Car(make: "Toyota", model: "Corolla", price: 10000)
let bike = Bike(brand: "Honda", type: "Scooter", price: 5000)

func printDetails(_ printables: Printable...) {
    for printable in printables {
        print(printable.printDetails())
    }
}

printDetails(car, bike)


