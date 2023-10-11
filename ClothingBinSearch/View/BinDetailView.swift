//
//  BinDetailView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/10/09.
//

import SwiftUI

struct BinDetailView: View {
    @State var screenWidth: CGFloat
    @Binding var isShowingBinDetailView: Bool
    @Binding var currentMarkerAddress: String
    @State private var copiedText = ""

    
    var body: some View {
        VStack {
            
            HStack {
                Text("의류수거함 정보")
                    .bold()
                Spacer()
                Button {
                    //
                    isShowingBinDetailView = false
                    
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
//            .padding(5)
            .padding(10)
            .padding(.vertical ,3)

            
            HStack{
                Text("주소")
                    .padding(.horizontal, 4)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.lightGrayColor)
                    )
                Button {
                    copyToClipboard(text: "\(currentMarkerAddress)")
                } label: {
                    Text("\(currentMarkerAddress)")
                        .foregroundColor(.black)
                }

                Button {
                    // 텍스트 복사
                    copyToClipboard(text: "\(currentMarkerAddress)")
                } label: {
                    Image(systemName: "doc.on.doc")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 14)
                        .foregroundColor(.middleGrayColor)
                }
                                Spacer()


            }
            .padding(.horizontal,10)
            HStack{
                Button(action: {
                               openNaverMapWithSearch(address: currentMarkerAddress)
                           }) {
                               Text("네이버 지도로 보기")
                                   .font(.footnote)
                                   .padding(10)
                                   .background(Color.lightGrayColor)
                                   .foregroundColor(.black)
                                   .cornerRadius(10)
                           }
            }
            .padding()
            Spacer()
        }
        .frame(width: screenWidth, height: 200)
        .background(.white)
       
        
    }
    private func copyToClipboard(text: String) {
           let pasteboard = UIPasteboard.general
           pasteboard.string = text
           
           // 복사 완료 메시지 등 추가적인 로직을 여기에 구현할 수 있습니다.
           
           // 예시로, 복사된 텍스트를 저장해두고 알림창으로 출력합니다.
               copiedText = text
        if copiedText != "" {
            showAlert()
        }
       }
    private func showAlert() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                     let rootViewController = windowScene.windows.first?.rootViewController else {
                   return
               }
               
               let alert = UIAlertController(title: "복사 완료", message: "\(copiedText)\n클립보드에 복사되었습니다.", preferredStyle: .alert)
               
               alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
               
               rootViewController.present(alert, animated: true, completion:nil)
           }
    private func openNaverMapWithSearch(address: String) {
            let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlString = "nmap://search?query=\(encodedAddress)"
            
            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // 네이버 지도 앱이 설치되어 있지 않은 경우 처리할 로직을 여기에 추가할 수 있습니다.
                print("네이버 지도 앱을 열 수 없습니다.")
            }
        }
}

struct BinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BinDetailView(screenWidth: CGFloat(300), isShowingBinDetailView: .constant(true), currentMarkerAddress: .constant("주소예시"))
    }
}
