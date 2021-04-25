import SwiftUI

struct ContentView: View {
    @State var answerNumber=0
    @State var preAnswerNumber=0
    @State var bottan=2%2
    let soundPlayer=SoundPlayer()
    var body: some View {
        VStack {
            if answerNumber==0{
                Text("ドラゴンボールキャラ当てゲーム")
                    .background(Color.orange)
                    .frame(maxWidth: .infinity)
                    .font(.title)
                    .padding(.bottom)
                }//if answerNumber==0ここまで
            else if answerNumber==1{
                Image("goku").resizable().aspectRatio(contentMode: .fit)
                let outputText="だれだこいつ？？"
                let outputAnswer="孫悟空"
                if(bottan%2==0){
                    Text(outputText)
                    .padding(.bottom)
                }
                if(bottan%2==1){
                    Text(outputAnswer)
                    .padding(.bottom)
                }
            }//else if 1ここまで
            else if answerNumber==2{
                Image("begita").resizable().aspectRatio(contentMode: .fit)
                let outputText2="だれだこいつ？？"
                let outputAnswer2="ベジータ"
                if(bottan%2==0){
                    Text(outputText2)
                    .padding(.bottom)
                }
                if(bottan%2==1){
                    Text(outputAnswer2)
                    .padding(.bottom)
                }
            }//else if 2ここまで
            else if answerNumber==3{
                Image("burori").resizable().aspectRatio(contentMode: .fit)
                let outputText3="だれだこいつ"
                let outputAnswer3="ブロリー"
                if(bottan%2==0){
                    Text(outputText3)
                    .padding(.bottom)
                }
                if(bottan%2==1){
                    Text(outputAnswer3)
                    .padding(.bottom)
                }
            }//elseここまで
            //ボタンランダム
            if bottan%2==1{
            Button(action: {
                bottan=bottan+1
                print("タップされたよ")
                answerNumber=Int.random(in: 1...3)
                while(answerNumber==preAnswerNumber){
                    answerNumber=Int.random(in: 1...3)
                }
                preAnswerNumber=answerNumber
                //キャラクターサウンド
                if(answerNumber==1){
                    soundPlayer.gokumigatePlay()
                }
                if(answerNumber==2){
                    soundPlayer.begitaPlay()
                }
                if(answerNumber==3){
                    soundPlayer.buroriPlay()
                }
            }) {
                if answerNumber==0{
                    Text("スタート")
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .background(Color.pink)
                    .foregroundColor(Color.white)
                    
                }
                else{
                    Text("つぎへ")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .background(Color.pink)
                        .foregroundColor(Color.white)

                }
            }
        }//if bottan%2==1ここまで
            //ボタン切替
            if bottan%2==0{
            Button(action: {
                bottan=bottan+1
                print("つぎへ")
                
            }) {
                if answerNumber==0{
                    Text("サウンドがヒントだぞ")
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .background(Color.pink)
                    .foregroundColor(Color.white)
                }
                else{
                    Text("こたえ")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .background(Color.pink)
                        .foregroundColor(Color.white)

                }
            }
        }//if bottan%2==0ここまで
        }
        .padding(.bottom)//VStack ここまで
        }// var body: some Viewここまで
}//struct ContentView: Viewここまで
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

