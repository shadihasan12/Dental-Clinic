import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Register a real UITabBar as a platform view so Flutter can host it
    // directly. This gives us the system blur, indicator, and (on iOS 26)
    // the liquid-glass drag-to-slide behavior for free.
    if let registrar = self.registrar(forPlugin: "GlassTabBar") {
      let factory = GlassTabBarFactory(messenger: registrar.messenger())
      registrar.register(factory, withId: "glass_tab_bar")
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// MARK: - Glass Tab Bar (real UITabBar via FlutterPlatformView)

final class GlassTabBarFactory: NSObject, FlutterPlatformViewFactory {
  private let messenger: FlutterBinaryMessenger

  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }

  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    return GlassTabBarPlatformView(
      frame: frame,
      viewIdentifier: viewId,
      arguments: args,
      messenger: messenger
    )
  }

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    return FlutterStandardMessageCodec.sharedInstance()
  }
}

final class GlassTabBarPlatformView: NSObject, FlutterPlatformView, UITabBarDelegate {
  private let container: UIView
  private let tabBar: UITabBar
  private let channel: FlutterMethodChannel

  init(
    frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments: Any?,
    messenger: FlutterBinaryMessenger
  ) {
    self.container = UIView(frame: frame)
    self.container.backgroundColor = .clear
    self.tabBar = UITabBar()
    self.tabBar.translatesAutoresizingMaskIntoConstraints = false
    self.channel = FlutterMethodChannel(
      name: "glass_tab_bar_\(viewId)",
      binaryMessenger: messenger
    )
    super.init()

    // Use the system default appearance. On iOS 26 this picks up Liquid
    // Glass automatically; on iOS 18 and earlier it falls back to the
    // standard translucent material. We avoid overriding `backgroundEffect`
    // so iOS can choose the right material per OS version.
    let appearance = UITabBarAppearance()
    appearance.configureWithDefaultBackground()
    appearance.backgroundColor = nil

    // Slightly smaller tab titles than the iOS default (10pt) — feels
    // less heavy under the SF Symbol icons. Selected stays semibold so
    // the active state is still readable.
    let normalTitleAttrs: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: 9, weight: .regular)
    ]
    let selectedTitleAttrs: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: 9, weight: .semibold)
    ]
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalTitleAttrs
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedTitleAttrs
    appearance.inlineLayoutAppearance.normal.titleTextAttributes = normalTitleAttrs
    appearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedTitleAttrs
    appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = normalTitleAttrs
    appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedTitleAttrs

    tabBar.standardAppearance = appearance
    if #available(iOS 15.0, *) {
      tabBar.scrollEdgeAppearance = appearance
    }
    tabBar.isTranslucent = true
    tabBar.barTintColor = nil
    tabBar.backgroundImage = nil
    tabBar.shadowImage = nil
    tabBar.delegate = self

    container.addSubview(tabBar)
    NSLayoutConstraint.activate([
      tabBar.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      tabBar.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      tabBar.topAnchor.constraint(equalTo: container.topAnchor),
      tabBar.bottomAnchor.constraint(equalTo: container.bottomAnchor),
    ])

    apply(arguments: arguments)

    channel.setMethodCallHandler { [weak self] call, result in
      guard let self = self else { result(nil); return }
      switch call.method {
      case "setSelectedIndex":
        if let idx = call.arguments as? Int {
          self.selectIndex(idx)
        }
        result(nil)
      case "setItems":
        self.apply(arguments: call.arguments)
        result(nil)
      case "setTintColor":
        if let hex = call.arguments as? String,
           let color = GlassTabBarPlatformView.color(fromHex: hex) {
          self.tabBar.tintColor = color
        }
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  func view() -> UIView { return container }

  private func apply(arguments: Any?) {
    guard let args = arguments as? [String: Any] else { return }

    if let tintHex = args["tintColor"] as? String,
       let color = GlassTabBarPlatformView.color(fromHex: tintHex) {
      tabBar.tintColor = color
    }

    // Force the tab bar's layout direction to follow Flutter's
    // Directionality. iOS only honours its system locale by default, but the
    // Flutter app may be running in Arabic while iOS itself is English.
    if let direction = args["textDirection"] as? String {
      tabBar.semanticContentAttribute =
        direction == "rtl" ? .forceRightToLeft : .forceLeftToRight
    }

    if let itemsArg = args["items"] as? [[String: Any]] {
      let items: [UITabBarItem] = itemsArg.map { dict in
        let title = dict["title"] as? String
        var image: UIImage? = nil
        var selectedImage: UIImage? = nil
        if let symbol = dict["systemIcon"] as? String {
          image = UIImage(systemName: symbol)
        }
        if let symbol = dict["systemIconSelected"] as? String {
          selectedImage = UIImage(systemName: symbol)
        }
        return UITabBarItem(title: title, image: image, selectedImage: selectedImage ?? image)
      }
      tabBar.setItems(items, animated: false)
    }

    if let idx = args["selectedIndex"] as? Int {
      selectIndex(idx)
    }
  }

  // Programmatic selection. UIKit guarantees `tabBar(_:didSelect:)` is only
  // called for *user* taps, never for assignments to `selectedItem`, so this
  // can't bounce back into Flutter.
  private func selectIndex(_ idx: Int) {
    guard let items = tabBar.items, idx >= 0, idx < items.count else { return }
    if tabBar.selectedItem !== items[idx] {
      tabBar.selectedItem = items[idx]
    }
  }

  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    if let idx = tabBar.items?.firstIndex(of: item) {
      channel.invokeMethod("onTap", arguments: idx)
    }
  }

  private static func color(fromHex hex: String) -> UIColor? {
    var clean = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if clean.hasPrefix("#") { clean.removeFirst() }
    guard clean.count == 6 || clean.count == 8 else { return nil }
    var rgb: UInt64 = 0
    guard Scanner(string: clean).scanHexInt64(&rgb) else { return nil }
    let r, g, b, a: CGFloat
    if clean.count == 8 {
      a = CGFloat((rgb & 0xFF000000) >> 24) / 255
      r = CGFloat((rgb & 0x00FF0000) >> 16) / 255
      g = CGFloat((rgb & 0x0000FF00) >> 8) / 255
      b = CGFloat(rgb & 0x000000FF) / 255
    } else {
      a = 1
      r = CGFloat((rgb & 0xFF0000) >> 16) / 255
      g = CGFloat((rgb & 0x00FF00) >> 8) / 255
      b = CGFloat(rgb & 0x0000FF) / 255
    }
    return UIColor(red: r, green: g, blue: b, alpha: a)
  }
}
