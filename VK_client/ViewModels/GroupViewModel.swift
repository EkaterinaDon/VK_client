//
//  GroupViewModel.swift
//  VK_client
//
//  Created by Ekaterina on 24.12.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

struct GroupViewModel {
    let nameText: String
    let avatarImage: UIImage?
}

final class GroupViewModelFactory {
    
    private let photoService = PhotoService()
    
    func constructViewModel(from groups: [Group]) -> [GroupViewModel] {
        return groups.compactMap(self.viewModel)
    }
    
    private func viewModel(from group: Group) -> GroupViewModel {
        let nameText = group.name
        var avatarImage: UIImage?
        photoService.photo(url: group.photo) { image in
            avatarImage = image
        }
        
        return GroupViewModel(nameText: nameText, avatarImage: avatarImage)
    }
    
}
