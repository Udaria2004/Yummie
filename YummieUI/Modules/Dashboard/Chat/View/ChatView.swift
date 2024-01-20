
import SwiftUI
struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isMyMessage: Bool
    
    static func resturantNamesMesg() -> Message {
        let names = Restaurant.allData().map({$0.name}).joined(separator: ",\n ")
        let message = "You can ask anything about these restaurents: \(names)"
        return Message(text: message, isMyMessage: false)
    }
    
    static func gladMessage() -> Message {
        let names = Restaurant.allData().map({$0.name}).joined(separator: ", ")
        let message = "Glad to see you here again...!"
        return Message(text: message, isMyMessage: false)
    }
}

struct ChatView: View {
    @State private var messages: [Message] = [
        Message(text: "Hey there!", isMyMessage: true),
        Message(text: "Hi! How can I help you?", isMyMessage: false)
    ]
    @State private var draftMessage: String = ""
    @State private var textHeight: CGFloat = 30 // Minimum height
    @State private var isLoading = false
    var body: some View {
        VStack {
            List(messages) { message in
                MessageRow(message: message)
                    .frame(maxWidth: .infinity, alignment: message.isMyMessage ? .trailing : .leading)
            }
            .padding(.top)
            .onTapGesture {
                hideKeyboard()
            }
            .scrollContentBackground(.hidden)
            HStack {
                TextEditor(text: $draftMessage)
                    .cornerRadius(8)
                Button(action: sendMessage) {
                    Text("Send")
                        .foregroundColor(.blue)
                }
            }
            .frame(height: 60)
            .padding()
        }
        .background {
            Color.gray.opacity(0.5)
                .onTapGesture {
                    hideKeyboard()
                }
            
        }
    }
    
    func hideKeyboard() {
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
      
    
    func sendMessage() {
        guard !draftMessage.isEmpty else { return }
        messages.append(Message(text: draftMessage, isMyMessage: true))
        draftMessage = ""
        updateTextHeight()
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            let random = [Message.resturantNamesMesg(),Message.gladMessage()].randomElement()!
            messages.append(random)
        }
    }
    
    func updateTextHeight() {
        DispatchQueue.main.async {
            let maxHeight: CGFloat = 100 // Set the maximum height for the text field
            let minHeight: CGFloat = 30 // Set the minimum height for the text field
            
            // Calculate the height of the text field based on the content
            let height = max(minHeight, min(maxHeight, getTextHeight(text: draftMessage) + 16)) // +16 for padding
            
            // Update the text field height
            withAnimation {
                textHeight = height
            }
        }
    }
    
    func getTextHeight(text: String) -> CGFloat {
        let size = CGSize(width: UIScreen.main.bounds.width - 100, height: .infinity)
        let font = UIFont.systemFont(ofSize: 16)
        let estimatedSize = NSString(string: text).boundingRect(
            with: size,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return estimatedSize.height
    }
}

struct MessageRow: View {
    let message: Message
    
    var body: some View {
        VStack(alignment: message.isMyMessage ? .trailing : .leading) {
            Text(message.text)
                .foregroundColor(message.isMyMessage ? .white : .primary)
                .padding(8)
                .background(
                    message.isMyMessage ? Color.blue : Color.gray.opacity(0.2)
                )
                .cornerRadius(8)
                .lineLimit(nil)
                .frame(maxWidth: 250, alignment: message.isMyMessage ? .trailing : .leading)
        }
    }
}

