//
//  ProfileViewController.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

class ProfileViewController: CustomViewController<ProfileView> {
    
    var presenter: ProfilePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        customView.configView(with: UserManager.shared.getUserProfileData())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        customView.setAppThemeSwitch()
    }
    
    private func setDelegates(){
        customView.delegate = self
    }
}

//MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func signOutButtonTapped() {
        AuthManager.shared.signOut { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let vc = OnbordingBuilder().buildOnbordingVC()
            vc.modalPresentationStyle = .fullScreen
            self.view.window?.rootViewController = vc
            UserDefaults.standard.addObserver(self, forKeyPath: "theme", options: [.new], context: nil)
        }
    }
    
    func languageButtonTapped() {
        self.presenter?.goToLanguagesVC()
    }
    
    func termsAndConditionsButtonTapped() {
        self.presenter?.goToTermsAndConditionsVC()
    }
    
    func changeProfileImage() {
        showImagePicker()
    }
    
    func changeTheme(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 1 ){
            print("UISwitch state is now ON")
            UserDefaults.standard.setValue(Theme.dark.rawValue, forKey: "theme")
        }
        else{
            print("UISwitch state is now Off")
            UserDefaults.standard.setValue(Theme.light.rawValue, forKey: "theme")
        }
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let chooseFromLibraryAction = UIAlertAction(title: NSLocalizedString("ImagePickerChooseFromLibrary", comment: ""), style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(chooseFromLibraryAction)
        
        let takePhotoAction = UIAlertAction(title: NSLocalizedString("ImagePickerTakePhoto", comment: ""), style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                print(NSLocalizedString("ImagePickerCameraError", comment: ""))
            }
        }
        alertController.addAction(takePhotoAction)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("ImagePickerCancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            UserManager.shared.updateUserAvatar(avatar: editedImage) { error in
                if error != nil {
                    print("Error is occured during saving new user avatar")
                }
            }
            customView.updateProfileImage(editedImage)
            dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            UserManager.shared.updateUserAvatar(avatar: originalImage) { error in
                if error != nil {
                    print("Error is occured during saving new user avatar")
                }
            }
            customView.updateProfileImage(originalImage)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

extension ProfileViewController: ProfilePresenterViewProtocol {
    
}
