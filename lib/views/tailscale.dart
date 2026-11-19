import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/ui/icons/icons.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// One-shot package load for Tailscale-app detection on Android.
bool _tailscalePackagesRequested = false;

class TailscaleView extends ConsumerWidget {
  const TailscaleView({super.key});

  Future<void> _applyTailscaleConfig(WidgetRef ref) async {
    // Await apply so ping / status do not race the debounced profile merge.
    await ref.read(setupActionProvider.notifier).applyProfile(silence: true);
  }

  Future<void> _handleAddOrEdit(
    BuildContext context,
    WidgetRef ref, [
    TailscaleProxy? proxy,
  ]) async {
    final props = ref.read(tailscaleSettingProvider);
    final existingNames = props.proxies.map((item) => item.name).toList();
    final res = await dialogs.showCommonDialog<TailscaleProxy>(
      child: TailscaleNodeDialog(
        proxy: proxy,
        existingNames: existingNames,
        apiAccessToken: props.apiAccessToken,
        apiTags: props.apiTags,
      ),
    );
    if (res == null) {
      return;
    }
    ref
        .read(tailscaleSettingProvider.notifier)
        .addOrUpdate(res, previousName: proxy?.name);
    await _applyTailscaleConfig(ref);
  }

  Future<void> _handleDelete(
    BuildContext context,
    WidgetRef ref,
    TailscaleProxy proxy,
  ) async {
    final appLocalizations = context.appLocalizations;
    final res = await dialogs.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(
        text: appLocalizations.deleteTip(appLocalizations.tailscale),
      ),
    );
    if (res != true) {
      return;
    }
    ref.read(tailscaleSettingProvider.notifier).remove(proxy.name);
    await _applyTailscaleConfig(ref);
  }

  Future<void> _handleTest(
    BuildContext context,
    WidgetRef ref,
    TailscaleProxy proxy,
  ) async {
    final appLocalizations = context.appLocalizations;
    if (!ref.read(tailscaleSettingProvider).enable) {
      dialogs.showBanner(appLocalizations.tailscaleTestNeedEnable);
      return;
    }
    if (!ref.read(isStartProvider)) {
      dialogs.showBanner(appLocalizations.tailscaleTestNeedStart);
      return;
    }
    await _applyTailscaleConfig(ref);
    await ref
        .read(proxiesActionProvider.notifier)
        .proxyDelayTest(Proxy(name: proxy.name, type: tailscaleProxyType));
    if (!context.mounted) {
      return;
    }
    final delay = ref.read(delayProvider(proxyName: proxy.name));
    if (delay != null && delay > 0) {
      dialogs.showBanner(appLocalizations.tailscaleTestConfigOk);
      return;
    }
    if (delay != null && delay < 0) {
      dialogs.showBanner(appLocalizations.tailscaleTestConfigFailed);
    }
  }

  Future<void> _applyUsageMode(WidgetRef ref, TailscaleUsageMode mode) async {
    final settings = tailscaleUsageModeSettings(
      mode,
      isAndroid: system.isAndroid,
    );
    ref
        .read(vpnSettingProvider.notifier)
        .update((state) => state.copyWith(enable: settings.vpnEnable));
    ref
        .read(tailscaleSettingProvider.notifier)
        .setEnable(settings.tailscaleEnable);
    ref
        .read(tailscaleSettingProvider.notifier)
        .setBypassTraffic(settings.bypassTraffic);
    await _applyTailscaleConfig(ref);
  }

  Widget _buildUsageModePicker(
    BuildContext context,
    WidgetRef ref, {
    required TailscaleUsageMode selected,
    required bool tailscaleAppInstalled,
  }) {
    final appLocalizations = context.appLocalizations;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.tailscaleUsageTitle,
            style: AppTextStyle.subheadline.of(context, emphasized: true),
          ),
          const SizedBox(height: 4),
          Text(
            appLocalizations.tailscaleUsageDesc,
            style: AppTextStyle.footnote
                .of(context)
                .copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          generateSection(
            items: [
              for (final mode in TailscaleUsageMode.values)
                DecorationListItem(
                  isSelected: mode == selected,
                  leading: GlyphIcon(
                    mode == TailscaleUsageMode.embedded
                        ? AppGlyphs.vpn
                        : AppGlyphs.devices,
                  ),
                  title: Text(
                    mode == TailscaleUsageMode.embedded
                        ? appLocalizations.tailscaleUsageEmbeddedTitle
                        : appLocalizations.tailscaleUsageSystemTitle,
                  ),
                  subtitle: Text(
                    mode == TailscaleUsageMode.embedded
                        ? appLocalizations.tailscaleUsageEmbeddedBody
                        : system.isAndroid
                        ? appLocalizations.tailscaleUsageSystemBodyAndroid
                        : appLocalizations.tailscaleUsageSystemBodyDesktop,
                  ),
                  trailing: mode == selected
                      ? const SelectionBadge(size: 24)
                      : null,
                  onPressed: () async {
                    if (mode == selected) {
                      return;
                    }
                    await _applyUsageMode(ref, mode);
                    dialogs.showBanner(
                      mode == TailscaleUsageMode.embedded
                          ? appLocalizations.tailscaleUsageEmbeddedApplied
                          : appLocalizations.tailscaleUsageSystemApplied,
                    );
                  },
                ),
            ],
          ),
          if (system.isAndroid && tailscaleAppInstalled) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: context.colorScheme.tertiaryContainer.opacity38,
                shape: AppShape.md,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlyphIcon(
                    AppGlyphs.info,
                    size: 18,
                    color: context.colorScheme.tertiary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      selected == TailscaleUsageMode.embedded
                          ? appLocalizations.tailscaleAndroidConflictBuiltin
                          : appLocalizations.tailscaleAndroidConflictApp,
                      style: AppTextStyle.footnote
                          .of(context)
                          .copyWith(
                            color: context.colorScheme.onTertiaryContainer,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildApiTokenSection(
    BuildContext context,
    WidgetRef ref, {
    required TailscaleProps props,
  }) {
    final appLocalizations = context.appLocalizations;
    final hasToken = props.apiAccessToken.trim().isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.tailscaleApiTokenTitle,
            style: AppTextStyle.subheadline.of(context, emphasized: true),
          ),
          const SizedBox(height: 4),
          Text(
            appLocalizations.tailscaleApiTokenDesc,
            style: AppTextStyle.footnote
                .of(context)
                .copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          ListItem(
            leading: const GlyphIcon(AppGlyphs.key),
            title: Text(
              hasToken
                  ? appLocalizations.tailscaleApiTokenConfigured
                  : appLocalizations.tailscaleApiTokenAdd,
            ),
            subtitle: Text(
              hasToken
                  ? appLocalizations.tailscaleApiTokenConfiguredDesc
                  : appLocalizations.tailscaleApiTokenHint,
            ),
            trailing: const GlyphIcon(AppGlyphs.chevronForward),
            onTap: () => _handleEditApiToken(context, ref, props),
          ),
        ],
      ),
    );
  }

  Future<void> _handleEditApiToken(
    BuildContext context,
    WidgetRef ref,
    TailscaleProps props,
  ) async {
    final appLocalizations = context.appLocalizations;
    final tokenController = TextEditingController(text: props.apiAccessToken);
    final tagsController = TextEditingController(
      text: props.apiTags.join(', '),
    );
    final result = await dialogs
        .showCommonDialog<({String token, String tags})>(
          child: AlertDialog(
            title: appLocalizations.tailscaleApiTokenTitle,
            hasFields: true,
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(appLocalizations.cancel),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop((
                    token: tokenController.text.trim(),
                    tags: tagsController.text.trim(),
                  ));
                },
                child: Text(appLocalizations.confirm),
              ),
            ],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                TextFormField(
                  controller: tokenController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: appLocalizations.tailscaleApiTokenField,
                    helperText: appLocalizations.tailscaleApiTokenHint,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: tagsController,
                  decoration: InputDecoration(
                    hintText: appLocalizations.tailscaleApiTagsField,
                    helperText: appLocalizations.tailscaleApiTagsHint,
                  ),
                ),
              ],
            ),
          ),
        );
    tokenController.dispose();
    tagsController.dispose();
    if (result == null) {
      return;
    }
    final tags = result.tags
        .split(RegExp(r'[\s,]'))
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
    ref.read(tailscaleSettingProvider.notifier).setApiAccessToken(result.token);
    ref.read(tailscaleSettingProvider.notifier).setApiTags(tags);
  }

  Widget _buildGuideStep(BuildContext context, int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: AppTextStyle.caption1
                  .of(context, emphasized: true)
                  .copyWith(color: context.colorScheme.onPrimary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(text, style: AppTextStyle.callout.of(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuide(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final isAndroid = system.isAndroid;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: context.colorScheme.surfaceContainerHighest.opacity38,
          shape: AppShape.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GlyphIcon(
                  AppGlyphs.checkDouble,
                  size: 20,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  appLocalizations.tailscaleGuideTitle,
                  style: AppTextStyle.subheadline.of(context, emphasized: true),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (isAndroid) ...[
              _buildGuideStep(
                context,
                1,
                appLocalizations.tailscaleAndroidStep1,
              ),
              _buildGuideStep(
                context,
                2,
                appLocalizations.tailscaleAndroidStep2,
              ),
              _buildGuideStep(
                context,
                3,
                appLocalizations.tailscaleAndroidStep3,
              ),
              _buildGuideStep(
                context,
                4,
                appLocalizations.tailscaleAndroidStep4,
              ),
            ] else ...[
              _buildGuideStep(
                context,
                1,
                appLocalizations.tailscaleDesktopStep1,
              ),
              _buildGuideStep(
                context,
                2,
                appLocalizations.tailscaleDesktopStep2,
              ),
              _buildGuideStep(
                context,
                3,
                appLocalizations.tailscaleDesktopStep3,
              ),
              _buildGuideStep(
                context,
                4,
                appLocalizations.tailscaleDesktopStep4,
              ),
            ],
            const SizedBox(height: 4),
            Text(
              appLocalizations.tailscaleTestTip,
              style: AppTextStyle.footnote
                  .of(context)
                  .copyWith(color: context.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner(
    BuildContext context,
    WidgetRef ref, {
    required bool enable,
    required int nodeCount,
    required int routeCount,
  }) {
    final appLocalizations = context.appLocalizations;
    final isStart = ref.watch(isStartProvider);
    final String message;
    final Color? color;
    final Glyph icon;
    if (!enable) {
      message = appLocalizations.tailscaleStatusDisabled;
      color = context.colorScheme.onSurfaceVariant;
      icon = AppGlyphs.block;
    } else if (nodeCount == 0) {
      message = appLocalizations.tailscaleStatusNoNodes;
      color = context.colorScheme.tertiary;
      icon = AppGlyphs.info;
    } else if (routeCount == 0) {
      message = appLocalizations.tailscaleStatusNeedRoutes;
      color = context.colorScheme.tertiary;
      icon = AppGlyphs.split;
    } else if (!isStart) {
      message = appLocalizations.tailscaleStatusNeedStart;
      color = context.colorScheme.tertiary;
      icon = AppGlyphs.bolt;
    } else {
      message = appLocalizations.tailscaleStatusReady(nodeCount);
      color = context.colorScheme.primary;
      icon = AppGlyphs.checkCircle;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          GlyphIcon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: AppTextStyle.footnote.of(context).copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNodeDelay(BuildContext context, WidgetRef ref, String name) {
    final appLocalizations = context.appLocalizations;
    final delay = ref.watch(delayProvider(proxyName: name));
    if (delay == null) {
      return Text(
        appLocalizations.tailscaleNotTested,
        style: AppTextStyle.caption1
            .of(context)
            .copyWith(color: context.colorScheme.onSurfaceVariant),
      );
    }
    if (delay == 0) {
      return ActivityIndicator(size: 14, color: context.colorScheme.primary);
    }
    return Text(
      delay > 0 ? '$delay ms' : appLocalizations.timeout,
      style: AppTextStyle.caption1
          .of(context, emphasized: true)
          .copyWith(color: context.colorScheme.delayColor(delay)),
    );
  }

  String _buildSubtitle(BuildContext context, TailscaleProxy proxy) {
    final appLocalizations = context.appLocalizations;
    final parts = <String>[];
    if (proxy.routes.isNotEmpty) {
      parts.add(appLocalizations.tailscaleRoutesCount(proxy.routes.length));
    } else {
      parts.add(appLocalizations.tailscaleNoRoutes);
    }
    if (proxy.exitNode.trim().isNotEmpty) {
      parts.add('${appLocalizations.tailscaleExitNode}: ${proxy.exitNode}');
    }
    return parts.join(' · ');
  }

  Widget _buildNodeTile(
    BuildContext context,
    WidgetRef ref, {
    required TailscaleProxy proxy,
  }) {
    final appLocalizations = context.appLocalizations;
    return ContextMenuRegion(
      menuItems: [
        PopupMenuItem(
          glyph: AppGlyphs.speed,
          label: appLocalizations.tailscaleTestNode,
          onPressed: () {
            unawaited(_handleTest(context, ref, proxy));
          },
        ),
        PopupMenuItem(
          danger: true,
          glyph: AppGlyphs.delete,
          label: appLocalizations.delete,
          onPressed: () {
            unawaited(_handleDelete(context, ref, proxy));
          },
        ),
      ],
      child: ListItem(
        leading: const GlyphIcon(AppGlyphs.devices),
        title: Text(proxy.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          _buildSubtitle(context, proxy),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: _buildNodeDelay(context, ref, proxy.name),
        onTap: () {
          unawaited(_handleAddOrEdit(context, ref, proxy));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = context.appLocalizations;
    final props = ref.watch(tailscaleSettingProvider);
    final enable = props.enable;
    final proxies = props.proxies;
    final routeCount = proxies.fold<int>(
      0,
      (sum, proxy) => sum + proxy.routes.length,
    );
    final vpnEnable = ref.watch(
      vpnSettingProvider.select((state) => state.enable),
    );
    final usageMode = resolveTailscaleUsageMode(
      isAndroid: system.isAndroid,
      vpnEnable: vpnEnable,
      tailscaleEnable: enable,
      bypassTraffic: props.bypassTraffic,
    );
    final packages = ref.watch(packagesProvider);
    final tailscaleAppInstalled = packagesIncludeTailscaleApp(packages);
    if (system.isAndroid && packages.isEmpty && !_tailscalePackagesRequested) {
      _tailscalePackagesRequested = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(ref.read(systemActionProvider.notifier).getPackages());
      });
    }
    return Scaffold(
      title: appLocalizations.tailscale,
      iconActions: [
        IconButtonData(
          glyph: AppGlyphs.add,
          tooltip: appLocalizations.addTailscaleNode,
          onPressed: () {
            unawaited(_handleAddOrEdit(context, ref));
          },
        ),
      ],
      body: ListView(
        padding: EdgeInsets.only(
          top: context.sectionsTopPadding,
          bottom: 20 + context.bottomInset,
        ),
        children: [
          _buildUsageModePicker(
            context,
            ref,
            selected: usageMode,
            tailscaleAppInstalled: tailscaleAppInstalled,
          ),
          _buildApiTokenSection(context, ref, props: props),
          if (usageMode == TailscaleUsageMode.embedded || !system.isAndroid)
            ListItem.toggle(
              leading: const GlyphIcon(AppGlyphs.toggleOn),
              title: Text(appLocalizations.tailscaleEnable),
              subtitle: Text(appLocalizations.tailscaleEnableDescShort),
              value: enable,
              onChanged: (value) async {
                ref.read(tailscaleSettingProvider.notifier).setEnable(value);
                await _applyTailscaleConfig(ref);
              },
            ),
          _ExpandableGuide(
            title: appLocalizations.tailscaleAdvancedTitle,
            child: Column(
              children: [
                ListItem.toggle(
                  leading: const GlyphIcon(AppGlyphs.split),
                  title: Text(appLocalizations.tailscaleBypass),
                  subtitle: Text(
                    system.isDesktop
                        ? appLocalizations.tailscaleBypassRecommended
                        : appLocalizations.tailscaleBypassAndroidHint,
                  ),
                  value: props.bypassTraffic,
                  onChanged: (value) async {
                    ref
                        .read(tailscaleSettingProvider.notifier)
                        .setBypassTraffic(value);
                    await _applyTailscaleConfig(ref);
                  },
                ),
                _buildGuide(context),
              ],
            ),
          ),
          _buildStatusBanner(
            context,
            ref,
            enable: enable,
            nodeCount: proxies.length,
            routeCount: routeCount,
          ),
          const Divider(height: 16),
          if (proxies.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                children: [
                  NullStatus(
                    label: appLocalizations.tailscaleEmptyTip,
                    illustration: NullStatusIllustration.tun,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {
                      unawaited(_handleAddOrEdit(context, ref));
                    },
                    icon: const GlyphIcon(AppGlyphs.add, fill: 1),
                    label: Text(appLocalizations.addTailscaleNode),
                  ),
                ],
              ),
            )
          else ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                appLocalizations.tailscaleNodesTitle,
                style: AppTextStyle.subheadline.of(context, emphasized: true),
              ),
            ),
            for (final proxy in proxies)
              _buildNodeTile(context, ref, proxy: proxy),
          ],
        ],
      ),
    );
  }
}

class TailscaleNodeDialog extends StatefulWidget {
  final TailscaleProxy? proxy;
  final List<String> existingNames;
  final String apiAccessToken;
  final List<String> apiTags;

  const TailscaleNodeDialog({
    super.key,
    this.proxy,
    this.existingNames = const [],
    this.apiAccessToken = '',
    this.apiTags = const [],
  });

  @override
  State<TailscaleNodeDialog> createState() => _TailscaleNodeDialogState();
}

class _TailscaleNodeDialogState extends State<TailscaleNodeDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _authKeyController;
  late final TextEditingController _hostnameController;
  late final TextEditingController _controlUrlController;
  late final TextEditingController _stateDirController;
  late final TextEditingController _exitNodeController;
  late final TextEditingController _routesController;
  late bool _ephemeral;
  late bool _udp;
  late bool _acceptRoutes;
  late bool _exitNodeAllowLanAccess;
  late bool _showAdvanced;
  late bool _obscureAuthKey;
  var _generatingAuthKey = false;

  @override
  void initState() {
    super.initState();
    final proxy = widget.proxy ?? const TailscaleProxy(name: '');
    final isNew = widget.proxy == null;
    _nameController = TextEditingController(text: proxy.name);
    _authKeyController = TextEditingController(text: proxy.authKey);
    _hostnameController = TextEditingController(text: proxy.hostname);
    _controlUrlController = TextEditingController(text: proxy.controlUrl);
    _stateDirController = TextEditingController(text: proxy.stateDir);
    _exitNodeController = TextEditingController(text: proxy.exitNode);
    _routesController = TextEditingController(
      text: proxy.routes.isNotEmpty
          ? proxy.routes.join('\n')
          : (isNew ? defaultTailscaleRouteSuggestions.join('\n') : ''),
    );
    _ephemeral = proxy.ephemeral;
    _udp = proxy.udp;
    _acceptRoutes = proxy.acceptRoutes;
    _exitNodeAllowLanAccess = proxy.exitNodeAllowLanAccess;
    _obscureAuthKey = true;
    // Default udp is false; do not treat that alone as “advanced customized”,
    // or every new-node dialog opens fully expanded and clips on short screens.
    _showAdvanced =
        proxy.hostname.isNotEmpty ||
        proxy.controlUrl.isNotEmpty ||
        proxy.stateDir.isNotEmpty ||
        proxy.exitNode.isNotEmpty ||
        proxy.ephemeral ||
        proxy.acceptRoutes ||
        proxy.exitNodeAllowLanAccess ||
        (widget.proxy != null && !proxy.udp);
  }

  Future<void> _generateAuthKey() async {
    final appLocalizations = context.appLocalizations;
    final token = widget.apiAccessToken.trim();
    if (token.isEmpty) {
      dialogs.showBanner(appLocalizations.tailscaleApiTokenMissing);
      return;
    }
    setState(() => _generatingAuthKey = true);
    try {
      final created = await createTailscaleAuthKey(
        accessToken: token,
        dio: request.dio,
        tags: widget.apiTags,
        ephemeral: _ephemeral,
        description: _nameController.text.trim().isEmpty
            ? 'FlClash'
            : _nameController.text.trim(),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _authKeyController.text = created.key;
        _obscureAuthKey = false;
      });
      dialogs.showBanner(appLocalizations.tailscaleAuthKeyGenerated);
    } on TailscaleApiException catch (error) {
      dialogs.showBanner(error.message);
    } catch (error) {
      dialogs.showBanner(error.toString());
    } finally {
      if (mounted) {
        setState(() => _generatingAuthKey = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _authKeyController.dispose();
    _hostnameController.dispose();
    _controlUrlController.dispose();
    _stateDirController.dispose();
    _exitNodeController.dispose();
    _routesController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    final routes = _routesController.text
        .split(RegExp(r'[\n,]'))
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
    final proxy = TailscaleProxy(
      name: _nameController.text.trim(),
      authKey: _authKeyController.text.trim(),
      hostname: _hostnameController.text.trim(),
      controlUrl: _controlUrlController.text.trim(),
      stateDir: _stateDirController.text.trim(),
      exitNode: _exitNodeController.text.trim(),
      ephemeral: _ephemeral,
      udp: _udp,
      acceptRoutes: _acceptRoutes,
      exitNodeAllowLanAccess: _exitNodeAllowLanAccess,
      routes: routes,
    );
    Navigator.of(context).pop(proxy);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? helperText,
    int maxLines = 1,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: obscureText ? 1 : maxLines,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: label,
          helperText: helperText,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _buildSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListItem.toggle(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return AlertDialog(
      title: widget.proxy != null
          ? appLocalizations.editTailscaleNode
          : appLocalizations.addTailscaleNode,
      hasFields: true,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(appLocalizations.cancel),
        ),
        TextButton(
          onPressed: _handleSubmit,
          child: Text(appLocalizations.confirm),
        ),
      ],
      // AlertDialog already scrolls its body; a nested scroll view blocks
      // focus-driven scrolling when the keyboard is up.
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildTextField(
              controller: _nameController,
              label: appLocalizations.name,
              helperText: appLocalizations.tailscaleNameHelper,
              validator: (value) {
                final name = value?.trim() ?? '';
                if (name.isEmpty) {
                  return appLocalizations.emptyTip(appLocalizations.name);
                }
                final isEditingSame = widget.proxy?.name == name;
                if (!isEditingSame && widget.existingNames.contains(name)) {
                  return appLocalizations.tailscaleNameExistsTip;
                }
                return null;
              },
            ),
            _buildTextField(
              controller: _authKeyController,
              label: appLocalizations.tailscaleAuthKey,
              helperText: widget.apiAccessToken.trim().isEmpty
                  ? appLocalizations.tailscaleAuthKeyHint
                  : appLocalizations.tailscaleAuthKeyOverrideHint,
              obscureText: _obscureAuthKey,
              suffixIcon: IconButton(
                tooltip: _obscureAuthKey
                    ? appLocalizations.showPassword
                    : appLocalizations.hidePassword,
                onPressed: () {
                  setState(() => _obscureAuthKey = !_obscureAuthKey);
                },
                icon: GlyphIcon(
                  _obscureAuthKey ? AppGlyphs.eye : AppGlyphs.eyeOff,
                ),
              ),
              validator: (value) {
                final key = value?.trim() ?? '';
                if (key.isEmpty) {
                  return appLocalizations.emptyTip(
                    appLocalizations.tailscaleAuthKey,
                  );
                }
                return null;
              },
            ),
            if (widget.apiAccessToken.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: _generatingAuthKey ? null : _generateAuthKey,
                    icon: _generatingAuthKey
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: ActivityIndicator(size: 16),
                          )
                        : const GlyphIcon(AppGlyphs.key),
                    label: Text(
                      _generatingAuthKey
                          ? appLocalizations.tailscaleAuthKeyGenerating
                          : appLocalizations.tailscaleAuthKeyGenerate,
                    ),
                  ),
                ),
              ),
            _buildTextField(
              controller: _routesController,
              label: appLocalizations.tailscaleRoutes,
              helperText: appLocalizations.tailscaleRoutesHintCidr,
              maxLines: 3,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  setState(() => _showAdvanced = !_showAdvanced);
                },
                icon: GlyphIcon(
                  _showAdvanced ? AppGlyphs.chevronUp : AppGlyphs.chevronDown,
                ),
                label: Text(
                  _showAdvanced
                      ? appLocalizations.hideAdvanced
                      : appLocalizations.showAdvanced,
                ),
              ),
            ),
            if (_showAdvanced) ...[
              _buildTextField(
                controller: _hostnameController,
                label: appLocalizations.tailscaleHostname,
                helperText: appLocalizations.tailscaleHostnameHint,
              ),
              _buildTextField(
                controller: _controlUrlController,
                label: appLocalizations.tailscaleControlUrl,
                helperText: appLocalizations.tailscaleControlUrlHint,
                validator: (value) {
                  final url = value?.trim() ?? '';
                  if (url.isEmpty || isSafeTailscaleControlUrl(url)) {
                    return null;
                  }
                  return appLocalizations.invalidLinkTip;
                },
              ),
              _buildTextField(
                controller: _stateDirController,
                label: appLocalizations.tailscaleStateDir,
                helperText: appLocalizations.tailscaleStateDirHint,
                validator: (value) {
                  final dir = value?.trim() ?? '';
                  if (dir.isEmpty || isSafeTailscaleStateDir(dir)) {
                    return null;
                  }
                  return appLocalizations.emptyTip(
                    appLocalizations.tailscaleStateDir,
                  );
                },
              ),
              _buildTextField(
                controller: _exitNodeController,
                label: appLocalizations.tailscaleExitNode,
                helperText: appLocalizations.tailscaleExitNodeHint,
              ),
              _buildSwitch(
                label: appLocalizations.tailscaleEphemeral,
                value: _ephemeral,
                onChanged: (value) {
                  setState(() {
                    _ephemeral = value;
                  });
                },
              ),
              _buildSwitch(
                label: appLocalizations.tailscaleUdp,
                value: _udp,
                onChanged: (value) {
                  setState(() {
                    _udp = value;
                  });
                },
              ),
              _buildSwitch(
                label: appLocalizations.tailscaleAcceptRoutes,
                value: _acceptRoutes,
                onChanged: (value) {
                  setState(() {
                    _acceptRoutes = value;
                  });
                },
              ),
              _buildSwitch(
                label: appLocalizations.tailscaleExitNodeAllowLanAccess,
                value: _exitNodeAllowLanAccess,
                onChanged: (value) {
                  setState(() {
                    _exitNodeAllowLanAccess = value;
                  });
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ExpandableGuide extends StatefulWidget {
  const _ExpandableGuide({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  State<_ExpandableGuide> createState() => _ExpandableGuideState();
}

class _ExpandableGuideState extends State<_ExpandableGuide> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListItem(
          title: Text(widget.title),
          trailing: GlyphIcon(
            _expanded ? AppGlyphs.chevronUp : AppGlyphs.chevronDown,
          ),
          onTap: () => setState(() => _expanded = !_expanded),
        ),
        if (_expanded) widget.child,
      ],
    );
  }
}
