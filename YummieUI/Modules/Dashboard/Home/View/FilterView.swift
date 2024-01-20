

import SwiftUI

struct FilterView:View {
    
    @EnvironmentObject var vm:HomeViewModel
    @State var visibility:Visibility = .automatic
    var body: some View {
        List {
            ForEach(0...1,id:\.self) { i in
                Section {
                    if i == 0 {
                        Button {
                            if vm.filters.count != Cousine.allCases.count {
                                vm.filters = Cousine.allCases
                            }
                        } label: {
                            SelectAllCell(isAllSelected: vm.filters.count == Cousine.allCases.count)
                        }
                        .foregroundStyle(Color.black)
                    } else {
                        ForEach(Cousine.allCases,id:\.self) { cusine in
                            Button {
                                if let index = vm.filters.firstIndex(of: cusine) {
                                    vm.filters.remove(at: index)
                                } else {
                                    vm.filters.append(cusine)
                                }
                            } label: {
                                FilterCell(filter: cusine, isSelected: vm.filters.contains(cusine))
                            }
                            .foregroundStyle(Color.black)
                        }
                    }
                } header: {
                    
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Filter Restaurants")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(visibility, for: .tabBar)
        .onAppear {
            withAnimation {
                visibility = .hidden
            }
        }
        .onDisappear {
            withAnimation {
                visibility = .visible
            }
        }
    }
}


struct FilterCell:View {
    
    var filter:Cousine
    var isSelected:Bool
    var body: some View {
        HStack {
            Text(filter.title)
                .poppins(size:12,weight: .medium)
                .opacity(0.77)
            Spacer()
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 2)
                .background(content: {
                    if isSelected {
                        Color.colorPrimary
                    } else {
                        Color.clear
                    }
                })
                .frame(width: 18,height: 18)
                
        }
        
    }
}


struct SelectAllCell:View {
    
    var isAllSelected:Bool
    var body: some View {
        HStack {
            Text("Select All")
                .poppins(size:12,weight: .medium)
                .opacity(0.77)
            Spacer()
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 2)
                .background(content: {
                    if isAllSelected {
                        Color.colorPrimary
                    } else {
                        Color.clear
                    }
                })
                .frame(width: 18,height: 18)
        }
    }
}
