//
//  DataUtil.swift
//  AppStore
//
//  Created by SecurityIBK on 2018. 4. 8..
//  Copyright © 2018년 HoSeong Choi. All rights reserved.
//

import Foundation

class DataUtil{

    func parseRawData(rawData: [String:Any]) -> Array<FreeFinanceApp>?{
        
        var arrayEntry:Array<Any> = []
        if let feedData = rawData["feed"] as? [String:Any] {
            if let entryData = feedData["entry"] as? Array<Any>{
              arrayEntry = entryData
            }
        }
        
        if arrayEntry.count > 0{
            return self.parseEntryData(arrayEntry: arrayEntry)
        }
        
        return nil
    }
    
    func parseEntryData(arrayEntry: Array<Any>) -> Array<FreeFinanceApp>?{
        var arrApp:Array<FreeFinanceApp> = []
        for indexEntry in arrayEntry{
            if let _indexEntry = indexEntry as? [String:Any]{
                let appInfo = FreeFinanceApp()
                appInfo.category = _indexEntry["category"] as? [String:Any]
                appInfo.id = _indexEntry["id"] as? [String:Any]
                appInfo.imArtist = _indexEntry["im:artist"] as? [String:Any]
                appInfo.imContentType = _indexEntry["im:contentType"] as? [String:Any]
                appInfo.imImage = _indexEntry["im:image"] as? Array<Any>
                appInfo.imName = _indexEntry["im:name"] as? [String:Any]
                appInfo.imPrice = _indexEntry["im:price"] as? [String:Any]
                appInfo.imReleaseData = _indexEntry["im:releaseData"] as? [String:Any]
                appInfo.link = _indexEntry["link"] as? [String:Any]
                appInfo.title = _indexEntry["title"] as? [String:Any]
                
                arrApp.append(appInfo)
            }
        }
        return arrApp
    }
}
