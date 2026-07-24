import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TailscaleView extends ConsumerWidget {
  const TailscaleView({super.key});

  String _buildSubtitle(BuildContext context, TailscaleProxy proxy) {
    final appLocalizations = context.appLocalizations;
    final parts = <String>[tailscaleProxyType];
    if (proxy.exitNode.trim().isNotEmpty) {
      parts.add('${appLocalizations.tailscaleExitNode}: ${proxy.exitNode}');
    }
    if (proxy.ephemeral) {
      parts.add(appLocalizations.tailscaleEphemeral);
    }
    return parts.join(' · ');
  }

  Future<void> _handleAddOrEdit(
    BuildContext context,
    WidgetRef ref, [
    TailscaleProxy? proxy,
  ]) async {
    final existingNames = ref
        .read(tailscaleSettingProvider)
        .map((item) => item.name)
        .toList();
    final res = await globalState.showCommonDialog<TailscaleProxy>(
      child: TailscaleNodeDialog(proxy: proxy, existingNames: existingNames),
    );
    if (res == null) {
      return;
    }
    ref.read(tailscaleSettingProvider.notifier).addOrUpdate(res);
  }

  Future<void> _handleDelete(
    BuildContext context,
    WidgetRef ref,
    TailscaleProxy proxy,
  ) async {
    final appLocalizations = context.appLocalizations;
    final res = await globalState.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(
        text: appLocalizations.deleteTip(appLocalizations.tailscale),
      ),
    );
    if (res != true) {
      return;
    }
    ref.read(tailscaleSettingProvider.notifier).remove(proxy.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = context.appLocalizations;
    final proxies = ref.watch(tailscaleSettingProvider);
    return CommonScaffold(
      title: appLocalizations.tailscale,
      actions: [
        IconButton(
          onPressed: () {
            _handleAddOrEdit(context, ref);
          },
          icon: const Icon(Icons.add),
        ),
        const SizedBox(width: 8),
      ],
      body: proxies.isEmpty
          ? NullStatus(label: appLocalizations.tailscaleEmptyTip)
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: proxies.length + 1,
              itemBuilder: (_, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      appLocalizations.tailscaleTip,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                final proxy = proxies[index - 1];
                return ListItem(
                  leading: const Icon(Icons.device_hub),
                  title: Text(
                    proxy.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    _buildSubtitle(context, proxy),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _handleDelete(context, ref, proxy);
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                  onTap: () {
                    _handleAddOrEdit(context, ref, proxy);
                  },
                );
              },
            ),
    );
  }
}

class TailscaleNodeDialog extends StatefulWidget {
  final TailscaleProxy? proxy;
  final List<String> existingNames;

  const TailscaleNodeDialog({
    super.key,
    this.proxy,
    this.existingNames = const [],
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
  late bool _ephemeral;
  late bool _udp;
  late bool _acceptRoutes;
  late bool _exitNodeAllowLanAccess;

  @override
  void initState() {
    super.initState();
    final proxy = widget.proxy ?? const TailscaleProxy(name: '');
    _nameController = TextEditingController(text: proxy.name);
    _authKeyController = TextEditingController(text: proxy.authKey);
    _hostnameController = TextEditingController(text: proxy.hostname);
    _controlUrlController = TextEditingController(text: proxy.controlUrl);
    _stateDirController = TextEditingController(text: proxy.stateDir);
    _exitNodeController = TextEditingController(text: proxy.exitNode);
    _ephemeral = proxy.ephemeral;
    _udp = proxy.udp;
    _acceptRoutes = proxy.acceptRoutes;
    _exitNodeAllowLanAccess = proxy.exitNodeAllowLanAccess;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _authKeyController.dispose();
    _hostnameController.dispose();
    _controlUrlController.dispose();
    _stateDirController.dispose();
    _exitNodeController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
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
    );
    Navigator.of(context).pop(proxy);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  Widget _buildSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: context.textTheme.bodyLarge),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return CommonDialog(
      title: widget.proxy != null
          ? appLocalizations.editTailscaleNode
          : appLocalizations.addTailscaleNode,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(appLocalizations.cancel),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: _handleSubmit,
          child: Text(appLocalizations.confirm),
        ),
      ],
      child: SizedBox(
        width: 360,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _nameController,
                  label: appLocalizations.name,
                  validator: (value) {
                    final name = value?.trim() ?? '';
                    if (name.isEmpty) {
                      return appLocalizations.emptyTip(appLocalizations.name);
                    }
                    final isEditingSame = widget.proxy?.name == name;
                    if (!isEditingSame &&
                        widget.existingNames.contains(name)) {
                      return appLocalizations.tailscaleNameExistsTip;
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _authKeyController,
                  label: appLocalizations.tailscaleAuthKey,
                ),
                _buildTextField(
                  controller: _hostnameController,
                  label: appLocalizations.tailscaleHostname,
                ),
                _buildTextField(
                  controller: _controlUrlController,
                  label: appLocalizations.tailscaleControlUrl,
                ),
                _buildTextField(
                  controller: _stateDirController,
                  label: appLocalizations.tailscaleStateDir,
                ),
                _buildTextField(
                  controller: _exitNodeController,
                  label: appLocalizations.tailscaleExitNode,
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
            ),
          ),
        ),
      ),
    );
  }
}
