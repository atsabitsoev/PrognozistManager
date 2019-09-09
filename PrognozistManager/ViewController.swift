//
//  ViewController.swift
//  PrognozistManager
//
//  Created by Ацамаз Бицоев on 09/09/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tfMainTitle: UITextField!
    @IBOutlet weak var tfAdditionalTitle: UITextField!
    @IBOutlet weak var tfForecastName: UITextField!
    @IBOutlet weak var tfMultiplier: UITextField!
    @IBOutlet weak var tfPartOfBank: UITextField!
    @IBOutlet weak var tfEventDate: UITextField!
    @IBOutlet weak var tvAuthorsDescribtion: UITextView!
    @IBOutlet weak var datePickerDay: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    private func sendDataToFireStore() {
        
        let db = Firestore.firestore()
        
        let forecastDateString = getDateInString(from: datePickerDay.date)
        db.collection(forecastDateString).addDocument(data: ["mainTitle" : tfMainTitle.text ?? "",
            "additionalTitle" : tfAdditionalTitle.text ?? "",
            "forecastName" : tfForecastName.text ?? "",
            "multiplier" : tfMultiplier.text ?? "",
            "partOfBank" : tfPartOfBank.text ?? "",
            "date" : tfEventDate.text ?? "",
            "authorsDescribtion" : tvAuthorsDescribtion.text ?? "",
            "authorsName" : ["Алексей Орлов",
                             "Артем Остапов",
                             "Айваз Магомедов"].randomElement()!])
    }
    
    
    private func getDateInString(from date: Date) -> String {
        
        let calendar = Calendar(identifier: .gregorian)
        let timeZoneMoscow = TimeZone(identifier: "Europe/Moscow")!
        let dateComponentsToday = calendar.dateComponents(in: timeZoneMoscow, from: date)
        guard let day = dateComponentsToday.day,
            let month = dateComponentsToday.month,
            let year = dateComponentsToday.year else {
                return ""
        }
        
        return "\(day)\\\(month)\\\(year)"
    }
    
    
    @IBAction func butSendTapped(_ sender: UIButton) {
        
        sendDataToFireStore()
    }
    

}

