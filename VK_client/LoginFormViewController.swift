//
//  LoginFormViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 29/07/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class LoginFormViewController: UIViewController {

    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        //присвоим его скроллвью
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        loginInput.text = "admin"
        passwordInput.text = "123456"
        
        startAnimation()
    
    }
    
    
    //клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        //получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        //добавляем отступ внизу скроллвью, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        //устанавливаем отступ внизу скроллвью равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    //подписываемся на сообщения центра уведомлений, которые рассылает клавиатура
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //подписываемся на уведомление, которое приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //подписываемся на уведомление, когда клавиатура пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //метод отписки от уведомлений, когда контроллер исчезает
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    //исчезновение клавиатуры при клике по пустому месту
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkUserData()
        
        if !checkResult {
            showLoginError()
        }
        
        return checkResult
    }
    
    func checkUserData() -> Bool {
        guard let login = loginInput.text, let password = passwordInput.text else { return false }
        
        //если данные не верны, показываем ошибку
        if login == "admin" && password == "123456" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        //создаем алертКонтроллер
        let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные", preferredStyle: .alert)
        //создаем кнопку для алертКонтроллер
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        //добавляем кнопку на алертКонтроллер
        alert.addAction(action)
        //показываем алертКонтроллер
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let login = loginInput.text!
        let password = passwordInput.text!
        
        if login == "admin" && password == "123456" {
            print("Успешная авторизация")
        } else {
            print("Неправильный логин или пароль")
        }
        
        startAnimation()
 
    }
    
    
    func startAnimation() {
        indicatorView.shared.showOverlay(self.view, dots_color: UIColor.lightGray, bg_color: UIColor.black, dots_count: 2)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            indicatorView.shared.hideOverlayView()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
