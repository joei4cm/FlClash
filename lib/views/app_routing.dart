import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/features/features.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/ui/icons/icons.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Route local apps / processes to DIRECT, REJECT, a group, or a node via
/// PROCESS-NAME rules in the global rule list.
class AppRoutingView extends ConsumerWidget {
  const AppRoutingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.appLocalizations;
    final rulesAsync = ref.watch(globalRulesProvider);
    final findProcess = ref.watch(
      patchClashConfigProvider.select(
        (state) => state.findProcessMode == FindProcessMode.always,
      ),
    );
    final groups = ref.watch(groupsProvider);
    final targets = _routingTargets(groups);
    final processRules = processRoutingRules(rulesAsync.value ?? const []);

    return Scaffold(
      title: l10n.appRouting,
      actions: [
        IconButton(
          tooltip: l10n.appRoutingAdd,
          onPressed: () => _editRule(context, ref, targets: targets),
          icon: const GlyphIcon(AppGlyphs.addCircle),
        ),
      ],
      body: rulesAsync.when(
        loading: () => const Center(child: ActivityIndicator.page()),
        error: (error, _) => ListView(
          children: [
            ListItem(
              leading: const GlyphIcon(AppGlyphs.error),
              title: Text(error.toString()),
            ),
          ],
        ),
        data: (_) {
          return ListView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: context.sectionsTopPadding,
              bottom: 20 + context.bottomInset,
            ),
            children: [
              generateSection(
                title: l10n.settings,
                items: [
                  ListItem.toggle(
                    title: Text(l10n.findProcessMode),
                    subtitle: Text(l10n.appRoutingFindProcessTip),
                    value: findProcess,
                    onChanged: (value) {
                      ref
                          .read(patchClashConfigProvider.notifier)
                          .update(
                            (state) => state.copyWith(
                              findProcessMode: value
                                  ? FindProcessMode.always
                                  : FindProcessMode.strict,
                            ),
                          );
                    },
                  ),
                ],
                footer: l10n.appRoutingTip,
              ),
              if (processRules.isEmpty)
                ListItem(
                  leading: const GlyphIcon(AppGlyphs.info),
                  title: Text(l10n.appRoutingEmpty),
                  subtitle: Text(l10n.appRoutingEmptyDesc),
                )
              else
                generateSection(
                  title: l10n.appRoutingRules,
                  items: [
                    for (final rule in processRules)
                      ListItem(
                        leading: const GlyphIcon(AppGlyphs.appsList),
                        title: Text(rule.content ?? ''),
                        subtitle: Text(
                          '${rule.ruleAction.value} → ${rule.ruleTarget ?? ''}',
                        ),
                        trailing: IconButton(
                          tooltip: l10n.delete,
                          onPressed: () => ref
                              .read(globalRulesProvider.notifier)
                              .delAll([rule.id]),
                          icon: const GlyphIcon(AppGlyphs.delete),
                        ),
                        onTap: () => _editRule(
                          context,
                          ref,
                          rule: rule,
                          targets: targets,
                        ),
                      ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  List<String> _routingTargets(List<Group> groups) {
    final names = <String>{
      ...RuleTarget.ruleTargetNames,
      for (final group in groups) group.name,
      for (final group in groups)
        for (final proxy in group.all) proxy.name,
    };
    final sorted = names.toList()..sort();
    return sorted;
  }

  Future<void> _editRule(
    BuildContext context,
    WidgetRef ref, {
    Rule? rule,
    required List<String> targets,
  }) async {
    final result = await showFormSheet<Rule>(
      context: context,
      builder: (_) => _AppRoutingForm(rule: rule, targets: targets),
    );
    if (result == null || !context.mounted) {
      return;
    }
    ref.read(globalRulesProvider.notifier).put(result);
  }
}

class _AppRoutingForm extends StatefulWidget {
  const _AppRoutingForm({this.rule, required this.targets});

  final Rule? rule;
  final List<String> targets;

  @override
  State<_AppRoutingForm> createState() => _AppRoutingFormState();
}

class _AppRoutingFormState extends State<_AppRoutingForm> {
  late final TextEditingController _processController;
  late String _target;
  late RuleAction _action;
  var _attempted = false;

  @override
  void initState() {
    super.initState();
    final rule = widget.rule;
    _processController = TextEditingController(text: rule?.content ?? '');
    _target = rule?.ruleTarget ?? RuleTarget.DIRECT.value;
    _action = rule?.ruleAction ?? RuleAction.PROCESS_NAME;
    if (_action != RuleAction.PROCESS_NAME &&
        _action != RuleAction.PROCESS_NAME_REGEX &&
        _action != RuleAction.PROCESS_NAME_WILDCARD) {
      _action = RuleAction.PROCESS_NAME;
    }
  }

  @override
  void dispose() {
    _processController.dispose();
    super.dispose();
  }

  String? _error(AppLocalizations l10n) {
    if (_processController.text.trim().isEmpty) {
      return l10n.emptyTip(l10n.appRoutingProcessName);
    }
    if (_target.trim().isEmpty) {
      return l10n.splitStrategyNotEmpty;
    }
    return null;
  }

  void _submit() {
    final l10n = context.appLocalizations;
    final error = _error(l10n);
    if (error != null) {
      setState(() => _attempted = true);
      return;
    }
    Navigator.of(context).pop(
      buildProcessRoutingRule(
        id: widget.rule?.id,
        processName: _processController.text,
        target: _target,
        action: _action,
      ),
    );
  }

  Future<void> _pickProcess() async {
    final selected = await showSheet<String>(
      context: context,
      builder: (_) => const _ProcessPickerSheet(),
    );
    if (selected == null || !mounted) {
      return;
    }
    setState(() {
      _processController.text = selected;
      _attempted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    final targets = {
      if (!widget.targets.contains(_target)) _target,
      ...widget.targets,
    }.toList();
    return FormPage(
      title: widget.rule == null ? l10n.appRoutingAdd : l10n.appRoutingEdit,
      onSave: _submit,
      error: _attempted ? _error(l10n) : null,
      children: [
        generateSection(
          title: l10n.basicInfo,
          items: [
            FormRow(
              title: l10n.appRoutingProcessName,
              invalid: _attempted && _processController.text.trim().isEmpty,
              trailing: FormRowTextField(
                controller: _processController,
                hintText: l10n.appRoutingProcessHint,
                autocorrect: false,
                onChanged: (_) {
                  if (_attempted) {
                    setState(() {});
                  }
                },
                onFieldSubmitted: (_) => _submit(),
              ),
            ),
            ListItem(
              leading: const GlyphIcon(AppGlyphs.appsList),
              title: Text(l10n.appRoutingPickProcess),
              subtitle: Text(l10n.appRoutingPickProcessDesc),
              trailing: const GlyphIcon(AppGlyphs.chevronForward),
              onTap: _pickProcess,
            ),
            ListItem<RuleAction>.options(
              title: Text(l10n.proxyType),
              options: const [
                RuleAction.PROCESS_NAME,
                RuleAction.PROCESS_NAME_WILDCARD,
                RuleAction.PROCESS_NAME_REGEX,
              ],
              value: _action,
              textBuilder: (action) => action.value,
              onChanged: (action) {
                setState(() => _action = action);
              },
            ),
            ListItem<String>.options(
              title: Text(l10n.splitStrategy),
              options: targets,
              value: _target,
              textBuilder: (value) => value,
              onChanged: (value) {
                setState(() => _target = value);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _ProcessPickerSheet extends StatefulWidget {
  const _ProcessPickerSheet();

  @override
  State<_ProcessPickerSheet> createState() => _ProcessPickerSheetState();
}

class _ProcessPickerSheetState extends State<_ProcessPickerSheet> {
  var _query = '';
  var _loading = true;
  Object? _error;
  List<String> _names = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final names = await desktopProcesses.listNames();
      if (!mounted) {
        return;
      }
      setState(() {
        _names = names;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = error;
        _loading = false;
      });
    }
  }

  List<String> get _visible {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) {
      return _names;
    }
    return [
      for (final name in _names)
        if (name.toLowerCase().contains(query)) name,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    final visible = _visible;
    return Scaffold(
      title: l10n.appRoutingPickProcessTitle,
      searchState: AppBarSearchState(
        onSearch: (query) => setState(() => _query = query),
      ),
      searchInBar: true,
      iconActions: [
        IconButtonData(
          glyph: AppGlyphs.refresh,
          tooltip: l10n.sync,
          onPressed: _loading ? null : _load,
        ),
      ],
      body: Builder(
        builder: (context) {
          if (_loading) {
            return const Center(child: ActivityIndicator.page());
          }
          if (_error != null) {
            return ListView(
              children: [
                ListItem(
                  leading: const GlyphIcon(AppGlyphs.error),
                  title: Text(l10n.appRoutingProcessLoadFailed),
                  subtitle: Text(_error.toString()),
                  onTap: _load,
                ),
              ],
            );
          }
          if (visible.isEmpty) {
            return ListView(
              children: [
                ListItem(
                  leading: const GlyphIcon(AppGlyphs.info),
                  title: Text(
                    _query.trim().isEmpty
                        ? l10n.appRoutingNoProcesses
                        : l10n.nullTip(l10n.appRoutingProcessName),
                  ),
                ),
              ],
            );
          }
          return PrismListView(
            itemCount: visible.length,
            itemBuilder: (context, index) {
              final name = visible[index];
              return ListItem(
                leading: const GlyphIcon(AppGlyphs.appsList),
                title: Text(name),
                onTap: () => Navigator.of(context).pop(name),
              );
            },
            padding: EdgeInsets.only(bottom: 20 + context.bottomInset),
          );
        },
      ),
    );
  }
}
