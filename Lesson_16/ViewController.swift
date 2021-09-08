//
//  ViewController.swift
//  Lesson_16
//
//  Created by Evgeniy Nosko on 8.09.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    //      UserDefaults - используется для сохранения ПРОСТЫХ данных!
    //      UserDefaults - сохраняет даные в ОТДЕЛЬНОМ файле!
    //      Keychain - используется для сохранения ВАЖНЫХ данных (данные авторизации и т.д)!
    
    let key = "TextFieldTextKey"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        сохранение данных
        let value = UserDefaults.standard.string(forKey: key)
        //        сохранение данных с типом Any
        //        let value = UserDefaults.standard.value(forKey: key) as? String
        //         чтение данных структуры (unwrap значения)
                let string = UserDefaults.standard.string(forKey: key) ?? ""
        //        JSONDecoder - преобразовывает обратно
                let profile  =  try? JSONDecoder().decode(Profile.self, from: Data(base64Encoded: string) ?? Data())
        
        textField.text = profile?.name
        
        //       удаление данных из UserDefaults
        UserDefaults.standard.removeObject(forKey: key)
        

    }
    
    //    сохранение данных по нажатию на кнопку
    @IBAction func buttonPressed() {
        let  text = textField.text ?? ""
        
//        сохранение данных структуры
        let profile = Profile(name: text, surname: text)
//        JSONEncoder - преобразовывает в формат JSON
        let string = try? JSONEncoder().encode(profile).base64EncodedString()
        UserDefaults.standard.setValue(text, forKey: key)
        UserDefaults.standard.synchronize()
        
    }
    
}

//  сохранение структуры (конформит протоколу - Codable(преобразовывает в строку))
struct Profile: Codable {
    let name: String
    let surname: String
}

