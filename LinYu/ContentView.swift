import SwiftUI
struct ContentView: View {
    @State private var key = ""
    @State private var message = "输入卡密后点连接。"
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("林羽").font(.largeTitle).bold()
            TextField("输入卡密", text: $key)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            Button("连接") { connect() }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            Text(message).foregroundColor(.secondary)
            Text("点连接后会打开描述文件下载。安装后到设置，通用，日期与时间，关闭自动设置。不用时删除描述文件林羽，再打开自动设置。")
                .font(.footnote)
                .foregroundColor(.secondary)
            Spacer()
        }.padding(24)
    }
    func connect() {
        let clean = key.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard clean.range(of: "^[a-z0-9][a-z0-9-]{0,62}$", options: .regularExpression) != nil else {
            message = "卡密格式不正确"
            return
        }
        let address = "https://hlqjh.cn:8443/ios_profile.php?key=\(clean)"
        guard let url = URL(string: address) else {
            message = "下载地址不正确"
            return
        }
        UIApplication.shared.open(url)
        message = "已打开描述文件下载。安装后请手动关闭自动设置。"
    }
}
