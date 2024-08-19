import UIKit
import SnapKit

class LogInViewController: UIViewController {
    
    private var titleLabel: UILabel =  {
        let view = UILabel()
        view.text = "Login"
        view.font = UIFont.boldSystemFont(ofSize: 28)
        return view
    }()
    
    private var emailTextField: UITextField =  {
        let view = UITextField()
        view.placeholder = "Email"
        view.borderStyle = .roundedRect
        view.keyboardType = .emailAddress
        view.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()
    
    private var passwordTextField: UITextField =  {
        let view = UITextField()
        view.placeholder = "Password"
        view.isSecureTextEntry = true
        view.borderStyle = .roundedRect
        view.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()
    
    private var loginButton: UIButton =  {
        let view = UIButton()
        view.setTitle("Log in", for: .normal)
        view.backgroundColor = .gray
        view.tintColor = .white
        view.layer.cornerRadius = 20
        view.isEnabled = false
        view.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private var forgotPasswordLabel: UILabel =  {
        let view = UILabel()
        view.text = "Forgot your password?"
        view.font = UIFont.boldSystemFont(ofSize: 14)
        return view
    }()
    
    private var newAccountLabel: UILabel =  {
        let view = UILabel()
        view.text = "Don't have an account? Join"
        view.font = UIFont.boldSystemFont(ofSize: 18)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loadUserData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateLoginButton()
    }
    
    private func updateLoginButton() {
       
        let isValidEmail = isValidEmail(emailTextField.text ?? "")
       
        let isValidPassword = (passwordTextField.text?.count ?? 0) >= 6
        
        if isValidEmail && isValidPassword {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .black
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .gray
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    @objc func loginButtonTapped() {
           saveUserData() // Сохранение данных при нажатии кнопки
           print("Данные сохранены")
       }
       
       private func saveUserData() {
           let defaults = UserDefaults.standard
           defaults.set(emailTextField.text, forKey: "userEmail")
           defaults.set(passwordTextField.text, forKey: "userPassword")
       }
       
       private func loadUserData() {
           let defaults = UserDefaults.standard
           emailTextField.text = defaults.string(forKey: "userEmail")
           passwordTextField.text = defaults.string(forKey: "userPassword")
       }
       
    
    func setupUI(){
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(forgotPasswordLabel)
        forgotPasswordLabel.snp.makeConstraints {make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(newAccountLabel)
        newAccountLabel.snp.makeConstraints {make in
            make.top.equalTo(forgotPasswordLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
