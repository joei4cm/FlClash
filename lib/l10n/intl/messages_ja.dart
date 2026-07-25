// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja';

  static String m0(count) => "${count}日前";

  static String m1(label) => "選択された${label}を削除してもよろしいですか？";

  static String m2(label) => "現在の${label}を削除してもよろしいですか？";

  static String m3(label) => "${label}詳細";

  static String m4(label) => "${label}は空欄にできません";

  static String m5(count) => "${count} エントリ";

  static String m6(label) => "現在の${label}は既に存在しています";

  static String m7(timezone) => "適用中: ${timezone}";

  static String m8(done, total) => "チェックリスト ${done}/${total}";

  static String m9(timezone) => "${timezone} に戻す";

  static String m10(timezone) => "OS タイムゾーンを ${timezone} に設定しました";

  static String m11(command) => "タイムゾーンを自動変更できませんでした。実行: ${command}";

  static String m12(timezone) => "OS タイムゾーンを ${timezone} に復元しました";

  static String m13(timezone) =>
      "${timezone} の Windows 対応名がありません。日付と時刻の設定で手動選択してください。";

  static String m14(name) => "${name} スキップ済み";

  static String m15(name) => "${name} 更新済み";

  static String m16(name) => "${name}を更新中...";

  static String m17(count) => "${count}時間前";

  static String m18(count) => "${count} 時間";

  static String m19(target) => "${target} は無効なポリシーです";

  static String m20(proxyName) => "${proxyName} は無効なプロキシです";

  static String m21(providerName) => "${providerName} は無効なプロキシプロバイダーです";

  static String m22(subRule) => "${subRule} は無効なSUB_RULEです";

  static String m23(appName) =>
      "1. Open System Settings > Privacy & Security\n2. Choose Location Services\n3. Find and check ${appName} in the right list\n\nAfter completing the setup, return to the app and use it normally. Thank you for your cooperation.";

  static String m24(count) => "${count}分前";

  static String m25(count) => "${count}ヶ月前";

  static String m26(label) => "まだ${label}はありません";

  static String m27(label) => "${label}は数字でなければなりません";

  static String m28(label) => "${label} は 1024 から 49151 の間でなければなりません";

  static String m29(count) => "${count} 秒";

  static String m30(count) => "${count} 項目が選択されています";

  static String m31(count) => "ルーティング先 ${count} 件";

  static String m32(count) => "${count} 個のノードが有効です。ノード横のピンで接続をテストできます。";

  static String m33(label) => "${label}はURLである必要があります";

  static String m34(count) => "${count}年前";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("について"),
    "accessControl": MessageLookupByLibrary.simpleMessage("アクセス制御"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "選択したアプリのみVPNを許可",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "アプリケーションのプロキシアクセスを設定",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "選択したアプリをVPNから除外",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage("アクセス制御設定"),
    "account": MessageLookupByLibrary.simpleMessage("アカウント"),
    "action": MessageLookupByLibrary.simpleMessage("アクション"),
    "action_mode": MessageLookupByLibrary.simpleMessage("モード切替"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("システムプロキシ"),
    "action_start": MessageLookupByLibrary.simpleMessage("開始/停止"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("表示/非表示"),
    "add": MessageLookupByLibrary.simpleMessage("追加"),
    "addProfile": MessageLookupByLibrary.simpleMessage("プロファイルを追加"),
    "addProxies": MessageLookupByLibrary.simpleMessage("プロキシを追加"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage("プロキシグループを追加"),
    "addProxyProviders": MessageLookupByLibrary.simpleMessage("プロキシプロバイダーを追加"),
    "addRule": MessageLookupByLibrary.simpleMessage("ルールを追加"),
    "addSsid": MessageLookupByLibrary.simpleMessage("SSIDを追加"),
    "addTailscaleNode": MessageLookupByLibrary.simpleMessage(
      "Tailscale ノードを追加",
    ),
    "addedRules": MessageLookupByLibrary.simpleMessage("追加ルール"),
    "additionalParameters": MessageLookupByLibrary.simpleMessage("追加パラメータ"),
    "address": MessageLookupByLibrary.simpleMessage("アドレス"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("WebDAVサーバーアドレス"),
    "addressTip": MessageLookupByLibrary.simpleMessage("有効なWebDAVアドレスを入力"),
    "advancedConfig": MessageLookupByLibrary.simpleMessage("高度な設定"),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage("多様な設定を提供"),
    "agree": MessageLookupByLibrary.simpleMessage("同意"),
    "allowBypass": MessageLookupByLibrary.simpleMessage("アプリがVPNをバイパスすることを許可"),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "有効化すると一部アプリがVPNをバイパス",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("LANを許可"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage("LAN経由でのプロキシアクセスを許可"),
    "app": MessageLookupByLibrary.simpleMessage("アプリ"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage("アプリアクセス制御"),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage("システムDNSを追加"),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "設定にシステムDNSを強制的に追加します",
    ),
    "application": MessageLookupByLibrary.simpleMessage("アプリケーション"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage("アプリ関連設定を変更"),
    "authorized": MessageLookupByLibrary.simpleMessage("許可済み"),
    "auto": MessageLookupByLibrary.simpleMessage("自動"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage("自動更新チェック"),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "起動時に更新を自動チェック",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage("接続を自動閉じる"),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "ノード変更後に接続を自動閉じる",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("自動起動"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage("システムの自動起動に従う"),
    "autoRun": MessageLookupByLibrary.simpleMessage("自動実行"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage("アプリ起動時に自動実行"),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage("オートセットシステムDNS"),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("自動更新"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage("自動更新間隔（分）"),
    "backup": MessageLookupByLibrary.simpleMessage("バックアップ"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage("バックアップと復元"),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVまたはファイルを介してデータを同期する",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("バックアップ成功"),
    "basicConfig": MessageLookupByLibrary.simpleMessage("基本設定"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage("基本設定をグローバルに変更"),
    "basicInfo": MessageLookupByLibrary.simpleMessage("基本情報"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("基本戦略"),
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "To ensure background operation, please disable battery optimization for this app. Tap to go to settings.",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "システムの影響により、この状態は必ずしも正確とは限りません。",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("バインド"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("ブラックリストモード"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("バイパスドメイン"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage("システムプロキシ有効時のみ適用"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "キャッシュが破損しています。クリアしますか？",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage("全選択解除"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("更新を確認"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage("アプリは最新版です"),
    "clearData": MessageLookupByLibrary.simpleMessage("データを消去"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("クリップボードにエクスポート"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("クリップボードからインポート"),
    "color": MessageLookupByLibrary.simpleMessage("カラー"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("カラースキーム"),
    "columns": MessageLookupByLibrary.simpleMessage("列"),
    "compatible": MessageLookupByLibrary.simpleMessage("互換モード"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "設定内にデータが検出されました",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("確認"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "すべてのデータをクリアしてもよろしいですか？",
    ),
    "confirmDeleteProxyGroup": MessageLookupByLibrary.simpleMessage(
      "現在のプロキシグループを削除してもよろしいですか？",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage(
      "現在のウィンドウを閉じてもよろしいですか？",
    ),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "コアを強制的にクラッシュさせてもよろしいですか？",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "確認後、既存のデータは上書きされます",
    ),
    "connected": MessageLookupByLibrary.simpleMessage("接続済み"),
    "connecting": MessageLookupByLibrary.simpleMessage("接続中..."),
    "connection": MessageLookupByLibrary.simpleMessage("接続"),
    "connections": MessageLookupByLibrary.simpleMessage("接続"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage("現在の接続データを表示"),
    "connectivity": MessageLookupByLibrary.simpleMessage("接続性："),
    "content": MessageLookupByLibrary.simpleMessage("内容"),
    "contentNotEmpty": MessageLookupByLibrary.simpleMessage("内容は空にできません"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("コンテンツテーマ"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "グローバル追加ルールを制御",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("コピー"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage("環境変数をコピー"),
    "copyLink": MessageLookupByLibrary.simpleMessage("リンクをコピー"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("コピー成功"),
    "core": MessageLookupByLibrary.simpleMessage("コア"),
    "coreStatus": MessageLookupByLibrary.simpleMessage("コアステータス"),
    "country": MessageLookupByLibrary.simpleMessage("国"),
    "crashTest": MessageLookupByLibrary.simpleMessage("クラッシュテスト"),
    "crashlytics": MessageLookupByLibrary.simpleMessage("クラッシュ分析"),
    "crashlyticsTip": MessageLookupByLibrary.simpleMessage(
      "有効にすると、アプリがクラッシュした際に機密情報を含まないクラッシュログを自動的にアップロードします",
    ),
    "create": MessageLookupByLibrary.simpleMessage("作成"),
    "createProfile": MessageLookupByLibrary.simpleMessage("Create Profile"),
    "creationTime": MessageLookupByLibrary.simpleMessage("作成時間"),
    "custom": MessageLookupByLibrary.simpleMessage("カスタム"),
    "cut": MessageLookupByLibrary.simpleMessage("切り取り"),
    "dark": MessageLookupByLibrary.simpleMessage("ダーク"),
    "dashboard": MessageLookupByLibrary.simpleMessage("ダッシュボード"),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "データの変更が検出されました。保存しますか？",
    ),
    "dataCollectionContent": MessageLookupByLibrary.simpleMessage(
      "本アプリはFirebase Crashlyticsを使用してクラッシュ情報を収集し、アプリの安定性を向上させます。\n収集されるデータにはデバイス情報とクラッシュ詳細が含まれますが、個人の機密データは含まれません。\n設定でこの機能を無効にすることができます。",
    ),
    "dataCollectionTip": MessageLookupByLibrary.simpleMessage("データ収集説明"),
    "daysAgo": m0,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage("デフォルトネームサーバー"),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "DNSサーバーの解決用",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("デフォルト"),
    "delay": MessageLookupByLibrary.simpleMessage("遅延"),
    "delayTest": MessageLookupByLibrary.simpleMessage("遅延テスト"),
    "delete": MessageLookupByLibrary.simpleMessage("削除"),
    "deleteMultipTip": m1,
    "deleteTip": m2,
    "desc": MessageLookupByLibrary.simpleMessage(
      "ClashMetaベースのマルチプラットフォームプロキシクライアント。シンプルで使いやすく、オープンソースで広告なし。",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("宛先"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage("宛先地理情報"),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage("宛先IP ASN"),
    "details": m3,
    "detectionTip": MessageLookupByLibrary.simpleMessage("サードパーティAPIに依存（参考値）"),
    "developerMode": MessageLookupByLibrary.simpleMessage("デベロッパーモード"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "デベロッパーモードが有効になりました。",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("ダイレクト"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("UDPを無効化"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("免責事項"),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "本ソフトウェアは学習交流や科学研究などの非営利目的でのみ使用されます。商用利用は厳禁です。いかなる商用活動も本ソフトウェアとは無関係です。",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage("切断済み"),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage("新バージョンを発見"),
    "dnsDesc": MessageLookupByLibrary.simpleMessage("DNS関連設定の更新"),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("DNSハイジャッキング"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNSモード"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage("通過させますか？"),
    "domain": MessageLookupByLibrary.simpleMessage("ドメイン"),
    "download": MessageLookupByLibrary.simpleMessage("ダウンロード"),
    "edit": MessageLookupByLibrary.simpleMessage("編集"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage("グローバルルールを編集"),
    "editProxy": MessageLookupByLibrary.simpleMessage("プロキシを編集"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage("プロキシグループを編集"),
    "editRule": MessageLookupByLibrary.simpleMessage("ルールを編集"),
    "editSsid": MessageLookupByLibrary.simpleMessage("SSIDを編集"),
    "editTailscaleNode": MessageLookupByLibrary.simpleMessage(
      "Tailscale ノードを編集",
    ),
    "emptyTip": m4,
    "en": MessageLookupByLibrary.simpleMessage("英語"),
    "entries": MessageLookupByLibrary.simpleMessage(" エントリ"),
    "entriesCount": m5,
    "exclude": MessageLookupByLibrary.simpleMessage("最近のタスクから非表示"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "アプリがバックグラウンド時に最近のタスクから非表示",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage("除外プロキシフィルター"),
    "excludeSsids": MessageLookupByLibrary.simpleMessage("Exclude SSIDs"),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "When connected to an excluded SSID Wi-Fi, the app running state will be automatically switched.",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("除外タイプ"),
    "existsTip": m6,
    "exit": MessageLookupByLibrary.simpleMessage("終了"),
    "expand": MessageLookupByLibrary.simpleMessage("標準"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("期待されるステータス"),
    "exportFile": MessageLookupByLibrary.simpleMessage("ファイルをエクスポート"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("ログをエクスポート"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("エクスポート成功"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("エクスプレッシブ"),
    "externalController": MessageLookupByLibrary.simpleMessage("外部コントローラー"),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとClashコアをポート9090で制御可能",
    ),
    "externalFetch": MessageLookupByLibrary.simpleMessage("外部取得"),
    "externalLink": MessageLookupByLibrary.simpleMessage("外部リンク"),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fakeipフィルター"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fakeip範囲"),
    "fallback": MessageLookupByLibrary.simpleMessage("フォールバック"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage("通常はオフショアDNSを使用"),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("フォールバックフィルター"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("ハイファイデリティー"),
    "file": MessageLookupByLibrary.simpleMessage("ファイル"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("プロファイルを直接アップロード"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "ファイルが変更されました。保存しますか？",
    ),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("プロセス検出"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとパフォーマンスが若干低下します",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("フォントファミリー"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "コアを強制再起動してもよろしいですか？",
    ),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("フルーツサラダ"),
    "general": MessageLookupByLibrary.simpleMessage("一般"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("自動更新"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage("自動更新間隔"),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "自動更新間隔は0より大きくなければなりません",
    ),
    "geoIdentity": MessageLookupByLibrary.simpleMessage("地理アイデンティティ"),
    "geoIdentityActionsTitle": MessageLookupByLibrary.simpleMessage("外部ツール"),
    "geoIdentityAlignOsTimezone": MessageLookupByLibrary.simpleMessage(
      "OS タイムゾーンを出口に合わせる",
    ),
    "geoIdentityAlignOsTimezoneApplied": m7,
    "geoIdentityAlignOsTimezoneDesc": MessageLookupByLibrary.simpleMessage(
      "ネットワークを検証してから、デスクトップの OS タイムゾーンを出口の地理タイムゾーンに設定します。環境によっては管理者 / polkit が必要です。",
    ),
    "geoIdentityAlignOsTimezoneShort": MessageLookupByLibrary.simpleMessage(
      "OS タイムゾーンを出口に合わせる",
    ),
    "geoIdentityAndroidStep1": MessageLookupByLibrary.simpleMessage(
      "プロキシ画面でクリーンな米国ノードを選びます。",
    ),
    "geoIdentityAndroidStep2": MessageLookupByLibrary.simpleMessage(
      "ワンクリック設定をタップ（VPN キャプチャを有効化し FlClash を開始）。",
    ),
    "geoIdentityAndroidStep3": MessageLookupByLibrary.simpleMessage(
      "ネットワークチェックが保護済みであることを確認します。",
    ),
    "geoIdentityAndroidStep4": MessageLookupByLibrary.simpleMessage(
      "システムの日付と時刻で米国ゾーンを設定します。この端末で閲覧する場合は Chrome に GeoMirror を。",
    ),
    "geoIdentityCaptureBoth": MessageLookupByLibrary.simpleMessage(
      "システムプロキシ + TUN/VPN",
    ),
    "geoIdentityCaptureBothDesc": MessageLookupByLibrary.simpleMessage(
      "両方のキャプチャ経路がオンです。通信は FlClash 経由になるはずです。地理アイデンティティのため米国ノードを選択したままにしてください。",
    ),
    "geoIdentityCaptureInactive": MessageLookupByLibrary.simpleMessage(
      "キャプチャオフ",
    ),
    "geoIdentityCaptureInactiveDesc": MessageLookupByLibrary.simpleMessage(
      "先に FlClash を開始し、デスクトップではシステムプロキシと/または TUN、Android では VPN を有効にして、アプリ通信が選択ノード経由になるようにしてください。",
    ),
    "geoIdentityCaptureMixedPortOnly": MessageLookupByLibrary.simpleMessage(
      "ミックスポートのみ",
    ),
    "geoIdentityCaptureMixedPortOnlyDesc": MessageLookupByLibrary.simpleMessage(
      "コアは動作中ですが、システムプロキシも TUN/VPN もオフです。FlClash 自身のチェックはミックスポート経由でも、ほとんどのアプリは通りません。潜伏カバレッジにはシステムプロキシか TUN/VPN を有効にしてください。",
    ),
    "geoIdentityCaptureSystemProxy": MessageLookupByLibrary.simpleMessage(
      "システムプロキシキャプチャ",
    ),
    "geoIdentityCaptureSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "システムプロキシに従うアプリは FlClash 経由で出口します。バイパスするアプリもあるため、より広い潜伏には TUN/VPN を推奨します。",
    ),
    "geoIdentityCaptureVirtualNic": MessageLookupByLibrary.simpleMessage(
      "TUN / VPN キャプチャ",
    ),
    "geoIdentityCaptureVirtualNicDesc": MessageLookupByLibrary.simpleMessage(
      "仮想 NIC / VPN が通信をキャプチャしています。米国出口ノードと組み合わせると、FlClash の最強のネットワーク潜伏モードです。",
    ),
    "geoIdentityCheckCaptureAndroidBody": MessageLookupByLibrary.simpleMessage(
      "VPN キャプチャがオンで、アプリは FlClash 経由です。",
    ),
    "geoIdentityCheckCaptureDesktopBody": MessageLookupByLibrary.simpleMessage(
      "システムプロキシと/または TUN がアプリとターミナルをキャプチャしています。",
    ),
    "geoIdentityCheckCaptureTitle": MessageLookupByLibrary.simpleMessage(
      "通信キャプチャ準備完了",
    ),
    "geoIdentityCheckFailed": MessageLookupByLibrary.simpleMessage(
      "ネットワークチェックに失敗",
    ),
    "geoIdentityCheckNetworkBody": MessageLookupByLibrary.simpleMessage(
      "米国ノードを選んだあと検証（またはワンクリック）を実行してください。",
    ),
    "geoIdentityCheckNetworkTitle": MessageLookupByLibrary.simpleMessage(
      "ネットワークは米国保護に見える",
    ),
    "geoIdentityCheckProtectBody": MessageLookupByLibrary.simpleMessage(
      "米国 Accept-Language 探査と潜伏ガイダンスが有効です。",
    ),
    "geoIdentityCheckProtectTitle": MessageLookupByLibrary.simpleMessage(
      "地理保護オン",
    ),
    "geoIdentityCheckStartedBody": MessageLookupByLibrary.simpleMessage(
      "コアが動作中で、選択ノード経由で出口できます。",
    ),
    "geoIdentityCheckStartedTitle": MessageLookupByLibrary.simpleMessage(
      "FlClash 起動済み",
    ),
    "geoIdentityCheckTimezoneBody": MessageLookupByLibrary.simpleMessage(
      "中国ローカルではなく、または出口タイムゾーンに合わせてあります。",
    ),
    "geoIdentityCheckTimezoneTitle": MessageLookupByLibrary.simpleMessage(
      "Claude Code 向け OS タイムゾーン準備完了",
    ),
    "geoIdentityChecklistTitle": MessageLookupByLibrary.simpleMessage(
      "米国アイデンティティのチェックリスト",
    ),
    "geoIdentityChipCapture": MessageLookupByLibrary.simpleMessage("キャプチャ"),
    "geoIdentityChipNetwork": MessageLookupByLibrary.simpleMessage("米国出口"),
    "geoIdentityChipProtect": MessageLookupByLibrary.simpleMessage("保護"),
    "geoIdentityChipStarted": MessageLookupByLibrary.simpleMessage("起動"),
    "geoIdentityChipTimezone": MessageLookupByLibrary.simpleMessage("タイムゾーン"),
    "geoIdentityClaudeCodeBaseUrlBody": MessageLookupByLibrary.simpleMessage(
      "独自 API Base URL を使う場合、中国の AI ラボ / リセラーを連想させるホスト名を避けてください。公式 Anthropic エンドポイントかクリーンなホスト名を使い、通信は米国ノード経由にしてください。",
    ),
    "geoIdentityClaudeCodeBaseUrlTitle": MessageLookupByLibrary.simpleMessage(
      "ANTHROPIC_BASE_URL に注意",
    ),
    "geoIdentityClaudeCodeBody": MessageLookupByLibrary.simpleMessage(
      "GeoMirror は Claude Code には効きません。CLI は OS のタイムゾーンを読み、通信は FlClash 経由で出口する必要があります（TUN/VPN 推奨）。システムプロキシのみの場合は、同じターミナルにプロキシ環境変数を貼ってから claude を実行してください。",
    ),
    "geoIdentityClaudeCodeTimezoneTipBody": MessageLookupByLibrary.simpleMessage(
      "公開された解析によると、ANTHROPIC_BASE_URL が独自エンドポイントのとき Claude Code は Asia/Shanghai と Asia/Urumqi を確認していました。OS のタイムゾーンを米国出口に合わせてください（例: America/Los_Angeles）。",
    ),
    "geoIdentityClaudeCodeTimezoneTipTitle":
        MessageLookupByLibrary.simpleMessage("OS タイムゾーンが CLI の信号"),
    "geoIdentityClaudeCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Claude Code（ターミナル）",
    ),
    "geoIdentityCopyTerminalProxy": MessageLookupByLibrary.simpleMessage(
      "ターミナル用プロキシ環境変数をコピー",
    ),
    "geoIdentityCopyTerminalProxyDesc": MessageLookupByLibrary.simpleMessage(
      "FlClash ミックスポート向けの HTTP(S)_PROXY / ALL_PROXY — TUN なしで Node がシステムプロキシを無視する場合に必要です。",
    ),
    "geoIdentityCopyTerminalProxyShort": MessageLookupByLibrary.simpleMessage(
      "ターミナル用 HTTP(S)_PROXY をコピー",
    ),
    "geoIdentityDesc": MessageLookupByLibrary.simpleMessage(
      "ワンクリックで米国出口を潜伏（アプリと Claude Code）",
    ),
    "geoIdentityDesktopStep1": MessageLookupByLibrary.simpleMessage(
      "プロキシ画面でクリーンな米国ノードを選びます。",
    ),
    "geoIdentityDesktopStep2": MessageLookupByLibrary.simpleMessage(
      "ワンクリック設定をタップ（またはシステムプロキシ + TUN を有効にして FlClash を開始）。",
    ),
    "geoIdentityDesktopStep3": MessageLookupByLibrary.simpleMessage(
      "チェックリストでネットワーク保護を確認し、必要なら OS タイムゾーンを合わせます。",
    ),
    "geoIdentityDesktopStep4": MessageLookupByLibrary.simpleMessage(
      "ブラウザは GeoMirror を入れてください。Claude Code は TUN 推奨（ターミナルのプロキシ export 不要）。",
    ),
    "geoIdentityExitCountry": MessageLookupByLibrary.simpleMessage(
      "チェック上の出口地理",
    ),
    "geoIdentityGuideTitle": MessageLookupByLibrary.simpleMessage("手動ステップ"),
    "geoIdentityHideAdvanced": MessageLookupByLibrary.simpleMessage("詳細を隠す"),
    "geoIdentityLimitsBody": MessageLookupByLibrary.simpleMessage(
      "FlClash はネットワーク出口を隠し、FuckClaude API で IP 地理と Accept-Language を検証できます。他アプリの HTTPS ヘッダ改変、フォント/位置情報の偽装、AI サービス利用の保証はせず、各サービスの利用規約の代わりにもなりません。",
    ),
    "geoIdentityLimitsTitle": MessageLookupByLibrary.simpleMessage("限界と免責"),
    "geoIdentityLiveChecklistTitle": m8,
    "geoIdentityLocalSignalsTitle": MessageLookupByLibrary.simpleMessage(
      "この端末の信号",
    ),
    "geoIdentityLocalTipBody": MessageLookupByLibrary.simpleMessage(
      "タイムゾーン、ブラウザ言語、フォント、HTML5 位置情報はプロキシの外です。Claude Code / CLI は OS のタイムゾーンを、Web は GeoMirror などの拡張を使って揃えてください。",
    ),
    "geoIdentityLocalTipTitle": MessageLookupByLibrary.simpleMessage(
      "FlClash では変えられないもの",
    ),
    "geoIdentityNeedStart": MessageLookupByLibrary.simpleMessage(
      "ネットワーク環境を検証する前に FlClash を開始してください。",
    ),
    "geoIdentityNetworkCheckTitle": MessageLookupByLibrary.simpleMessage(
      "ネットワーク環境チェック",
    ),
    "geoIdentityNetworkExposed": MessageLookupByLibrary.simpleMessage(
      "ネットワークはまだ露出している可能性",
    ),
    "geoIdentityNetworkProtected": MessageLookupByLibrary.simpleMessage(
      "ネットワークは保護されているように見える",
    ),
    "geoIdentityOneClickSetup": MessageLookupByLibrary.simpleMessage(
      "ワンクリック設定",
    ),
    "geoIdentityOneClickTip": MessageLookupByLibrary.simpleMessage(
      "先に米国プロキシノードを選んでください。ブラウザ指紋には GeoMirror が必要です。このボタンは FlClash と Claude Code のホスト側をカバーします。",
    ),
    "geoIdentityOpenGeoMirror": MessageLookupByLibrary.simpleMessage(
      "GeoMirror（GitHub）",
    ),
    "geoIdentityOpenGeoMirrorDesc": MessageLookupByLibrary.simpleMessage(
      "出口 IP に地理信号を合わせる Chrome 拡張",
    ),
    "geoIdentityOpenGeoMirrorReleases": MessageLookupByLibrary.simpleMessage(
      "GeoMirror リリース",
    ),
    "geoIdentityOpenGeoMirrorReleasesDesc":
        MessageLookupByLibrary.simpleMessage("パッケージ済み拡張をダウンロード"),
    "geoIdentityOpenGeoMirrorShort": MessageLookupByLibrary.simpleMessage(
      "ブラウザ指紋の整合",
    ),
    "geoIdentityOpenSelfCheck": MessageLookupByLibrary.simpleMessage(
      "フィンガープリント自己チェックを開く",
    ),
    "geoIdentityOpenSelfCheckDesc": MessageLookupByLibrary.simpleMessage(
      "FuckClaude — ブラウザ / タイムゾーンのリスク加重スキャン",
    ),
    "geoIdentityOverviewBody": MessageLookupByLibrary.simpleMessage(
      "米国の AI サービスは、出口 IP とタイムゾーン・言語・フォント・位置情報などのローカル信号を突き合わせることがあります。ロサンゼルスの IP なのに Asia/Shanghai や zh-CN だと高リスクです。FlClash はシステムプロキシと TUN/VPN でネットワーク出口を隠し、FuckClaude API で検証できます。OS のタイムゾーンとブラウザプロファイルは別途揃える必要があります。",
    ),
    "geoIdentityOverviewTitle": MessageLookupByLibrary.simpleMessage("なぜ重要か"),
    "geoIdentityProbeLanguage": MessageLookupByLibrary.simpleMessage(
      "チェックが見た Accept-Language",
    ),
    "geoIdentityProbeLanguageUnknown": MessageLookupByLibrary.simpleMessage(
      "不明",
    ),
    "geoIdentityProtectEnable": MessageLookupByLibrary.simpleMessage(
      "地理アイデンティティ保護を有効化",
    ),
    "geoIdentityProtectEnableDesc": MessageLookupByLibrary.simpleMessage(
      "米国出口の整合を有効な目標として扱い、ネットワーク探査で米国 Accept-Language を優先し、システムプロキシと TUN/VPN のキャプチャ状態を表示します。",
    ),
    "geoIdentityProtectTitle": MessageLookupByLibrary.simpleMessage("ネットワーク潜伏"),
    "geoIdentityQuickActionsTitle": MessageLookupByLibrary.simpleMessage(
      "クイック操作",
    ),
    "geoIdentityRestoreOsTimezone": MessageLookupByLibrary.simpleMessage(
      "以前の OS タイムゾーンを復元",
    ),
    "geoIdentityRestoreOsTimezoneDesc": m9,
    "geoIdentityRiskHigh": MessageLookupByLibrary.simpleMessage("不一致リスクが高い"),
    "geoIdentityRiskHighDesc": MessageLookupByLibrary.simpleMessage(
      "タイムゾーンとシステムロケールの両方が中国ローカルに見えます。米国出口 IP だけでは足りません。OS のタイムゾーンを変え、ブラウザプロファイルを揃えてください。",
    ),
    "geoIdentityRiskLow": MessageLookupByLibrary.simpleMessage(
      "ローカル信号は整合していそう",
    ),
    "geoIdentityRiskLowDesc": MessageLookupByLibrary.simpleMessage(
      "タイムゾーンオフセットとシステムロケールは中国ローカルには見えません。それでもネットワークチェックとブラウザプロファイルを確認してください。",
    ),
    "geoIdentityRiskMedium": MessageLookupByLibrary.simpleMessage("地理の不一致の可能性"),
    "geoIdentityRiskMediumDesc": MessageLookupByLibrary.simpleMessage(
      "タイムゾーンまたはシステムロケールが中国ローカル（あるいは UTC+8）に見えます。出口 IP が米国なら、OS のタイムゾーンとブラウザ言語を先に揃えてください。",
    ),
    "geoIdentityScenarioAndroidBody": MessageLookupByLibrary.simpleMessage(
      "ワンクリックで地理保護と VPN キャプチャを有効化し、FlClash を開始して出口を検証します。端末で Claude Code を使う場合は、システムの日付と時刻で米国ゾーンを設定してください。",
    ),
    "geoIdentityScenarioAndroidTitle": MessageLookupByLibrary.simpleMessage(
      "Android 初心者セットアップ",
    ),
    "geoIdentityScenarioDesktopBody": MessageLookupByLibrary.simpleMessage(
      "ワンクリックで地理保護・システムプロキシ・TUN を有効化し、FlClash を開始して出口を検証し、Claude Code 向けに OS タイムゾーンの合わせ込みを試します。",
    ),
    "geoIdentityScenarioDesktopTitle": MessageLookupByLibrary.simpleMessage(
      "デスクトップ初心者セットアップ",
    ),
    "geoIdentitySetupDoneNeedTimezone": MessageLookupByLibrary.simpleMessage(
      "ネットワークは保護されています。Claude Code がまだ中国ゾーンなら OS タイムゾーンを合わせてください。",
    ),
    "geoIdentitySetupDoneNeedUsNode": MessageLookupByLibrary.simpleMessage(
      "設定は適用されましたが、出口はまだ米国保護ではありません。米国ノードを選んで再度ワンクリックしてください。",
    ),
    "geoIdentitySetupDoneProtected": MessageLookupByLibrary.simpleMessage(
      "セットアップ完了 — ネットワークは米国保護に見えます。",
    ),
    "geoIdentitySetupRunning": MessageLookupByLibrary.simpleMessage(
      "初心者セットアップを適用中…",
    ),
    "geoIdentitySetupStarting": MessageLookupByLibrary.simpleMessage(
      "FlClash を開始中…",
    ),
    "geoIdentitySetupTimezone": MessageLookupByLibrary.simpleMessage(
      "OS タイムゾーンを合わせています…",
    ),
    "geoIdentitySetupVerifying": MessageLookupByLibrary.simpleMessage(
      "ネットワーク環境を検証中…",
    ),
    "geoIdentityShowAdvanced": MessageLookupByLibrary.simpleMessage("詳細を表示"),
    "geoIdentityStatusReadyBody": MessageLookupByLibrary.simpleMessage(
      "ネットワーク潜伏は良好です。米国ノードを選択したままにしてください。",
    ),
    "geoIdentityStatusReadyTitle": MessageLookupByLibrary.simpleMessage("準備完了"),
    "geoIdentityStatusSetupBody": MessageLookupByLibrary.simpleMessage(
      "米国ノードを選び、ワンクリック設定をタップしてください。",
    ),
    "geoIdentityStatusSetupTitle": MessageLookupByLibrary.simpleMessage(
      "セットアップが必要",
    ),
    "geoIdentityStep1Body": MessageLookupByLibrary.simpleMessage(
      "プロキシ画面でクリーンな米国ノード（ロサンゼルスやニューヨークなど）を選びます。Claude Code を独自 Base URL に向ける場合、ホスト名に AI ラボや中継を連想させる語を避けてください。",
    ),
    "geoIdentityStep1Title": MessageLookupByLibrary.simpleMessage(
      "1. 米国の出口ノードを使う",
    ),
    "geoIdentityStep2Body": MessageLookupByLibrary.simpleMessage(
      "FlClash を開始し、デスクトップではシステムプロキシと/または TUN、Android では VPN を有効にして、アプリが本当に米国ノード経由になるようにします。その後「ネットワーク環境を検証」をタップします。",
    ),
    "geoIdentityStep2Title": MessageLookupByLibrary.simpleMessage(
      "2. 通信をキャプチャ（システムプロキシまたは TUN）",
    ),
    "geoIdentityStep3Body": MessageLookupByLibrary.simpleMessage(
      "OS のタイムゾーンを出口と同じ米国地域に設定します。GeoMirror を入れ、位置情報・タイムゾーン・言語・Accept-Language・地域フォントの検出を出口 IP に合わせてください。",
    ),
    "geoIdentityStep3Title": MessageLookupByLibrary.simpleMessage(
      "3. OS のタイムゾーンとブラウザを揃える",
    ),
    "geoIdentityStep4Body": MessageLookupByLibrary.simpleMessage(
      "通信が FlClash 経由の状態で FuckClaude のブラウザスキャンを開き、Low を目指します。OS やブラウザを変えたら再測定してください。ルールは変わるので継続的に管理してください。",
    ),
    "geoIdentityStep4Title": MessageLookupByLibrary.simpleMessage(
      "4. 自己チェックして再確認",
    ),
    "geoIdentitySystemLocale": MessageLookupByLibrary.simpleMessage("システムロケール"),
    "geoIdentityTimezone": MessageLookupByLibrary.simpleMessage("システムタイムゾーン"),
    "geoIdentityTimezoneAndroidTip": MessageLookupByLibrary.simpleMessage(
      "Android は root なしではシステムタイムゾーンを変更できません。設定 → システム → 日付と時刻で、出口に合う米国ゾーンを選んでください。",
    ),
    "geoIdentityTimezoneApplied": m10,
    "geoIdentityTimezoneManual": m11,
    "geoIdentityTimezoneMissing": MessageLookupByLibrary.simpleMessage(
      "出口タイムゾーンがまだありません。先にネットワーク環境を検証してください。",
    ),
    "geoIdentityTimezoneNothingToRestore": MessageLookupByLibrary.simpleMessage(
      "復元できる以前の OS タイムゾーンがありません。",
    ),
    "geoIdentityTimezoneRestored": m12,
    "geoIdentityTimezoneUnsupported": m13,
    "geoIdentityUsAcceptLanguage": MessageLookupByLibrary.simpleMessage(
      "米国 Accept-Language で探査",
    ),
    "geoIdentityUsAcceptLanguageDesc": MessageLookupByLibrary.simpleMessage(
      "FuckClaude ネットワークチェックで Accept-Language: en-US,en;q=0.9 を送り、中国語ヘッダでスコアが上がらないようにします。",
    ),
    "geoIdentityVerifyNetwork": MessageLookupByLibrary.simpleMessage(
      "ネットワーク環境を検証",
    ),
    "geoIdentityVerifyNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "FlClash のミックスポート経由で FuckClaude /api/check を呼び出します（システムプロキシと TUN/VPN の両方で有効）。",
    ),
    "geoIdentityVerifyNetworkShort": MessageLookupByLibrary.simpleMessage(
      "FuckClaude で出口 IP を確認",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Geoオプション"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Geoリソース"),
    "geoSkipped": m14,
    "geoUpdated": m15,
    "geoUpdating": m16,
    "geodataLoader": MessageLookupByLibrary.simpleMessage("Geo低メモリモード"),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとGeo低メモリローダーを使用",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("GeoIPコード"),
    "global": MessageLookupByLibrary.simpleMessage("グローバル"),
    "go": MessageLookupByLibrary.simpleMessage("移動"),
    "goDownload": MessageLookupByLibrary.simpleMessage("ダウンロードへ"),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage("スクリプト設定に移動"),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage("変更をキャッシュしますか？"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("リストから隠す"),
    "host": MessageLookupByLibrary.simpleMessage("ホスト"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("ホストを追加"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage("ホットキー競合"),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("ホットキー管理"),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "キーボードでアプリを制御",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("時間"),
    "hoursAgo": m17,
    "hoursCount": m18,
    "icon": MessageLookupByLibrary.simpleMessage("アイコン"),
    "iconRecords": MessageLookupByLibrary.simpleMessage("アイコン履歴"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("アイコンスタイル"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("アイコンURL"),
    "ignoreBatteryOptimization": MessageLookupByLibrary.simpleMessage(
      "Ignore Battery Optimization",
    ),
    "import": MessageLookupByLibrary.simpleMessage("インポート"),
    "importFile": MessageLookupByLibrary.simpleMessage("ファイルからインポート"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("URLからインポート"),
    "importUrl": MessageLookupByLibrary.simpleMessage("URLからインポート"),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage("すべてのプロキシを含める"),
    "includeAllProxiesTip": MessageLookupByLibrary.simpleMessage(
      "プロキシグループに含まれないすべてのプロキシをインポートします。下でさらにプロキシグループを追加できます",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "すべてのプロキシプロバイダーを含める",
    ),
    "includeAllProxyProvidersTip": MessageLookupByLibrary.simpleMessage(
      "有効にすると、インポートされたプロキシプロバイダーを上書きします",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("長期有効"),
    "init": MessageLookupByLibrary.simpleMessage("初期化"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage("正しいホットキーを入力"),
    "inputProxyGroupName": MessageLookupByLibrary.simpleMessage("プロキシグループ名を入力"),
    "inputRuleContent": MessageLookupByLibrary.simpleMessage("ルール内容を入力"),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage("インテリジェント選択"),
    "internet": MessageLookupByLibrary.simpleMessage("インターネット"),
    "interval": MessageLookupByLibrary.simpleMessage("インターバル"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("イントラネットIP"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage("無効なバックアップファイル"),
    "invalidPolicy": m19,
    "invalidProxy": m20,
    "invalidProxyProvider": m21,
    "invalidSubRule": m22,
    "ipcidr": MessageLookupByLibrary.simpleMessage("IPCIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage("有効化するとIPv6トラフィックを受信可能"),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage("IPv6インバウンドを許可"),
    "ja": MessageLookupByLibrary.simpleMessage("日本語"),
    "justNow": MessageLookupByLibrary.simpleMessage("たった今"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "TCPキープアライブ間隔",
    ),
    "key": MessageLookupByLibrary.simpleMessage("キー"),
    "language": MessageLookupByLibrary.simpleMessage("言語"),
    "layout": MessageLookupByLibrary.simpleMessage("レイアウト"),
    "light": MessageLookupByLibrary.simpleMessage("ライト"),
    "list": MessageLookupByLibrary.simpleMessage("リスト"),
    "listen": MessageLookupByLibrary.simpleMessage("リスン"),
    "loadTest": MessageLookupByLibrary.simpleMessage("読み込みテスト"),
    "loading": MessageLookupByLibrary.simpleMessage("読み込み中..."),
    "local": MessageLookupByLibrary.simpleMessage("ローカル"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage("ローカルにデータをバックアップ"),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Location Permission",
    ),
    "locationPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "位置情報の権限が拒否されたため、現在の Wi-Fi 名を取得できません。システム設定で位置情報の権限を手動で有効にしてください。",
    ),
    "locationPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "According to system requirements, obtaining the Wi-Fi name requires you to grant location permission.",
    ),
    "locationPermissionGuide": m23,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Location Permission Required",
    ),
    "log": MessageLookupByLibrary.simpleMessage("ログ"),
    "logLevel": MessageLookupByLibrary.simpleMessage("ログレベル"),
    "logcat": MessageLookupByLibrary.simpleMessage("ログキャット"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage("無効化するとログエントリを非表示"),
    "logs": MessageLookupByLibrary.simpleMessage("ログ"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("ログキャプチャ記録"),
    "logsTest": MessageLookupByLibrary.simpleMessage("ログテスト"),
    "loopback": MessageLookupByLibrary.simpleMessage("ループバック解除ツール"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage("UWPループバック解除用"),
    "loose": MessageLookupByLibrary.simpleMessage("疎"),
    "matchSourceIp": MessageLookupByLibrary.simpleMessage("送信元IPをマッチング"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage("最大失敗回数"),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("メモリ情報"),
    "messageTest": MessageLookupByLibrary.simpleMessage("メッセージテスト"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("これはメッセージです。"),
    "min": MessageLookupByLibrary.simpleMessage("最小化"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("終了時に最小化"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "システムの終了イベントを変更",
    ),
    "minutesAgo": m24,
    "mixedPort": MessageLookupByLibrary.simpleMessage("混合ポート"),
    "mode": MessageLookupByLibrary.simpleMessage("モード"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("モノクローム"),
    "monthsAgo": m25,
    "more": MessageLookupByLibrary.simpleMessage("詳細"),
    "name": MessageLookupByLibrary.simpleMessage("名前"),
    "nameserver": MessageLookupByLibrary.simpleMessage("ネームサーバー"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage("ドメイン解決用"),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage("ネームサーバーポリシー"),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "対応するネームサーバーポリシーを指定",
    ),
    "network": MessageLookupByLibrary.simpleMessage("ネットワーク"),
    "networkDesc": MessageLookupByLibrary.simpleMessage("ネットワーク関連設定の変更"),
    "networkDetection": MessageLookupByLibrary.simpleMessage("ネットワーク検出"),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "ネットワーク例外、接続を確認してもう一度お試しください",
    ),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("ネットワーク速度"),
    "networkType": MessageLookupByLibrary.simpleMessage("ネットワーク種別"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("ニュートラル"),
    "noData": MessageLookupByLibrary.simpleMessage("データなし"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("ホットキーなし"),
    "noInfo": MessageLookupByLibrary.simpleMessage("情報なし"),
    "noLongerRemind": MessageLookupByLibrary.simpleMessage("今後表示しない"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("ネットワークなし"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("ネットワークなしアプリ"),
    "noRecords": MessageLookupByLibrary.simpleMessage("履歴なし"),
    "noResolve": MessageLookupByLibrary.simpleMessage("IPを解決しない"),
    "noResolveHostname": MessageLookupByLibrary.simpleMessage("ホスト名を解決しない"),
    "none": MessageLookupByLibrary.simpleMessage("なし"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "現在のプロキシグループは選択できません",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルがありません。追加してください",
    ),
    "nullTip": m26,
    "numberTip": m27,
    "onDemand": MessageLookupByLibrary.simpleMessage("On Demand"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "Configure the program running state for specific scenarios",
    ),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("アイコンのみ"),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage("プロキシのみ統計"),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとプロキシトラフィックのみ統計",
    ),
    "optional": MessageLookupByLibrary.simpleMessage("オプション"),
    "options": MessageLookupByLibrary.simpleMessage("オプション"),
    "other": MessageLookupByLibrary.simpleMessage("その他"),
    "otherContributors": MessageLookupByLibrary.simpleMessage("その他の貢献者"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("アウトバウンドモード"),
    "override": MessageLookupByLibrary.simpleMessage("上書き"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("DNS上書き"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとプロファイルのDNS設定を上書き",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage("上書きモード"),
    "overrideScript": MessageLookupByLibrary.simpleMessage("上書きスクリプト"),
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage("カスタム"),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "カスタムモード、プロキシグループとルールを完全にカスタマイズ可能",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("パレット"),
    "password": MessageLookupByLibrary.simpleMessage("パスワード"),
    "paste": MessageLookupByLibrary.simpleMessage("貼り付け"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "WebDAVをバインドしてください",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "スクリプト名を入力してください",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "管理者パスワードを入力",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "有効なQRコードをアップロードしてください",
    ),
    "port": MessageLookupByLibrary.simpleMessage("ポート"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage("別のポートを入力してください"),
    "portTip": m28,
    "preferH3Desc": MessageLookupByLibrary.simpleMessage("DOHのHTTP/3を優先使用"),
    "prerequisites": MessageLookupByLibrary.simpleMessage("Prerequisites"),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("キーボードを押してください"),
    "preview": MessageLookupByLibrary.simpleMessage("プレビュー"),
    "process": MessageLookupByLibrary.simpleMessage("プロセス"),
    "profile": MessageLookupByLibrary.simpleMessage("プロファイル"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("有効な間隔形式を入力してください"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage("自動更新間隔を入力してください"),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "プロファイルが変更されました。自動更新を無効化しますか？",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイル名を入力してください",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "有効なプロファイルURLを入力してください",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルURLを入力してください",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("プロファイル一覧"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("プロファイルの並び替え"),
    "project": MessageLookupByLibrary.simpleMessage("プロジェクト"),
    "providers": MessageLookupByLibrary.simpleMessage("プロバイダー"),
    "proxies": MessageLookupByLibrary.simpleMessage("プロキシ"),
    "proxiesEmpty": MessageLookupByLibrary.simpleMessage("プロキシが空です"),
    "proxyChains": MessageLookupByLibrary.simpleMessage("プロキシチェーン"),
    "proxyDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "選択されたプロキシに異常があることを検出しました",
    ),
    "proxyFilter": MessageLookupByLibrary.simpleMessage("プロキシフィルター"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("プロキシグループ"),
    "proxyGroupDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "現在のプロキシグループが異常であることを検出しました",
    ),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage("プロキシグループが空です"),
    "proxyGroupNameDuplicate": MessageLookupByLibrary.simpleMessage(
      "プロキシグループ名が重複しています",
    ),
    "proxyGroupNameEmpty": MessageLookupByLibrary.simpleMessage(
      "プロキシグループ名は空にできません",
    ),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage("プロキシネームサーバー"),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "プロキシノード解決用ドメイン",
    ),
    "proxyPort": MessageLookupByLibrary.simpleMessage("プロキシポート"),
    "proxyProviderDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "選択されたプロキシプロバイダーに異常があることを検出しました",
    ),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("プロキシプロバイダー"),
    "proxyProvidersEmpty": MessageLookupByLibrary.simpleMessage(
      "プロキシプロバイダーが空です",
    ),
    "proxyProvidersNotEmpty": MessageLookupByLibrary.simpleMessage(
      "プロキシプロバイダーは空にできません",
    ),
    "proxyType": MessageLookupByLibrary.simpleMessage("プロキシタイプ"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("キャッシュの削除"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("純黒モード"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QRコード"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage("QRコードをスキャンしてプロファイルを取得"),
    "quickFill": MessageLookupByLibrary.simpleMessage("クイック入力"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("レインボー"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redirポート"),
    "redo": MessageLookupByLibrary.simpleMessage("やり直す"),
    "remote": MessageLookupByLibrary.simpleMessage("リモート"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVにデータをバックアップ",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage("リモート宛先"),
    "remove": MessageLookupByLibrary.simpleMessage("削除"),
    "rename": MessageLookupByLibrary.simpleMessage("リネーム"),
    "request": MessageLookupByLibrary.simpleMessage("リクエスト"),
    "requests": MessageLookupByLibrary.simpleMessage("リクエスト"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage("最近のリクエスト記録を表示"),
    "reset": MessageLookupByLibrary.simpleMessage("リセット"),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "現在のページに変更があります。リセットしてもよろしいですか？",
    ),
    "resetTip": MessageLookupByLibrary.simpleMessage("リセットを確定"),
    "resources": MessageLookupByLibrary.simpleMessage("リソース"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage("外部リソース関連情報"),
    "respectRules": MessageLookupByLibrary.simpleMessage("ルール尊重"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS接続がルールに従う（proxy-server-nameserverの設定が必要）",
    ),
    "restart": MessageLookupByLibrary.simpleMessage("再起動"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage("コアを再起動してもよろしいですか？"),
    "restore": MessageLookupByLibrary.simpleMessage("復元"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage("すべてのデータを復元する"),
    "restoreException": MessageLookupByLibrary.simpleMessage("復元例外"),
    "restoreFromFileDesc": MessageLookupByLibrary.simpleMessage(
      "ファイルを介してデータを復元する",
    ),
    "restoreFromWebDAVDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVを介してデータを復元する",
    ),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage("設定ファイルのみを復元する"),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage("復元ストラテジー"),
    "restoreStrategy_compatible": MessageLookupByLibrary.simpleMessage("互換"),
    "restoreStrategy_override": MessageLookupByLibrary.simpleMessage("上書き"),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage("復元に成功しました"),
    "routeAddress": MessageLookupByLibrary.simpleMessage("ルートアドレス"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage("ルートアドレスを設定"),
    "routeMode": MessageLookupByLibrary.simpleMessage("ルートモード"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "プライベートルートをバイパス",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage("設定を使用"),
    "ru": MessageLookupByLibrary.simpleMessage("ロシア語"),
    "rule": MessageLookupByLibrary.simpleMessage("ルール"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage("論理ルール AND"),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage(
      "完全なドメインをマッチング",
    ),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "ドメインキーワードをマッチング",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "ワイルドカードマッチング（*と?のみサポート）",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "ドメイン接尾辞をマッチング",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "DSCPマークをマッチング (tproxy udp inboundのみ)",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "宛先ポート範囲をマッチング",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "IPの国コードをマッチング",
    ),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Match domains within Geosite",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage(
      "インバウンド名をマッチング",
    ),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage(
      "インバウンドポートをマッチング",
    ),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage(
      "インバウンドタイプをマッチング",
    ),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "インバウンドユーザー名をマッチング（/で複数指定可）",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage("IPのASNをマッチング"),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "IPアドレス範囲をマッチング（IP-CIDR6はエイリアスです）",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "IPアドレス範囲をマッチング",
    ),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "IP接尾辞範囲をマッチング",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "すべてのリクエストにマッチ（条件なし）",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "TCPまたはUDPをマッチング",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage("論理ルール NOT"),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage("論理ルール OR"),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "プロセス名でマッチング（Androidではパッケージ名）",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "プロセス名正規表現でマッチング（Androidではパッケージ名）",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "フルプロセスパスでマッチング",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "プロセスパス正規表現でマッチング",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "ルールセットを参照。rule-providersの設定が必要",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "送信元IPの国コードをマッチング",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "送信元IPのASNをマッチング",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "送信元IPアドレス範囲をマッチング",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "送信元IP接尾辞範囲をマッチング",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "送信元ポート範囲をマッチング",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "サブルールにマッチング。括弧の使用に注意",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "Linux USER IDをマッチング",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("ルールが空です"),
    "ruleName": MessageLookupByLibrary.simpleMessage("ルール名"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("ルールプロバイダー"),
    "ruleSet": MessageLookupByLibrary.simpleMessage("ルールセット"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("ルール対象"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("変更を保存しますか？"),
    "script": MessageLookupByLibrary.simpleMessage("スクリプト"),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "スクリプトモード、外部拡張スクリプトを使用し、ワンクリックで設定を上書きする機能を提供",
    ),
    "search": MessageLookupByLibrary.simpleMessage("検索"),
    "seconds": MessageLookupByLibrary.simpleMessage("秒"),
    "secondsCount": m29,
    "selectAll": MessageLookupByLibrary.simpleMessage("すべて選択"),
    "selectProxies": MessageLookupByLibrary.simpleMessage("プロキシを選択"),
    "selectProxyProviders": MessageLookupByLibrary.simpleMessage(
      "プロキシプロバイダーを選択",
    ),
    "selectRuleSet": MessageLookupByLibrary.simpleMessage("ルールセットを選択してください"),
    "selectSplitStrategy": MessageLookupByLibrary.simpleMessage(
      "分流戦略を選択してください",
    ),
    "selectSubRule": MessageLookupByLibrary.simpleMessage("サブルールを選択してください"),
    "selected": MessageLookupByLibrary.simpleMessage("選択済み"),
    "selectedCountTitle": m30,
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "show": MessageLookupByLibrary.simpleMessage("表示"),
    "shrink": MessageLookupByLibrary.simpleMessage("縮小"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("バックグラウンド起動"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage("バックグラウンドで起動"),
    "size": MessageLookupByLibrary.simpleMessage("サイズ"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socksポート"),
    "sort": MessageLookupByLibrary.simpleMessage("並び替え"),
    "source": MessageLookupByLibrary.simpleMessage("ソース"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("送信元IP"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("特殊プロキシ"),
    "specialRules": MessageLookupByLibrary.simpleMessage("特殊ルール"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage("速度統計"),
    "splitStrategy": MessageLookupByLibrary.simpleMessage("分流戦略"),
    "splitStrategyNotEmpty": MessageLookupByLibrary.simpleMessage(
      "分流戦略は空にできません",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("SSIDs is empty"),
    "stackMode": MessageLookupByLibrary.simpleMessage("スタックモード"),
    "standard": MessageLookupByLibrary.simpleMessage("標準"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "標準モード、基本設定を上書きし、シンプルなルール追加機能を提供",
    ),
    "start": MessageLookupByLibrary.simpleMessage("開始"),
    "startVpn": MessageLookupByLibrary.simpleMessage("VPNを開始中..."),
    "status": MessageLookupByLibrary.simpleMessage("ステータス"),
    "statusDesc": MessageLookupByLibrary.simpleMessage("無効時はシステムDNSを使用"),
    "stop": MessageLookupByLibrary.simpleMessage("停止"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("VPNを停止中..."),
    "style": MessageLookupByLibrary.simpleMessage("スタイル"),
    "subRule": MessageLookupByLibrary.simpleMessage("サブルール"),
    "subRuleEmpty": MessageLookupByLibrary.simpleMessage("サブルールが空です"),
    "subRuleNotEmpty": MessageLookupByLibrary.simpleMessage("サブルールは空にできません"),
    "submit": MessageLookupByLibrary.simpleMessage("送信"),
    "suspended": MessageLookupByLibrary.simpleMessage("一時停止中..."),
    "sync": MessageLookupByLibrary.simpleMessage("同期"),
    "system": MessageLookupByLibrary.simpleMessage("システム"),
    "systemApp": MessageLookupByLibrary.simpleMessage("システムアプリ"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("システムプロキシ"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "HTTPプロキシをVpnServiceに接続",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("タブ"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("タブアニメーション"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage("モバイル表示でのみ有効"),
    "tailscale": MessageLookupByLibrary.simpleMessage("Tailscale"),
    "tailscaleAcceptRoutes": MessageLookupByLibrary.simpleMessage("ルートを受け入れる"),
    "tailscaleAndroidStep1": MessageLookupByLibrary.simpleMessage(
      "Tailscale 管理コンソール（設定 → Keys）で認証キーを取得します。",
    ),
    "tailscaleAndroidStep2": MessageLookupByLibrary.simpleMessage(
      "ノードを追加し、認証キーを貼り付け、ルーティング先に自宅デバイスの IP または MagicDNS 名を入れます。",
    ),
    "tailscaleAndroidStep3": MessageLookupByLibrary.simpleMessage(
      "「Tailscale を有効化」をオンにします。Tailscale アプリも入れている場合以外は「直結に保つ」はオフのままで構いません。",
    ),
    "tailscaleAndroidStep4": MessageLookupByLibrary.simpleMessage(
      "FlClash VPN を開始し、ノード横のピンボタンで接続を確認します。",
    ),
    "tailscaleAuthKey": MessageLookupByLibrary.simpleMessage("認証キー"),
    "tailscaleAuthKeyHint": MessageLookupByLibrary.simpleMessage(
      "Tailscale 管理コンソール → 設定 → Keys から取得します。ノードの認証に必要です。",
    ),
    "tailscaleBypass": MessageLookupByLibrary.simpleMessage(
      "Tailscale のトラフィックを直結に保つ",
    ),
    "tailscaleBypassAndroidHint": MessageLookupByLibrary.simpleMessage(
      "Android では通常オフのまま。この端末にも Tailscale アプリがある場合だけオンにしてください。",
    ),
    "tailscaleBypassDesc": MessageLookupByLibrary.simpleMessage(
      "FlClash による Tailscale の横取りを防ぎます。tailnet レンジ、Tailscale プロセス、コントロール/DERP ドメインの DIRECT ルールを自動注入し、これらのドメインを Fake IP Filter に自動で追加/削除します（198.18.x.x ではなく本物の公開 IP に解決）。この端末で Tailscale アプリ/サービスも動かす場合はオンにしてください（インポートした任意のプロファイルで有効）。",
    ),
    "tailscaleBypassRecommended": MessageLookupByLibrary.simpleMessage(
      "Tailscale アプリ/サービスが入っているデスクトップでは推奨。DIRECT ルールと Fake IP Filter を自動管理します。",
    ),
    "tailscaleControlUrl": MessageLookupByLibrary.simpleMessage("コントロール URL"),
    "tailscaleControlUrlHint": MessageLookupByLibrary.simpleMessage(
      "任意。Headscale などの自己ホスト型コントロールサーバー用です。",
    ),
    "tailscaleDesc": MessageLookupByLibrary.simpleMessage(
      "Tailscale アウトバウンドノードを管理",
    ),
    "tailscaleDesktopStep1": MessageLookupByLibrary.simpleMessage(
      "この PC で Tailscale アプリ/サービスも動かす場合は「Tailscale のトラフィックを直結に保つ」をオンにします。",
    ),
    "tailscaleDesktopStep2": MessageLookupByLibrary.simpleMessage(
      "任意: 認証キー付きの内蔵 Tailscale ノードを追加し、選択した通信を FlClash から tailnet 経由にします。",
    ),
    "tailscaleDesktopStep3": MessageLookupByLibrary.simpleMessage(
      "ルーティング先に宛先（自宅 IP / MagicDNS）を入れ、「Tailscale を有効化」をオンにします。",
    ),
    "tailscaleDesktopStep4": MessageLookupByLibrary.simpleMessage(
      "FlClash を開始し、ノード横のピンボタンで接続が安定しているか確認します。",
    ),
    "tailscaleEmptyTip": MessageLookupByLibrary.simpleMessage(
      "Tailscale ノードがありません。追加すると、トラフィックを tailnet 経由で転送できます。",
    ),
    "tailscaleEnable": MessageLookupByLibrary.simpleMessage("Tailscale を有効化"),
    "tailscaleEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Tailscale ノードをアウトバウンドとして注入します。オフにすると Tailscale はトラフィックを処理しなくなりますが、通常のトラフィックには影響しません。",
    ),
    "tailscaleEphemeral": MessageLookupByLibrary.simpleMessage("エフェメラル"),
    "tailscaleExitNode": MessageLookupByLibrary.simpleMessage("出口ノード"),
    "tailscaleExitNodeAllowLanAccess": MessageLookupByLibrary.simpleMessage(
      "出口ノード経由の LAN アクセスを許可",
    ),
    "tailscaleExitNodeHint": MessageLookupByLibrary.simpleMessage(
      "任意。すべてのトラフィックを転送する tailnet 出口ノードの IP または名前です。",
    ),
    "tailscaleGuideBypassNote": MessageLookupByLibrary.simpleMessage(
      "この端末で Tailscale アプリ/サービスも動かす場合は「Tailscale のトラフィックを直結に保つ」をオンにしてください。FlClash の fake-IP DNS が controlplane.tailscale.com を 198.18.x.x として返し、`tailscale up` が止まるのを防ぎます。",
    ),
    "tailscaleGuideRoutesNote": MessageLookupByLibrary.simpleMessage(
      "特定の端末（例: 自宅の PC）に接続するには、その Tailscale IP または MagicDNS 名をノードの「ルーティング先」に追加します。FlClash はその通信だけを tailnet 経由で送るため、この端末に Tailscale アプリは不要です。",
    ),
    "tailscaleGuideStep1": MessageLookupByLibrary.simpleMessage(
      "Tailscale 管理コンソール（設定 → Keys）で認証キーを取得します。",
    ),
    "tailscaleGuideStep2": MessageLookupByLibrary.simpleMessage(
      "右上の + ボタンをタップしてノードを追加し、認証キーを貼り付けます。",
    ),
    "tailscaleGuideStep3": MessageLookupByLibrary.simpleMessage(
      "上部の「Tailscale を有効化」をオンにして、ノードをアウトバウンドプロキシとして注入します。",
    ),
    "tailscaleGuideStep4": MessageLookupByLibrary.simpleMessage(
      "プロキシページまたはルールでノードを選択すると、トラフィックが tailnet 経由で転送されます。",
    ),
    "tailscaleGuideTitle": MessageLookupByLibrary.simpleMessage(
      "Tailscale の仕組み",
    ),
    "tailscaleHostname": MessageLookupByLibrary.simpleMessage("ホスト名"),
    "tailscaleHostnameHint": MessageLookupByLibrary.simpleMessage(
      "任意。tailnet に表示されるデバイス名です。",
    ),
    "tailscaleNameExistsTip": MessageLookupByLibrary.simpleMessage(
      "同じ名前のノードが既に存在します",
    ),
    "tailscaleNoRoutes": MessageLookupByLibrary.simpleMessage("ルーティング先なし"),
    "tailscaleNodesTitle": MessageLookupByLibrary.simpleMessage("ノード"),
    "tailscaleNotTested": MessageLookupByLibrary.simpleMessage("未テスト"),
    "tailscaleRoutes": MessageLookupByLibrary.simpleMessage("ルーティング先"),
    "tailscaleRoutesCount": m31,
    "tailscaleRoutesHint": MessageLookupByLibrary.simpleMessage(
      "このノード経由で送るドメインまたは IP（1 行に 1 つ、例: 自宅 PC の Tailscale IP や MagicDNS 名）。",
    ),
    "tailscaleScenarioAndroidBody": MessageLookupByLibrary.simpleMessage(
      "VPN は FlClash だけにしてください。Tailscale アプリの VPN と同時には使えません（Android は VPN を 1 つだけ許可）。下で内蔵 Tailscale ノードを追加し、自宅デバイスをルーティング先に入れてください。",
    ),
    "tailscaleScenarioAndroidTitle": MessageLookupByLibrary.simpleMessage(
      "Android クライアント設定",
    ),
    "tailscaleScenarioDesktopBody": MessageLookupByLibrary.simpleMessage(
      "FlClash と正式な Tailscale アプリを同時に使えます。「Tailscale のトラフィックを直結に保つ」をオンにして、FlClash が制御プレーンや fake-IP DNS を横取りしないようにします。",
    ),
    "tailscaleScenarioDesktopTitle": MessageLookupByLibrary.simpleMessage(
      "デスクトップ / ホスト設定",
    ),
    "tailscaleStateDir": MessageLookupByLibrary.simpleMessage("状態ディレクトリ"),
    "tailscaleStateDirHint": MessageLookupByLibrary.simpleMessage(
      "任意。Tailscale の状態を保存するディレクトリです。",
    ),
    "tailscaleStatusDisabled": MessageLookupByLibrary.simpleMessage(
      "Tailscale はオフです — ノードは実行中の設定に注入されません。",
    ),
    "tailscaleStatusNeedStart": MessageLookupByLibrary.simpleMessage(
      "ノードの準備ができました。FlClash VPN を開始してからピンでテストしてください。",
    ),
    "tailscaleStatusNoNodes": MessageLookupByLibrary.simpleMessage(
      "有効ですが、ノードがありません。まずノードを追加してください。",
    ),
    "tailscaleStatusReady": m32,
    "tailscaleTestNeedEnable": MessageLookupByLibrary.simpleMessage(
      "テストする前に「Tailscale を有効化」をオンにしてください。",
    ),
    "tailscaleTestNeedStart": MessageLookupByLibrary.simpleMessage(
      "接続をテストする前に FlClash VPN を開始してください。",
    ),
    "tailscaleTestNode": MessageLookupByLibrary.simpleMessage("接続をテスト"),
    "tailscaleTestTip": MessageLookupByLibrary.simpleMessage(
      "ノード横のピンボタンで、Tailscale アウトバウンドが発信できるか確認できます。遅延が表示されれば接続は正常です。Timeout の場合は認証キー、「有効化」、FlClash VPN の起動を確認してください。",
    ),
    "tailscaleTip": MessageLookupByLibrary.simpleMessage(
      "Tailscale ノードはアウトバウンドプロキシとして実行中の設定に統合されます。プロキシページでノードを選択するか、ルールのターゲットに指定すると、トラフィックが tailnet 経由で転送されます。",
    ),
    "tailscaleUdp": MessageLookupByLibrary.simpleMessage("UDP リレー"),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage("タップして許可"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP並列処理"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage("TCP並列処理を許可"),
    "testInterval": MessageLookupByLibrary.simpleMessage("テスト間隔"),
    "testUrl": MessageLookupByLibrary.simpleMessage("URLテスト"),
    "testWhenUsed": MessageLookupByLibrary.simpleMessage("使用時にテスト"),
    "textScale": MessageLookupByLibrary.simpleMessage("テキストスケーリング"),
    "theme": MessageLookupByLibrary.simpleMessage("テーマ"),
    "themeColor": MessageLookupByLibrary.simpleMessage("テーマカラー"),
    "themeDesc": MessageLookupByLibrary.simpleMessage("ダークモードの設定、色の調整"),
    "themeMode": MessageLookupByLibrary.simpleMessage("テーマモード"),
    "tight": MessageLookupByLibrary.simpleMessage("密"),
    "time": MessageLookupByLibrary.simpleMessage("時間"),
    "timeout": MessageLookupByLibrary.simpleMessage("タイムアウト"),
    "tip": MessageLookupByLibrary.simpleMessage("ヒント"),
    "toggle": MessageLookupByLibrary.simpleMessage("トグル"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("トーンスポット"),
    "tools": MessageLookupByLibrary.simpleMessage("ツール"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxyポート"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage("トラフィック使用量"),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage("管理者モードでのみ有効"),
    "turnOff": MessageLookupByLibrary.simpleMessage("オフ"),
    "turnOn": MessageLookupByLibrary.simpleMessage("オン"),
    "undo": MessageLookupByLibrary.simpleMessage("元に戻す"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("統一遅延"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "ハンドシェイクなどの余分な遅延を削除",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("不明"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage("不明なネットワークエラー"),
    "unnamed": MessageLookupByLibrary.simpleMessage("無題"),
    "update": MessageLookupByLibrary.simpleMessage("更新"),
    "upload": MessageLookupByLibrary.simpleMessage("アップロード"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("URL経由でプロファイルを取得"),
    "urlTip": m33,
    "useHosts": MessageLookupByLibrary.simpleMessage("ホストを使用"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("システムホストを使用"),
    "userAgent": MessageLookupByLibrary.simpleMessage("ユーザーエージェント"),
    "value": MessageLookupByLibrary.simpleMessage("値"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("ビブラント"),
    "view": MessageLookupByLibrary.simpleMessage("表示"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "VPN設定の変更が検出されました",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "VpnService経由で全システムトラフィックをルーティング",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage("変更はVPN再起動後に有効"),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage("WebDAV設定"),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("ホワイトリストモード"),
    "yearsAgo": m34,
    "zh_CN": MessageLookupByLibrary.simpleMessage("簡体字中国語"),
  };
}
