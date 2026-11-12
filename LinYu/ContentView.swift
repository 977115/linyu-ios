import SwiftUI
import UIKit

struct ContentView: View {
    @Environment(\.openURL) private var openURL
    @State private var key = ""
    @State private var message = "输入卡密后点生成安装链接。"
    @State private var link = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("林羽").font(.largeTitle).bold()
            Text("版本 3").font(.caption).foregroundColor(.secondary)
            TextField("输入卡密", text: $key)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            Button("生成安装链接") { makeLink() }
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            if let url = URL(string: link), !link.isEmpty {
                Link("用 Safari 安装", destination: url)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                Text(link).font(.footnote).textSelection(.enabled)
                Button("复制地址") {
                    UIPasteboard.general.string = link
                    message = "已复制。打开 Safari 粘贴后前往。"
                }
            }
            Text(message).foregroundColor(.secondary)
            Text("安装后到设置，通用，日期与时间，关闭自动设置。")
                .font(.footnote)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(24)
    }

    func makeLink() {
        let clean = key.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard clean.range(of: "^[a-z0-9][a-z0-9-]{0,62}$", options: .regularExpression) != nil else {
            message = "卡密格式不正确"
            link = ""
            return
        }
        link = "https://hlqjh.cn:8443/ios_go.php?key=" + clean
        message = "链接已生成。请点绿色按钮用 Safari 安装。"
        if let url = URL(string: link) {
            openURL(url)
        }
    }
}
