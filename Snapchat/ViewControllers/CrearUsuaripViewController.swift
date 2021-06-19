//
//  CrearUsuaripViewController.swift
//  Snapchat
//
//  Created by Jilmer Mayta on 6/18/21.
//  Copyright © 2021 Jilmer Mayta. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CrearUsuaripViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFlied: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextFlied.text!, completion: { (user, error) in
            print("Intentando crear un usuario")
            if error != nil {
                print("Se presento el siguiente error al crear el usuario: \(error!)")
                let alerta = UIAlertController(title: "Error al crear usuario", message: "Ocurrio el siguiente error al crear usuario: \(error!)", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Volver a intentar", style: .default, handler: nil)
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
            }else{
                print("El usuario fue creado exitosamente")
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                let alerta = UIAlertController(title: "Creacion de Usaurio", message: "Usuario: \(self.passwordTextFlied.text!) se creo correctamente. ", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default , handler: { (UIAlertAction) in self.performSegue(withIdentifier: "iniciousuariocreado", sender: nil)
                })
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
                
            }
        })
    }

    @IBAction func RegresarInicioSesionTapped(_ sender: Any) {
        performSegue(withIdentifier: "regresariniciosesionsegue", sender: nil)
    }
    
}
