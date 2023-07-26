//
//  SharePostView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import IQKeyboardManagerSwift

struct SharePostView: View {
    @StateObject var viewModel: SharePostViewModel
    
    @State private var offset = CGSize.zero
    @State private var isLongGestureTapped = false
    
    var body: some View {
        BaseView(pageState: $viewModel.pageState) {
            VStack {
                ZStack(alignment: .center) {
                    if isLongGestureTapped {
                        Image(systemName: "trash").resizable().frame(width: 30, height: 30).foregroundStyle(.red.opacity(0.7))
                    }
                    
                    HStack {
                        Button {
                            viewModel.goBack()
                        } label: {
                            Text("Vazgeç").foregroundStyle(.opaqueBlack)
                        }.padding(.horizontal)
                        
                        Spacer()
                        
                        Button {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            viewModel.sharePost()
                        } label: {
                            Text("Paylaş").padding(.horizontal).padding(.vertical, 5).background(RoundedRectangle(cornerRadius: 5).fill(.appPrimary)).foregroundStyle(.white)
                        }.padding(.horizontal)
                    }
                }
                
                Divider()
                HStack {
                    Button {
                        self.viewModel.imagePickerPresented.toggle()
                    } label: {
                        Image(systemName: "photo").foregroundStyle(.appPrimary)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "camera.fill").foregroundStyle(.appPrimary)
                    }
                    
                    Spacer()
                }.padding(.horizontal, 6)
                Divider()
                if let image = viewModel.image {
                    let dragGesture = DragGesture()
                        .onChanged { value in
                            guard isLongGestureTapped else { return }
                            offset = value.translation
                        }
                        .onEnded { _ in
                            withAnimation {
                                if self.offset.height < -75 {
                                    viewModel.image = nil
                                    offset = .zero
                                } else {
                                    offset = .zero
                                }
                                isLongGestureTapped = false
                            }
                        }
                    
                    // a long press gesture that enables isDragging
                    let pressGesture = LongPressGesture()
                        .onEnded { value in
                            withAnimation {
                                isLongGestureTapped = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    if self.offset == .zero {
                                        withAnimation {
                                            isLongGestureTapped = false
                                        }
                                    }
                                }
                            }
                        }
                    
                    // a combined gesture that forces the user to long press then drag
                    let combined = pressGesture.sequenced(before: dragGesture)
                    
                    
                    image.resizable().scaledToFill().frame(width: 90).frame(height: 90).clipShape(RoundedRectangle(cornerRadius: 45))
                        .overlay(
                            RoundedRectangle(cornerRadius: 45).fill(offset.height < -75 ? .red.opacity(0.5) : .clear).frame(width: 90, height: 90)
                        )
                        .padding()
                    
                        .scaleEffect(isLongGestureTapped ? 1.35 : 1)
                        .offset(offset)
                        .gesture(combined)
                        .ignoresSafeArea(.keyboard)
                }
                MultilineTextField(text: $viewModel.text)
                
            }
        }.sheet(isPresented: $viewModel.imagePickerPresented, content: {
            ImagePicker(image: $viewModel.image)
        })
        .onAppear {
            IQKeyboardManager.shared.enable = false
        }
        .onDisappear {
            IQKeyboardManager.shared.enable = true
        }
    }
}

#Preview {
    SharePostView(viewModel: SharePostViewModel(navigationState: NavigationState(), interactor: SharePostInteractor()))
}

