//
//  MapView.swift
//  MyMap
//
//  Created by admin on 2021/04/11.
//

import SwiftUI
import MapKit
//UIViewRepresentableプロトコルの指定
//UIViewRepresentableプロトコルを指定するとmakeUIViewメソッドやupdateUIViewメソッドの二つのメソッドが記述可能となる
struct MapView:UIViewRepresentable {
    //検索キーワード(この時、serchKeyの中は東京タワーがセットされる
    let searchKey:String
    //マップ種類
    let mapType: MKMapType
    //表示するViewを作成するときに実行
    func makeUIView(context:Context)->MKMapView{
        //MKMapViewのインスタンス生成
        //return MkMapView()と書いてもいいが、Swiftではreturnが省略できる
        MKMapView()
    }//makeUIView ここまで

//表示したViewが更新されるたびに実行
func updateUIView(_ uiView: MKMapView,context: Context){
    //入力された文字をデバッグエリアに追加
    print(searchKey)
    //マップ種類の設定
    uiView.mapType=mapType
    //CLGeocoderインスタンスを取得(CLGeocoderクラスを使うと緯度経度から住所を検索することができるし住所から緯度経度も計算できる)
    let geocoder=CLGeocoder()
    //入力された文字から位置情報を取得
    //第一引数には場所が入り、第二はcompletionHandlerが固定、placemarksには取得に成功した位置情報が入り、値がない、存在しない場所だとerrorが入る
    geocoder.geocodeAddressString(
        searchKey, completionHandler:{(placemarks,error) in
            //リクエストの結果が存在し、1件目の情報から位置情報を取り出す、placemarksには取得に成功した位置情報が格納されている
            //unwrapPlacemarksにはアンラップされたplacemarksの情報が格納されている
            //unwrapPlacemarksには複数の位置情報(検索結果)が格納されている配列である
            //.firstを使うことでunwrapPlacemarksの配列の一つ目(最も目的に近い位置情報)が取り出される
            //.firstPlacemarkには取得した位置情報の最初の1件目が格納されている、そして緯度経度、高度などの情報が格納されているlocationを取り出す、locationもオプショナル型なのでアンラップする
            if let unwrapPlacemarks=placemarks ,
               let firstPlacemark=unwrapPlacemarks.first ,
               let location=firstPlacemark.location{
                
                //位置情報から緯度経度をtargetCoordinateに取り出す
                let targetCoordinate=location.coordinate
                //緯度経度をデバッグエリアに表示
                print(targetCoordinate)
                //MKPointAnnotationインスタンスを取得し、ピンを生成(MKPointAnootationでは、ピンをおくための機能が利用できる)MKPointAnnotationはクラス
                let pin = MKPointAnnotation()
                //ピンを置く場所に緯度経度を設定
                pin.coordinate=targetCoordinate
                //ピンのタイトルを設定
                pin.title=searchKey
                //ピンを地図におく
                uiView.addAnnotation(pin)
                //経度緯度を中心にして半径500mの範囲を表示
                uiView.region=MKCoordinateRegion(
                    center: targetCoordinate,
                    latitudinalMeters: 500.0,
                    longitudinalMeters: 500.0)
            }//if ここまで
        })//geocoderここまで
}//updateUIViewここまで
    
}//MapView ここまで

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        //MapViewを利用する時は初期値を設定する必要がある(初期値=東京タワー)
        MapView(searchKey:"東京タワー",mapType: .standard)
    }
}
