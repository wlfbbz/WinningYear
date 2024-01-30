//
//  ListView.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @AppStorage("userId") var userId: String = "" // Add the AppStorage for userId || DO NOT COMMENTOUT
    @State private var isAddViewPresented = false

    
    var body: some View {
        
        ZStack {
            Color.checkmark.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                VStack (spacing: 30) {
                        Text("Year of Winning")
                            .font(.system(size: 24))
                            .foregroundStyle(.black)
                    
                        HStack {
                            Text("My Wins 🥳")
                                .font(.title2)
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                }// end of vstack
                .padding(.top, 30)
                
                VStack {
                    List {
                        ForEach(listViewModel.itemsGroupedByPeriod.keys.sorted(by: { sortPeriods(lhs: $0, rhs: $1) }), id: \.self) { period in                        Section /*(header: Text(period).font(.subheadline).textCase(.uppercase).fontWeight(.bold).padding(.bottom, 5).foregroundStyle(.gray).padding(.horizontal, 2))*/ {
                                ForEach(listViewModel.itemsGroupedByPeriod[period]!, id: \.id) { item in
                                    ListRowView(item: item)
                                    .listRowBackground(Color.clear)
                                    .listRowInsets(EdgeInsets(top: 2, leading: 16, bottom: 2, trailing: 16))
                                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                                    .listRowSeparator(.hidden)
                                    .padding(.horizontal)
                                    .background(Color.white)
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
            .padding(.top, 50)
            .padding(.bottom, 30)
        } // end of Zstack
        .ignoresSafeArea()
    }
    
    // Custom sort function for period titles, including years
    private func sortPeriods(lhs: String, rhs: String) -> Bool {
        let fixedOrder = ["Today", "Yesterday", "Last 7 Days", "Last 30 Days", "Last 6 Months"]

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

//testing periods
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




