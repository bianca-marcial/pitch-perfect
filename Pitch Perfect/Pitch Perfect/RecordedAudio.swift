//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Bianca Marcial on 3/29/15.
//  Copyright (c) 2015 Bianca Marcial. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL
    var title: String
    
    init(path: NSURL, title: String){
        self.filePathUrl = path
        self.title = title
        super.init()
    }
}
