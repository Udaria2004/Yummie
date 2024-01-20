
import SwiftUI

struct AccountView : View {
    
    @EnvironmentObject var vm:HomeViewModel
    @State var visibility:Visibility = .automatic
    var body: some View {
        List {
            ForEach(Array(vm.accountModel.enumerated()), id: \.offset) { index,section in
                Section {
                    ForEach(Array(section.info.enumerated()),id: \.offset) { index,row in
                        Button {
                            if row.isLogout {
                                NotificationCenter.default.post(name: Notification.userLogout, object: nil)
                            }
                        } label: {
                            AccountCell(info: row)
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    if index == 0 {
                        ImageAccountHeader()
                    } else {
                        
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(vm.coreDatamanager.getUser()?.name ?? "").font(.headline)
                    Text(vm.coreDatamanager.getUser()?.email ?? "").font(.subheadline)
                }
            }
        }
        .toolbar(visibility, for: .tabBar)
        .onAppear {
          let tableHeaderView = UIView(frame: .zero)
          tableHeaderView.frame.size.height = 1
          UITableView.appearance().tableHeaderView = tableHeaderView
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


struct ImageAccountHeader:View {
    
    
    var body: some View {
        ZStack {
            Image("acc-bg-header")
            VStack {
                Image("yummer")
                Text("Save big on delivery fees and enjoy members-only offers")
                    .euclardCircular(size: 11, weight: .regular)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal)
                HStack {
                    Text("Find out more")
                        .poppins(size: 12, weight: .regular)
                        .foregroundStyle(.white)
                    Image("arrow-next")
                }
            }
        }
    }
}

struct AccountCell:View {
    
    var info:AccountInfo
    
    var body: some View {
        HStack {
            if let icon = info.icon,!icon.isEmpty {
                Image(icon)
                    .renderingMode(.template)
                    .foregroundStyle(Color.gray)
                    .frame(width: 18, height: 18, alignment: .center)
            }
            Text(info.title)
                .poppins(size:10,weight: .medium)
                .opacity(0.77)
                .frame(width: width - 80,height: 20,alignment: .leading)
                .contentShape(Rectangle())
          
        }
    }
}
