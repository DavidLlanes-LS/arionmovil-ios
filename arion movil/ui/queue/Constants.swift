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
    
    
    
    
}
