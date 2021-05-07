//
//  CollectionViewController.swift
//  PhotoApp
//
//  Created by kaito12 on 2021/05/01.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class CollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //写真のURLを入れる箱
    var images = [String]()
    
    //ViewVCからのキーワードを入れる箱
    var KeyWord = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        images(keyword: KeyWord)
        
        
        // セルの大きさを設定
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (collectionView.frame.width/3)-1, height:(collectionView.frame.height/3)-1)
        
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        
        collectionView.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? MyCollectionViewCell
        
        let imagesView = URL(string: self.images[indexPath.row] as String)!
        
        //cellのイメージに入れる
        cell?.imageView.sd_setImage(with: imagesView, completed: nil)
        
        //写真のサイズを変更
        cell?.imageView.contentMode = .scaleAspectFill
        
        
        return cell!
    }
    
    
    
    func images(keyword: String){
        
        let url = "https://pixabay.com/api/?key=17955967-b038e5aa9dc8239c7e2df032b&q=\(keyword)"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
            
            case .success:
                
                for i in 0...19{
                    
                    let json:JSON = JSON(response.data as Any)
                    
                    let imageString = json["hits"][i]["webformatURL"].string
                    
                    
                    
                    self.images.append(imageString!)
                    
                }
                
                break
                
            case .failure(let error):
                print(error)
                
                
                break
                
            }
            
            self.collectionView.reloadData()
            
        }
        
        
        
    }
    
    
}
