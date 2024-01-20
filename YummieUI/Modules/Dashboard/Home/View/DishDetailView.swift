
import SwiftUI

struct DishDetailView:View {
    var dish:Dish
    var isComeFromFav:Bool = false
    @State var visibility:Visibility = .hidden
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 0) {
            Image(dish.image)
                .resizable()
                .scaledToFill()
                .frame(width: width,height: height * 0.44)
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.white)
                .frame(width: width,height: (height * 0.56) - 50)
                .overlay {
                    VStack {
                        HStack {
                            Text(dish.name)
                                .euclardCircular(size: 20, weight: .semibold)
                            Spacer()
                            Text("Calories \(dish.calories)")
                                .euclardCircular(size: 17, weight: .regular)
                                .foregroundStyle(.colorPrimary)
                        }
                        .padding(.top,15)
                        Text(dish.description)
                            .euclardCircular(size: 16, weight: .regular)
                            .opacity(0.6)
                            .padding(.top,15)
                        Spacer()
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("DONE")
                                .poppins(size:16,weight: .semibold)
                                .foregroundStyle(Color.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(Color.colorPrimary)
                                        .frame(width: width - 64,height: 55)
                                }
                        }
                        .frame(width: width - 64,height: 55)
                       
                    }
                    .padding()
                }
            Rectangle()
                .foregroundStyle(.white)
                .frame(width: width,height: 50)
        }
        .ignoresSafeArea()
        .onDisappear {
            if isComeFromFav {
                visibility = .visible
            }
           
        }
        .onAppear {
            if isComeFromFav {
                visibility = .hidden
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(visibility, for: .tabBar)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 23)
                            .opacity(0.5)
                            .frame(width: 46, height: 46, alignment: .center)
                        Image("back-icon")
                            .renderingMode(.template)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 46, height: 46, alignment: .center)
                }.buttonStyle(.plain)
                
            }
        })
    }
}
