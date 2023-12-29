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
    
    @State var isShowingNMapAlert: Bool = false
    @State var isShowingAppleMapAlert: Bool = false
    @State var isShowingReportAlert: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("의류수거함 정보")
                    .bold()
                Button(action: {
                    isShowingReportAlert.toggle()
                        }) {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.gray)
                        }
                        .actionSheet(isPresented: $isShowingReportAlert, content: getActionSheet)
                
                Spacer()
                Button {
                    isShowingBinDetailView = false
                    
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
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
                    openAppleMapWithSearch(address: currentMarkerAddress)
                }) {
                    Text("애플 지도로 보기")
                        .font(.footnote)
                        .padding(10)
                        .background(Color.lightGrayColor)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
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
        .alert("네이버 지도가 설치되어 있지 않습니다.", isPresented: $isShowingNMapAlert) {
            Button("확인", role: .cancel) {
            }
        }
        .alert("애플 지도(Apple Maps)가 설치되어 있지 않습니다.", isPresented: $isShowingAppleMapAlert) {
            Button("확인", role: .cancel) {
            }
        }
        .frame(width: screenWidth, height: 200)
        .background(.white)
    }
    
    func getActionSheet() -> ActionSheet {
            
            let button1: ActionSheet.Button = .default(Text("오류신고".uppercased()))
            let button2: ActionSheet.Button = .cancel(Text("취소"))
            
            let title = Text("원하는 옵션을 선택해주세요")
            
            return ActionSheet(title: title,
                               message: nil,
                               buttons: [button1,  button2])
        }
    
    private func copyToClipboard(text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
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
    
    //MARK: - 네이버 지도 길찾기
    private func openNaverMapWithSearch(address: String) {
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "nmap://search?query=\(encodedAddress)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            isShowingNMapAlert.toggle()
            print("네이버 지도 앱을 열 수 없습니다.")
        }
    }
    
    //MARK: - 애플 지도 길찾기
    private func openAppleMapWithSearch(address: String) {
        let urlStr = "maps://?daddr=\(address)&dirfgl=d"

        guard let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encodedStr) else { return }
        
        guard let appStoreUrl = URL(string: "itms-apps://itunes.apple.com/app/id915056765") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.open(appStoreUrl)
            isShowingAppleMapAlert.toggle()
        }
    }
}

struct BinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BinDetailView(screenWidth: CGFloat(300), isShowingBinDetailView: .constant(true), currentMarkerAddress: .constant("주소예시"))
    }
}
