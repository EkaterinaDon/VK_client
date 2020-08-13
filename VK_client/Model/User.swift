//
//  Friends.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 05/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

struct Friend {
    let name: String
    let image: UIImage?
    let photo: [UIImage?]
}

final class Friends {
    
    static func generateFriends() -> [Friend] {
        let ziggy = Friend(name: "Ziggy Stardust", image: UIImage(named: "ziggy"), photo: [UIImage(named: "ziggy_foto1"), UIImage(named: "ziggy_foto2"), UIImage(named: "ziggy_foto3"), UIImage(named: "ziggy_foto4"), UIImage(named: "ziggy_foto5")])
        
        let majorTom = Friend(name: "Major Tom", image: UIImage(named: "majorTom"), photo: [UIImage(named: "majorTom_foto1"), UIImage(named: "majorTom_foto2"), UIImage(named: "majorTom_foto3"), UIImage(named: "majorTom_foto4"), UIImage(named: "majorTom_foto5")])
        
        let pierrot = Friend(name: "Pierrot", image: UIImage(named: "pierrot"), photo: [UIImage(named: "pierrot1"), UIImage(named: "pierrot2"), UIImage(named: "pierrot3"), UIImage(named: "pierrot4"), UIImage(named: "pierrot5")])
        
        let aladdinSane = Friend(name: "Aladdin Sane", image: UIImage(named: "aladdinSane"), photo: [UIImage(named: "aladdinSane1"), UIImage(named: "aladdinSane2"), UIImage(named: "aladdinSane3"), UIImage(named: "aladdinSane4"), UIImage(named: "aladdinSane5")])
        
        let halloweenJack = Friend(name: "Halloween Jack", image: UIImage(named: "halloweenJack"), photo: [UIImage(named: "halloweenJack1"), UIImage(named: "halloweenJack2"), UIImage(named: "halloweenJack3"), UIImage(named: "halloweenJack4"), UIImage(named: "halloweenJack5")])
        
        let whiteDuke = Friend(name: "Thin White Duke", image: UIImage(named: "whiteDuke"), photo: [UIImage(named: "whiteDuke1"), UIImage(named: "whiteDuke2"), UIImage(named: "whiteDuke3"), UIImage(named: "whiteDuke4"), UIImage(named: "whiteDuke5")])
        
        let soulMan = Friend(name: "Soul Man", image: UIImage(named: "soulMan"), photo: [UIImage(named: "soulMan1"), UIImage(named: "soulMan2"), UIImage(named: "soulMan3"), UIImage(named: "soulMan4"), UIImage(named: "soulMan5")])
        
        let goblinKing = Friend(name: "Jareth the Goblin King", image: UIImage(named: "goblinKing"), photo: [UIImage(named: "goblinKing1"), UIImage(named: "goblinKing2"), UIImage(named: "goblinKing3"), UIImage(named: "goblinKing4"), UIImage(named: "goblinKing5")])
        
        let lordByron = Friend(name: "Screaming Lord Byron", image: UIImage(named: "lordByron"), photo: [UIImage(named: "lordByron1"), UIImage(named: "lordByron2"), UIImage(named: "lordByron3"), UIImage(named: "lordByron4"), UIImage(named: "lordByron5")])
        
        let dj = Friend(name: "DJ", image: UIImage(named: "dj"), photo: [UIImage(named: "dj1"), UIImage(named: "dj2"), UIImage(named: "dj3"), UIImage(named: "dj4"), UIImage(named: "dj5")])
        
        let blindProphet = Friend(name: "Blind Prophet", image: UIImage(named: "blindProphet"), photo: [UIImage(named: "blindProphet1"), UIImage(named: "blindProphet2"), UIImage(named: "blindProphet3"), UIImage(named: "blindProphet4"), UIImage(named: "blindProphet5")])
        
        return [ziggy, majorTom, pierrot, aladdinSane, halloweenJack, whiteDuke, soulMan,
        goblinKing, lordByron, dj,
        blindProphet]
    }
}
