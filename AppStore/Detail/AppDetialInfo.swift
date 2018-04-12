//
//  AppDetialInfo.swift
//  AppStore
//
//  Created by SecurityIBK on 2018. 4. 11..
//  Copyright © 2018년 HoSeong Choi. All rights reserved.
//

import Foundation

class AppDetailInfo{
    var isGameCenterEnabled:Bool?
    var screenshotUrls:Array<Any>?
    var screenshotDatas:[Int:Data] = [:]
    var ipadScreenshotUrls:Array<Any>?
    var appletvScreenshotUrls:Array<Any>?
    var artworkUrl60:String?
    var artworkUrl60Data:Data?
    var artworkUrl512:String?
    var artworkUrl512Data:Data?
    var artworkUrl100:String?
    var artworkUrl100Data:Data?
    var artistViewUrl:String?
    var kind:String?
    var features:Array<Any>?
    var advisories:Array<Any>?
    var supportedDevices:Array<Any>?
    var averageUserRatingForCurrentVersion:Float?
    var trackCensoredName:String?
    var languageCodesISO2A:Array<Any>?
    var fileSizeBytes:String?
    var sellerUrl:String?
    var contentAdvisoryRating:String?
    var userRatingCountForCurrentVersion:Int?
    var trackViewUrl:String?
    var trackContentRating:String?
    var releaseDate:String?
    var sellerName:String?
    var genreIds:Array<Any>?
    var formattedPrice:String?
    var currency:String?
    var wrapperType:String?
    var version:String?
    var artistId:Int?
    var artistName:String?
    var genres:Array<Any>?
    var price:Float?
    var description:String?
    var bundleId:String?
    var primaryGenreId:Int?
    var isVppDeviceBasedLicensingEnabled:Bool?
    var trackId:Int?
    var trackName:String?
    var primaryGenreName:String?
    var minimumOsVersion:String?
    var currentVersionReleaseDate:String?
    var releaseNotes:String?
    var averageUserRating:Float?
    var userRatingCount:Int?

    init(appDetail : [String:Any]) {
        isGameCenterEnabled = appDetail["isGameCenterEnabled"] as? Bool
        screenshotUrls = appDetail["screenshotUrls"] as? Array<Any>
        ipadScreenshotUrls = appDetail["ipadScreenshotUrls"] as? Array<Any>
        appletvScreenshotUrls = appDetail["appletvScreenshotUrls"] as? Array<Any>
        artworkUrl60 = appDetail["artworkUrl60"] as? String
        artworkUrl512 = appDetail["artworkUrl512"] as? String
        artworkUrl100 = appDetail["artworkUrl100"] as? String
        artistViewUrl = appDetail["artistViewUrl"] as? String
        kind = appDetail["kind"] as? String
        features = appDetail["features"] as? Array<Any>
        advisories = appDetail["advisories"] as? Array<Any>
        supportedDevices = appDetail["supportedDevices"] as? Array<Any>
        averageUserRatingForCurrentVersion = appDetail["averageUserRatingForCurrentVersion"] as? Float
        trackCensoredName = appDetail["trackCensoredName"] as? String
        languageCodesISO2A = appDetail["languageCodesISO2A"] as? Array<Any>
        fileSizeBytes = appDetail["fileSizeBytes"] as? String
        sellerUrl = appDetail["sellerUrl"] as? String
        contentAdvisoryRating = appDetail["contentAdvisoryRating"] as? String
        userRatingCountForCurrentVersion = appDetail["userRatingCountForCurrentVersion"] as? Int
        trackViewUrl = appDetail["trackViewUrl"] as? String
        trackContentRating = appDetail["trackContentRating"] as? String
        releaseDate = appDetail["releaseDate"] as? String
        sellerName =  appDetail["sellerName"] as? String
        genreIds = appDetail["genreIds"] as? Array<Any>
        formattedPrice = appDetail["formattedPrice"] as? String
        currency = appDetail["currency"] as? String
        wrapperType = appDetail["wrapperType"] as? String
        version = appDetail["version"] as? String
        artistId = appDetail["artistId"] as? Int
        artistName = appDetail["artistName"] as? String
        genres = appDetail["genres"] as? Array<Any>
        price = appDetail["genres"] as? Float
        description = appDetail["description"] as? String
        bundleId = appDetail["bundleId"] as? String
        primaryGenreId = appDetail["primaryGenreId"] as? Int
        isVppDeviceBasedLicensingEnabled = appDetail["isVppDeviceBasedLicensingEnabled"] as? Bool
        trackId = appDetail["trackId"] as? Int
        trackName = appDetail["trackName"] as? String
        primaryGenreName = appDetail["primaryGenreName"] as? String
        minimumOsVersion = appDetail["minimumOsVersion"] as? String
        currentVersionReleaseDate = appDetail["currentVersionReleaseDate"] as? String
        releaseNotes = appDetail["releaseNotes"] as? String
        averageUserRating = appDetail["averageUserRating"] as? Float
        userRatingCount = appDetail["userRatingCount"] as? Int
    }
}
