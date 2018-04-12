//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by SecurityIBK on 2018. 4. 11..
//  Copyright © 2018년 HoSeong Choi. All rights reserved.
//

import Foundation
import UIKit

let SCREENSHOT_WIDTH:CGFloat = 181
let SCREENSHOT_HEIGHT:CGFloat = 348

class AppDetailViewController : UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var userRatingCount: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var advisoryRatingLabel: UILabel!
    @IBOutlet weak var verticalScrollView: UIScrollView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var bundleId:String = ""
    var id:String = ""
    var resultCount:Int = 0
    var arrAppDetail:Array<AppDetailInfo> = []
    
    var _appInfo:FreeFinanceApp?
    var appInfo:FreeFinanceApp?{
        get{
            return _appInfo
        }
        set(newVal){
            _appInfo = newVal
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let app = _appInfo{
            if let _idInfo = app.id{
                if let attribute = _idInfo["attributes"] as? [String:Any]{
                    self.bundleId = attribute["im:bundleId"] as! String
                    self.id = attribute["im:id"] as! String
                }
            }
        }else{
            self.showAlert(strMessage: "앱 정보가 없습니다.")
        }
        
        if id != ""{
            self.getAppDetail(id: id)
        }
        
        
    }
    
    func getAppDetail(id: String){
        
        let url = URL(string: "https://itunes.apple.com/lookup?id=\(id)&country=kr")

        if url != nil {
            var request = URLRequest(url: url!)
            request.httpMethod = "get"

            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: {(data: Data?, response:URLResponse?, error:Error?) in
                guard error == nil && data != nil else{
                    if let err = error {
                        print(err.localizedDescription)
                        self.showAlert(strMessage: "앱 상세 정보를 받아오는데 실패하였습니다.")
                    }
                    return
                }

                if let _data = data{
                    do{
                        let jsonAppDetail = try JSONSerialization.jsonObject(with: _data, options: .mutableContainers) as! [String:Any]
                        
                        if let resultCount = jsonAppDetail["resultCount"] as? Int{
                            self.resultCount = resultCount
                        }
                        
                        if self.resultCount > 0{
                            if  let result = jsonAppDetail["results"] as? Array<Any>{
                                for index in 0...self.resultCount-1{
                                    let appInfo = result[index] as! [String:Any]
                                    self.arrAppDetail.append(AppDetailInfo(appDetail: appInfo))
                                }
                                DispatchQueue.main.async {
                                    self.settingAppDetailInfo()
                                }
                            }
                        }else{
                            self.showAlert(strMessage: "앱 상세 정보가 없습니다.")
                        }
                    }catch{

                    }
                }
            })
            //실행
            task.resume()

        }
    }
    
    func settingAppDetailInfo(){

        if self.arrAppDetail.count > 0{
            let appDetailInfo = self.arrAppDetail[0]
            
            //앱 이미지
            if let arworkUrl60 = appDetailInfo.artworkUrl60{
                DispatchQueue(label: arworkUrl60).async {
                    let url = URL(string: arworkUrl60)
                    
                    if let arworkUrl60Data = try? Data(contentsOf: url!){
                  
                        appDetailInfo.artworkUrl60Data = arworkUrl60Data
                        /*
                        DispatchQueue.main.async {
                            self.appImage.image = UIImage(data: arworkUrl60Data)
                        }
                        */
                    }else{
                        self.showAlert(strMessage: "앱 이미지를 설정하는데 실패하였습니다.")
                    }
                }
                
            }
            
            if let arworkUrl100 = appDetailInfo.artworkUrl100{
                DispatchQueue(label: arworkUrl100).async {
                    let url = URL(string: arworkUrl100)
                    let arworkUrl100Data = try? Data(contentsOf: url!)
                    if arworkUrl100Data != nil{
                        appDetailInfo.artworkUrl100Data = arworkUrl100Data
                        /*
                         DispatchQueue.main.async {
                         self.appImage.image = UIImage(data: arworkUrl100Data)
                         }
                        */
                    }else{
                        self.showAlert(strMessage: "앱 이미지를 설정하는데 실패하였습니다.")
                    }
                }
                
            }
            
            
            if let arworkUrl512 = appDetailInfo.artworkUrl512{
                DispatchQueue(label: arworkUrl512).async {
                    let url = URL(string: arworkUrl512)
                    if let arworkUrl512Data = try? Data(contentsOf: url!){
                        appDetailInfo.artworkUrl512Data = arworkUrl512Data
                        DispatchQueue.main.async {
                            self.appImage.image = UIImage(data: arworkUrl512Data)
                        }
                    }else{
                        self.showAlert(strMessage: "앱 이미지를 설정하는데 실패하였습니다.")
                    }
                }
                
            }
            
            //스크린샷
            if let arrScreenshotURL = appDetailInfo.screenshotUrls{
                for indexURL in 0...arrScreenshotURL.count-1{
                    let strURL = arrScreenshotURL[indexURL] as! String
                    DispatchQueue(label: "screenshot").async {
                        let url = URL(string: strURL)
                        let imageData = try? Data(contentsOf: url!)
                        if imageData != nil{
                            appDetailInfo.screenshotDatas[indexURL] = imageData
                        }else{
                            print("에러 발생")
                        }
                    
                      DispatchQueue.main.async {
                            self.settingScreenShot(screenshotDic: appDetailInfo.screenshotDatas, keyIndex: indexURL)
                        }
                    }
                }
            }
            
            //앱 이름
            if let appName = appDetailInfo.trackName{
                self.trackName.text = appName
            }
            
            //등급
            if let rating = appDetailInfo.averageUserRating{
                self.userRatingLabel.text = String(rating)
            }
            
            //평가
            if let count = appDetailInfo.userRatingCount{
                self.userRatingCount.text = String(count)
            }
            
            //랭킹
            //if let
            
            //장르
            if let arrGenre = appDetailInfo.genres, arrGenre.count > 0{
                let firstGerne = arrGenre[0] as! String
                self.genreLabel.text = firstGerne
            }

            if let advisoryRating = appDetailInfo.contentAdvisoryRating{
                self.advisoryRatingLabel.text = advisoryRating
            }
            
            if let description = appDetailInfo.description{
                self.descriptionLabel.text = description
            }
            
        }else{
            self.showAlert(strMessage: "앱 상세 정보가 없습니다.")
        }
    }
    
    
    func settingScreenShot(screenshotDic : [Int:Data], keyIndex: Int){

        if let screenshotData = screenshotDic[keyIndex]{
            let imageView = UIImageView()
            imageView.image = UIImage(data: screenshotData)
            imageView.contentMode = .scaleAspectFill
            let xPosition = (SCREENSHOT_WIDTH + CGFloat(25)) * CGFloat(keyIndex)

            imageView.frame = CGRect(x: xPosition, y: 0, width: SCREENSHOT_WIDTH, height: SCREENSHOT_HEIGHT)
            
            self.scrollView.contentSize.width = SCREENSHOT_WIDTH * CGFloat(screenshotDic.count) + (CGFloat(25) * CGFloat(screenshotDic.count-1))
            self.scrollView.addSubview(imageView)
        }
        
    }
    
    
    func showAlert(strMessage: String){
        
        let alertController = UIAlertController(title: "알림",message: strMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
            
        }
        
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
}
