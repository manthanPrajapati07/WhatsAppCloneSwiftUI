//
//  ExploreListView.swift
//  WhatsAppClone
//
//  Created by Manthan on 31/05/25.
//

import SwiftUI

struct ExploreListView: View {
    
    @EnvironmentObject var homeVM : HomeViewModel
    @State private var showAlert : Bool = false
    @State private var selectedUser: User? = nil
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(homeVM.arrExploreUsers, id: \.userId) { userlist in
                    VStack{
                        Spacer()
                        userListView(image: userlist.userAvatar, name: userlist.userName)
                        Spacer()
                        Divider()
                            .padding(.leading, 60)
                    }
                    .frame(height: 70)
                    .onTapGesture {
                        selectedUser = userlist
                        showAlert.toggle()
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Add Friend ?"),
                            message: Text("Do you want to make \(selectedUser?.userName ?? "user") your friend?"),
                            primaryButton: .default(Text("Yes")) {
                                if let selectedUser = selectedUser{
                                    homeVM.addFriend(to: selectedUser)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 100)
          
        }
    }
    
    private func userListView(image: String, name: String)-> some View{
        HStack{
            Image(image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 50)
                .padding(.leading, 10)
            
            VStack(spacing: 5.0){
                HStack{
                    Text(name)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.black)
                    Spacer()
                }
                HStack{
                    Text("tap to make \(name) friend")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color.gray)
                        .italic()
                    Spacer()
                }
               
            }
            .padding(.horizontal, 5)
            
            
            Spacer()
        }
        .frame(height: 50)
    }
}

#Preview {
    ExploreListView()
}
