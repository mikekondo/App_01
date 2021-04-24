//
//  SoundPlayer.swift
//  dragonball3
//
//  Created by admin on 2021/04/17.
//

import UIKit
import AVFoundation
class SoundPlayer: NSObject {
    //孫悟空身勝手の極意_音声データの読み込み
    //NSDataAssetがAssets.xcassets内のファイルや画像を管理してくれるクラス
    let gokumigate_data=NSDataAsset(name:"gokumigate")!.data
    let begita_data=NSDataAsset(name:"begitamp")!.data
    let burori_data=NSDataAsset(name:"burorimp")!.data
    //孫悟空身勝手の極意プレイヤーの変数
    //AVAudioPlayerを利用して悟空のサウンドを鳴らすインスタンス変数を用意
    var gokumigatePlayer:AVAudioPlayer!
    var begitaPlayer:AVAudioPlayer!
    var buroriPlayer:AVAudioPlayer!
    //孫悟空身勝手の極意_音声関数
    func gokumigatePlay(){
        do{
            gokumigatePlayer=try AVAudioPlayer(data:gokumigate_data)
            gokumigatePlayer.play()
        }catch{
            //エラー処理
            print("孫悟空身勝手の極意でエラーが発生しました")
        }
    }//gokumigatePlayここまで
    
    //ベジータの音声関数
    func begitaPlay(){
        do{
            begitaPlayer=try AVAudioPlayer(data:begita_data)
            begitaPlayer.play()
        }catch{
            //エラー処理
            print("ベジータでエラーが発生しました")
        }
    }//begitaPlayここまで
    
    //ブロリーの音声関数
    func buroriPlay(){
        do{
            buroriPlayer=try AVAudioPlayer(data:burori_data)
            buroriPlayer.play()
        }catch{
            //エラー処理
            print("ブロリーでエラーが発生しました")
        }
    }//buroriPlayここまで
}
