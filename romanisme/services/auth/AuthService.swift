//
//  AuthService.swift
//  romanisme
//
//  Created by Alex Aron on 15/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let shared = AuthService()
    static let user = AuthService()
    static let test = AuthService(testMode: true)
    var info: UserInfo? = (Auth.auth().currentUser != nil) ? UserInfo() : nil
    let isAuthenticated: Bool = (Auth.auth().currentUser != nil) ? true : false
    var phone: String?
    var verificationId: String? = nil
    var code: String?
    var testMode: Bool

    init(testMode isTesting: Bool = false) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = isTesting
        self.testMode = isTesting
        self.phone = (isTesting) ? "+447818998440" : nil
        self.code = (isTesting) ? "110815" : nil
    }

    func authVerify(phone phoneNumber: String? = nil, completion: @escaping (AuthError?) -> Void) {
        if (!testMode && phoneNumber == nil) {
            completion(.phoneError)
            return
        }

        let phoneValue = (testMode) ? phone : phoneNumber
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneValue!, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print(error)
                completion(.verificationError)
                return
            }
            if let verificationID = verificationID {
                self.verificationId = verificationID
                completion(nil)
            }
        }
    }

    func authConfirm(code verificationCode: String? = nil, completion: @escaping (UserInfo?, AuthError?) -> Void) {
        if (!testMode && code == nil) {
            completion(nil, .codeError)
            return
        }
        let codeValue = (testMode) ? code : verificationCode
        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationId ?? "", verificationCode: codeValue!)
        Auth.auth().signIn(with: credentials) { authData, error in
            if let error = error {
                print(error)
                completion(nil, .signInError)
                return
            }
            guard let authData = authData else { return }
            let userInfo = UserInfo(authData)
            completion(userInfo, nil)
        }
    }

    func signIn(withPhone number: String? = nil, completion: @escaping (UserInfo?, Error?) -> Void) {
        let phoneNumber = (testMode || number == nil) ? phone : number

        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) { verificationID, error in
            if let error = error {
                completion(nil, error)
                return
            }
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "", verificationCode: self.code!)
            Auth.auth().signIn(with: credential) { authData, error in
                guard let authData = authData else {
                    completion(nil, error!)
                    return
                }
                let userInfo = UserInfo(authData)
                completion(userInfo, nil)
                /*
                if authData?.user.displayName == nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = "Alex Aron"
                    changeRequest?.commitChanges { (error) in
                        if (error != nil) {
                            print(error!.localizedDescription)
                            return
                        }
                    }
                }
                if authData?.user.email == nil {
                    Auth.auth().currentUser?.updateEmail(to: "aron.alexandru@me.com") { (error) in
                        if (error != nil) {
                            print(error!.localizedDescription)
                            return
                        }
                        Auth.auth().currentUser?.sendEmailVerification { (error) in
                            if (error != nil) {
                                print(error!.localizedDescription)
                                return
                            }
                        }
                    }
                }
                */
            }
        }
    }

    static func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let logOutError {
            completion(logOutError)
        }
    }
}

// UserInfo Struct
extension AuthService {
    struct UserInfo {
        let uid: String
        let phone: String?
        let email: String?
        let emailVerified: Bool
        let name: String?
        let image: URL?
        let created: Date?
        let lastSigIn: Date?
        let isRegistered: Bool
        let hasImage: Bool
        var level: Int = 0


        init(_ authData: AuthDataResult?) {
            let user = authData!.user
            self.uid = user.uid
            self.phone = user.phoneNumber
            self.email = user.email
            self.emailVerified = user.isEmailVerified
            self.name = user.displayName
            self.image = user.photoURL
            self.created = user.metadata.creationDate
            self.lastSigIn = user.metadata.lastSignInDate
            self.isRegistered = (user.displayName != nil && user.email != nil) ? true : false
            self.hasImage = (user.photoURL != nil) ? true : false
            self.level = calculateLevel(user)
        }

        init() {
            let user = Auth.auth().currentUser!
            self.uid = user.uid
            self.phone = user.phoneNumber
            self.email = user.email
            self.emailVerified = user.isEmailVerified
            self.name = user.displayName
            self.image = user.photoURL
            self.created = user.metadata.creationDate
            self.lastSigIn = user.metadata.lastSignInDate
            self.isRegistered = (user.displayName != nil && user.email != nil) ? true : false
            self.hasImage = (user.photoURL != nil) ? true : false
            self.level = calculateLevel(user)
        }

        fileprivate func calculateLevel(_ user: User) -> Int {
            var baseLevel = 1
            baseLevel += (user.email != nil) ? 1 : 0
            baseLevel += (user.displayName != nil) ? 1 : 0
            baseLevel += (user.isEmailVerified) ? 2 : 0
            baseLevel += (user.photoURL != nil) ? 2 : 0
            
            return baseLevel
        }
        
        func updateName(to name:String, completion: @escaping (Error?) -> Void) {
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = name
            changeRequest?.commitChanges { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }

    }
}

//Auth Error
enum AuthError: Error {
    case phoneError
    case codeError
    case verificationError
    case signInError
}

extension AuthError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .phoneError:
            return NSLocalizedString("A valid phone number is required.", comment: "")
        case .codeError:
            return NSLocalizedString("You have entered an invalid verification code.", comment: "")
        case .verificationError:
            return NSLocalizedString("Verification process failed.", comment: "")
        case .signInError:
            return NSLocalizedString("Sign in authentication failed", comment: "")

        }

    }
}
