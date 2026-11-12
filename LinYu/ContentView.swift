import SwiftUI
struct ContentView: View {
    @State private var key = ""
    @State private var message = "输入卡密后点连接。"
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("林羽").font(.largeTitle).bold()
            TextField("输入卡密", text: $key).textInputAutocapitalization(.never).autocorrectionDisabled().padding().background(Color(.secondarySystemBackground)).cornerRadius(12)
            Button("连接") { connect() }.frame(maxWidth: .infinity).padding().background(Color.blue).foregroundColor(.white).cornerRadius(12)
            Text(message).foregroundColor(.secondary)
            Text("安装后请打开设置，进入通用，日期与时间，关闭自动设置。不用时删除描述文件林羽，再打开自动设置。").font(.footnote).foregroundColor(.secondary)
            Spacer()
        }.padding(24)
    }
    func connect() {
        let clean = key.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard clean.range(of: "^[a-z0-9][a-z0-9-]{0,62}$", options: .regularExpression) != nil else { message = "卡密格式不正确"; return }
        let host = clean + ".fklqly.cn"
        let profile = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>PayloadContent</key><array><dict>
<key>DNSSettings</key><dict>
<key>DNSProtocol</key><string>TLS</string>
<key>ServerName</key><string>\(host)</string>
<key>ServerAddresses</key><array><string>64.83.13.148</string></array>
</dict>
<key>PayloadDisplayName</key><string>林羽</string>
<key>PayloadIdentifier</key><string>cn.hlqjh.linyu.\(clean)</string>
<key>PayloadType</key><string>com.apple.dnsSettings.managed</string>
<key>PayloadUUID</key><string>11111111-2222-3333-4444-555555555555</string>
<key>PayloadVersion</key><integer>1</integer>
</dict></array>
<key>PayloadDisplayName</key><string>林羽</string>
<key>PayloadIdentifier</key><string>cn.hlqjh.linyu.profile.\(clean)</string>
<key>PayloadRemovalDisallowed</key><false/>
<key>PayloadType</key><string>Configuration</string>
<key>PayloadUUID</key><string>66666666-7777-8888-9999-AAAAAAAAAAAA</string>
<key>PayloadVersion</key><integer>1</integer>
</dict></plist>
"""
        let encoded = Data(profile.utf8).base64EncodedString()
        if let url = URL(string: "data:application/x-apple-aspen-config;base64,\(encoded)") {
            UIApplication.shared.open(url)
            message = "已打开描述文件。请按提示安装，然后手动关闭自动设置。"
        }
    }
}
