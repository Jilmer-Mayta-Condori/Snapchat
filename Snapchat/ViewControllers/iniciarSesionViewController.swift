//
//  ViewController.swift
//  Snapchat
//
//  Created by Jilmer Mayta on 6/18/21.
//  Copyright © 2021 Jilmer Mayta. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(use, error) in
            print("Intentando Iniciar Sesion")
            if error != nil {
                print("Se presento el siguiente error: \(error!)")
                let alert = UIAlertController(title: "Error Inicio Sesion", message: "Error al iniciar sesion, si no tiene una cuenta primero debe crear una", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Crear Usuario", style: .default) {(UIAlertAction) in self.performSegue(withIdentifier: "crearusuariosegue", sender: nil)}
                let btnCancel = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
                
                alert.addAction(btnOK)
                alert.addAction(btnCancel)
                self.present(alert, animated: true, completion: nil)
            }else{
                print("Inicion de sesion Exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    
    @IBAction func CrearUsuarioTapped(_ sender: Any) {
        performSegue(withIdentifier: "crearusuariosegue", sender: nil)
    }
}

