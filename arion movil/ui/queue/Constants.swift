//
//  Constants.swift
//  arion movil
//
//  Created by Daniel Luna on 02/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

struct Constants {
    
    static let keyPlayerId: String = "player_id"
    static let keyIsAuth: String = "is_auth"
    static let keyUserId: String = "user_id"
    static let keyUserName: String = "user_id"
    static let keyLocationId: String  = "location_id"
    static let keyCookie:String = "cookie"
    static let keyOpenPay:String = "pk_1643e9f30f534e32afb0cd51e8b2693a"
    static let idOpenPayMerchant:String = "mqjmzuhblyqymlbmg3y8"
    
    
    // MARK: - Dialog card purchases messages
    
    static let succesPurchaseMsg = "La compra se realizó correctamente"
    static let declinedCardMsg  = "La tarjeta fue declinada"
    static let expiredCardMsg  = "La tarjeta ha expirado"
    static let foundLessCardMsg  = "La tarjeta no tiene fondos suficientes"
    static let restrictedCardMsg  = "El banco ha restringido la tarjeta"
    static let retainedCardMsg = "La tarjeta ha sido retenida"
    static let needsBankAuthMsg  = "Se requiere solicitar al banco autorización para realizar este movimiento"
    static let failPurchaseDefaultMsg  = "La compra no se ha podido realizar, por favor intenta con otro método de pago"
    static let failAddCardDefaultMsg  = "No se ha podido agregar este método de pago, por favor revisa tus datos e intenta de nuevo"
    
    
    // MARK: - change profile messages and change options
    static let succesChangeMsg = "Se realizó el cambio exitosamente"
    static let emailExistsMsg = "Este email ya existe"
    static let wrongCredentialMsg = "Por favor verifica que tu contraseña sea correcta e intentalo de nuevo"
    static let generalChangeErrorMsg = "Ocurrio un error inesperado,por favor intenta nuevamente más tarde"
    static let missmatchPasswordsMsg = "Las contraseñas no coinciden"
    static let errorInvalidEmailsMsg = "Por favor ingresa un email valido"
    static let errorMinCharactersPasswordMsg = "La contraseña debe tener al menos 6 caracteres"
    static let changePasswordAndEmailOption = 3
    static let changePasswordOption = 2
    static let changeEmailOption = 1
    
    
    //MARK: dimens
    static let sizeTextTitle:Float = 17.0
    static let sizeTextPageTitle:Float = 34
    static let sizeTextBody:Float = 17
    static let sizeTextSecondaryText:Float = 15
    static let sizeTextCaption:Float = 13
    static let sizeTextFormControls:Float = 17
}
