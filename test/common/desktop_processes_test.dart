import 'dart:io';

import 'package:fl_clash/common/desktop_processes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parseWindowsTasklistCsv reads image names', () {
    const stdout = '''
"chrome.exe","1234","Console","1","12,345 K"
"Cursor.exe","99","Console","1","1,000 K"
''';
    expect(DesktopProcesses.parseWindowsTasklistCsv(stdout), [
      'chrome.exe',
      'Cursor.exe',
    ]);
  });

  test('parseUnixCommList trims lines', () {
    const stdout = '''
Chrome
  Cursor
firefox

''';
    expect(DesktopProcesses.parseUnixCommList(stdout), [
      'Chrome',
      'Cursor',
      'firefox',
    ]);
  });

  test('normalizeNames dedupes, drops kernel threads, keeps basename', () {
    final names = DesktopProcesses.normalizeNames([
      'Chrome',
      'chrome',
      '[kthreadd]',
      '/Applications/Cursor.app/Contents/MacOS/Cursor',
      '-',
      '',
    ], keepExe: false);
    expect(names, ['Chrome', 'Cursor']);
  });

  test('normalizeNames keeps .exe on Windows', () {
    final names = DesktopProcesses.normalizeNames([
      'chrome.exe',
      r'C:\Program Files\Cursor\Cursor.exe',
    ], keepExe: true);
    expect(names, ['chrome.exe', 'Cursor.exe']);
  });

  test('listNames uses injected runner on Linux', () async {
    final calls = <(String, List<String>)>[];
    final processes = DesktopProcesses(
      runProcess: (executable, arguments) async {
        calls.add((executable, arguments));
        return ProcessResult(0, 0, 'bash\nchrome\nbash\n', '');
      },
    );
    final names = await processes.listNames(
      windows: false,
      macOS: false,
      linux: true,
    );
    expect(calls.single.$1, 'ps');
    expect(calls.single.$2, ['-eo', 'comm=']);
    expect(names, ['bash', 'chrome']);
  });

  test('listNames uses tasklist on Windows', () async {
    final processes = DesktopProcesses(
      runProcess: (executable, arguments) async {
        expect(executable, 'tasklist');
        return ProcessResult(
          0,
          0,
          '"notepad.exe","1","Console","1","1 K"\n',
          '',
        );
      },
    );
    final names = await processes.listNames(
      windows: true,
      macOS: false,
      linux: false,
    );
    expect(names, ['notepad.exe']);
  });
}
