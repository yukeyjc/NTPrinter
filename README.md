# NTPrinter

NTPrinter 打印 SDK

## 示例项目

在 example 文件夹下有个示例项目. 使用前, 请运行 `carthage update --platform iOS --no-use-binaries` 来下载需要的库。

## 安装

### iOS 版本

9.0+

## 用法

使用 NTPrinter 相当的简单, 主要有以下几个 API:

#### 注册 SDK

AppID: 分配的渠道号<br>
AppSecret: 分配的渠道密钥

```swift
Trimkeeper.shared.register(appID: xxxxxx, appSecret: xxxxxx) { trimkeeperError in
	if let error = trimkeeperError {
		// 注册失败
		print(error.message)
	} else {
		// 注册成功
		// ...
	}
}
```

#### 连接打印机

支持 ip 或者域名，默认端口为 9100。<br>
打印、发送资源文件需要先连接打印机。<br>
sdk 目前不控制打印机自动重连，需要 App 监听状态，手动维持连接。<br>
建议在 sdk 注册成功后连接打印机，并保持连接。<br>

```swift
do {
	let printer = Printer(host: "192.168.15.135", mode: .avery9419)
	try Trimkeeper.shared.connectPrinter(printer)
} catch let error {
	//连接失败
	print(error.localizedDescription)
}
```

#### 更新资源

从网络下载打印机基础资源，如模板、图片等。<br>
sdk 会自动保存资源文件至磁盘。<br>
建议 App 每次启动后调用此方法。<br>
需要联网。<br>

```swift
Trimkeeper.shared.updateAssets { trimkeeperError in
	if let error = trimkeeperError {
		// 更新失败
		print(error.message)
	} else {
		// 更新成功
		// ...
	}
}
```

#### 将资源文件发送至打印机

下载更新资源后、或人为因素造成资源文件丢失时，需要调用此方法将资源上传资源至打印机。<br>
建议仅在调用完 updateAssets()后调用一次，频繁调用无任何意义且会影响打印效率。<br>

```swift
Trimkeeper.shared.sendAssetsToPrinter{ trimkeeperError in
	if let error = trimkeeperError {
		// 发送失败
		print(error.message)
	} else {
		// 发送成功
		// ...
	}
}
```

#### 打印

```swift
// 初始化模版并传入变量
let format = TKTemplateFormat(templateName: template.name)
format.add(qr: "1234567890", forPlaceholder: "V1") // 该方法打印条形码
format.add(variable: "13600000000", forPlaceholder: "V2") // 该方法仅英文数字，如手机号
format.add(encodingVariable: "张三", forPlaceholder: "V3") // 该方法支持中文
// ...

// 发送至打印机并打印
do {
	try Trimkeeper.shared.print(templates: formats)
} catch let error {
	// 失败
	print(error.localizedDescription)
}

```

#### Protocol

`Trimkeeper.shared.delegate = self`

打印机连接成功

```swift

func trimkeeper(didConnectTo printer: Printer) {
	print("打印机 \(printer) 连接成功")
	// ...
}
```

打印机断开连接

```swift
func trimkeeper(didDisconnectTo printer: Printer, withError error: TKError) {
	print("打印机 \(printer) 连接失败 \(error.message)")
	// ...
}

```

## 使用模板

参考`TKTemplate.previewUrl` [样例](http://sslstatic.nextcont.com/trimkeeper/demo.html)

其中${V?}表示占位符号，接入时传入打印变量，sdk 会将变量打印至对应的占位符中。<br>
如使用`format.add(encodingVariable: "上海", forPlaceholder: "V8")`，最终打印结果会在 V8 的位置打印"上海"

## CHANGELOG

> ## [1.0.5](https://github.com/lugq1001/Trimkeeper) (2019-09-24)
>
> **swift5.1 支持**
>
> ## [1.0.4](https://github.com/lugq1001/Trimkeeper) (2019-04-25)
>
> **swift5 支持**
>
> ## [1.0.3](https://github.com/lugq1001/Trimkeeper) (2018-12-18)
>
> **Object-c Demo 加入 cocoapods 演示**

> ## [1.0.2](https://github.com/lugq1001/Trimkeeper) (2018-09-19)
>
> **增加 Object-c 调用 demo**

> ## [1.0.1](https://github.com/lugq1001/Trimkeeper) (2018-09-17)
>
> **增加模拟器支持**

> ## [1.0.0](https://github.com/lugq1001/Trimkeeper) (2018-08-15)
>
> **增加打印机连接监听**
