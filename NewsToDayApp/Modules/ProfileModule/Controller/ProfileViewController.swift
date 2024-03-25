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
    }
    
    private func setDelegates(){
        customView.delegate = self
    }
}

extension ProfileViewController: ProfilePresenterViewProtocol {
    func render(with user: FirestoreUser) {
        customView.configView(with: user)
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
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
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
            customView.updateProfileImage(editedImage)
            dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            customView.updateProfileImage(originalImage)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
