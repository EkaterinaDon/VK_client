//
//  News.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 30/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

struct News {

    let name: String
    let date: String
    let text: String
    let image: UIImage?
    let photo: [UIImage?]

    init(name: String, date: String, text: String, image: UIImage?, photo: [UIImage?]) {
        self.name = name
        self.date = date
        self.image = image
        self.text = text
        self.photo = photo
    }

}

final class myNews {
    
    static func generateNews() -> [News] {
        let news1 = News(name: "RollingStone", date: "JUNE 16, 2016", text: "Ziggy Stardust’: How Bowie Created the Alter Ego That Changed Rock. “What I did with my Ziggy Stardust was package a totally credible, plastic rock & roll singer – much better than the Monkees could ever fabricate,” David Bowie later said of his definitive alter ego. “I mean, my plastic rock & roller was much more plastic than anybody’s. And that was what was needed at the time.”  In fact, what Bowie concocted on 1972’s The Rise and Fall of Ziggy Stardust and the Spiders From Mars was more than just a fresh, clever concept. Ziggy was a tight and cohesive song cycle that laid out a visionary direction for pop music, setting a new standard for rock & roll theatricality while delivering his synthetic ideal with campy sex appeal and raw power.", image: UIImage(named: "news1"), photo: [UIImage(named: "news1_1"), UIImage(named: "news1_2")])

        let news2 = News(name: "NYTimes", date: "MARCH 20, 2018", text: "When Ms. Anderson, the musician and composer, and the widow of Bowie’s longtime collaborator Lou Reed, remembers him now, he is laughing, teasing, finding joy. Bowie was “very, very smart,” she said, but not self-serious — he was “hilarious, and had a great sense of playfulness. The kind of guy who would wear some pantaloons. What other rock star did that?”", image: UIImage(named: "news2"), photo: [UIImage(named: "news2_1"), UIImage(named: "news2_2"), UIImage(named: "news2_3")])
        return[news1, news2].sorted(by: {$0.date > $1.date})
    }

}


extension News: Equatable {
    static func == (lhs: News, rhs: News) -> Bool {
        return
            lhs.name == rhs.name &&
                lhs.date == rhs.date &&
                lhs.text == rhs.text &&
                lhs.image == rhs.image &&
                lhs.photo == rhs.photo
    }
}
