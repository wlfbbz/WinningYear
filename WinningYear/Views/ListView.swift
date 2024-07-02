//
//  ListView.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//

import SwiftUI
import UserNotifications

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @AppStorage("userId") var userId: String = "" // Add the AppStorage for userId || DO NOT COMMENTOUT
    @State private var isAddViewPresented = false
    @State private var showEnlargedImage = false
    @State private var showContributions = false // Add this line
    @State private var showNotificationsSettings = false
    private let notificationManager = NotificationManager()
    @State private var hasRequestedNotificationPermission = false
    @StateObject private var viewModel = ListViewModel()
    @State private var showMainView = true // Add this line
//    @StateObject private var listViewModel = ListViewModel()

    var body: some View {

        ZStack {
            Color.checkmark.edgesIgnoringSafeArea(.all)
            VStack {
                VStack (spacing: 10) {
                    HStack {
                        Spacer()
                        Spacer()
                        Text("Year of Winning")
                            .font(.system(size: 24))
                            .foregroundStyle(.black)
                        Spacer()

                        
                        // Add the settings button
                        Button(action: {
                            showNotificationsSettings = true
                        }) {
                            Image("bell")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                                .opacity(0.5)
                                .font(.system(size: 24))
                                .padding(8)
//                                .background(.buttonText)
                                .clipShape(Circle())
                                .padding(12)
                        }
                        .fullScreenCover(isPresented: $showNotificationsSettings) {
                            NotificationsSettingsView()
                        }

                    }
                    HStack {
                        Text("My Wins 🥳")
                            .font(.title2)
                            .foregroundStyle(.black)
                        Spacer()
                        Button(action: {
                            showMainView.toggle()
                        }) {
                            Image(showMainView ? "cal.fill" : "list.fill")
                                .resizable()
                                .opacity(0.7)
                                .frame(width: 28, height: 24)
////                                .padding(1)
////                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom)


                }// end of vstack
                .padding(.top, 30)
                
                // Add a condition to show the appropriate view based on the state
                               if showMainView {
                                   // Your ListView content
                                   // ...
                                   HStack {
//                                       Text("My Wins 🥳")
//                                           .font(.title2)
//                                           .foregroundStyle(.black)
//                                           .padding(.horizontal, 24)
                                       Spacer()
           //                            Button(action: {
           //                                showContributions.toggle()
           //                            }) {
           //                                Image(systemName: "calendar")
           //                                    .foregroundColor(.gray)
           //                                    .font(.system(size: 24))
           //                                    .padding()
           //                            }
           //                            .sheet(isPresented: $showContributions) {
           //                                ContributionsCalendar(viewModel: viewModel)
           //                            }
                                   }
           //                        .padding(.horizontal, 24)
                                   VStack {
                                       List {
                                           ForEach(listViewModel.itemsGroupedByPeriod.keys.sorted(by: { sortPeriods(lhs: $0, rhs: $1) }), id: \.self) { period in                        Section (header: Text(period)/*.font(.subheadline)*/.textCase(.uppercase).font(.system(size: 12, weight: .bold)).foregroundStyle(.gray).padding(.horizontal, 2).listRowBackground(Color.black)) {
                                                   ForEach(listViewModel.itemsGroupedByPeriod[period]!, id: \.id) { item in
                                                       ListRowView(item: item)
                                                       .listRowBackground(Color.clear)
                                                       .listRowInsets(EdgeInsets(top: 2, leading: 16, bottom: 2, trailing: 16))
                                                       .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                                                       .listRowSeparator(.hidden)
                                                       .padding(.horizontal)
                                                       .background(Color.white.opacity(1))
                   //                                    .stroke(Color.black, lineWidth: 1)
                   //                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("border"), lineWidth: 1))
                                                   }
                                                   .onDelete { indexSet in
                                                       listViewModel.deleteItem(period: period, indexSet: indexSet)
                                                   }
                                               }
                                           }
                                           .cornerRadius(10)
                                           .padding(.horizontal, -15)
                                           
                                       }
                                       .listStyle(PlainListStyle())
                                   } // end of vstack
                                   .padding(.horizontal, 20)
                                   .padding(.top, -20)
                               } else {
                                   // Add your other view's content here
                                   ContributionsCalendar(viewModel: listViewModel)
//                                       .padding()
//                                       .background(.white)
//                                       .cornerRadius(20)
//                                       .padding()
                               }


                
                Button(action: {
                                    isAddViewPresented.toggle()
                                }) {
                                    Image(systemName: "plus")
                                        .padding(16)
                                        .foregroundColor(.white)
                                        .background(Color.gray)
                                        .clipShape(Circle())
                                        .padding()
                                }
                                .fullScreenCover(isPresented: $isAddViewPresented) {
                                    AddView()
                                        .environmentObject(listViewModel)
                                }
                
                
//                NavigationLink(destination: AddView()) {
//                                Image(systemName: "plus")
//                                    .padding(16)
//                                    .foregroundColor(.white)
//                                    .background(Color.gray)
//                                    .clipShape(Circle())
//                                    .padding()
//
//                }
//
//                Button(action: {
//                    // Perform sign-out action here
//                    userId = "" // Clear the userId
//                }) {
//                    Text("Sign Out")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.red)
//                        .cornerRadius(10)
//                }
//                .padding()
                
                
                
            } // end of VStack
            .padding(.top, 35)
            .padding(.bottom, 30)
        } // end of Zstack
        .ignoresSafeArea()
        .onAppear {
            if !hasRequestedNotificationPermission {
                notificationManager.requestAuthorization()
                hasRequestedNotificationPermission = true
            }
        }
    }
    
    // Custom sort function for period titles, including years
    private func sortPeriods(lhs: String, rhs: String) -> Bool {
        let fixedOrder = ["Today", "Yesterday", "Previous 7 Days", "Previous 30 Days", "Previous 6 Months"]

        // Check if both lhs and rhs are year values
        if let lhsYear = Int(lhs), let rhsYear = Int(rhs) {
            return lhsYear > rhsYear // Sort years in descending order
        }

        // Check if either lhs or rhs is a fixed period, if so, it should come first
        if fixedOrder.contains(lhs), !fixedOrder.contains(rhs) {
            return true
        } else if !fixedOrder.contains(lhs), fixedOrder.contains(rhs) {
            return false
        }

        // If both are fixed periods, use the fixed order for sorting
        if let lhsIndex = fixedOrder.firstIndex(of: lhs), let rhsIndex = fixedOrder.firstIndex(of: rhs) {
            return lhsIndex < rhsIndex
        }

        // As a fallback, sort alphabetically (useful if new period titles are added in the future)
        return lhs < rhs
    }
}

////testing periods
//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let listViewModel = ListViewModel()
//        listViewModel.addTestItems() // Add test items for the preview
//
//        return NavigationView {
//            ListView().environmentObject(listViewModel)
//        }
//    }
//}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let listViewModel = ListViewModel()

        return NavigationView {
            ListView()
                .environmentObject(listViewModel)
        }
    }
}




 
 
