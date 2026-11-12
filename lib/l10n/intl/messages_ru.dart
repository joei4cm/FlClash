// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(count) => "Выбрано: ${count}";

  static String m1(name) => "«${name}» добавлен в локальные прокси";

  static String m2(name) => "«${name}» уже есть в локальных прокси";

  static String m3(node) => "Текущий узел: ${node}";

  static String m4(node) => "Ручной выбор: ${node}";

  static String m5(region) => "Закреплённый регион: ${region}";

  static String m6(type) => "Авто · ${type}";

  static String m7(count, skipped) =>
      "Будет добавлено: ${count}, пропущено (уже есть): ${skipped}";

  static String m8(detail) => "Не удалось очистить данные: ${detail}";

  static String m9(code) =>
      "Windows отказалась запускать FlClashCore.exe (ошибка ${code}). Политики контроля приложений, такие как Smart App Control или AppLocker, блокируют неподписанные программы; разрешите FlClash в этой политике или отключите её и повторите попытку.";

  static String m10(name) =>
      "Приложение два раза подряд не смогло завершить запуск. Чтобы разорвать цикл, профиль ${name} снят с выбора, а автоматическая настройка пропущена. Вы можете выбрать его снова в любой момент.";

  static String m11(url) => "Создать профиль по ссылке ${url}?";

  static String m12(count, label) =>
      "${Intl.plural(count, one: 'Пользовательские профили не поддерживают подправила, поэтому отброшено ${label} правило SUB-RULE', few: 'Пользовательские профили не поддерживают подправила, поэтому отброшено ${label} правила SUB-RULE', many: 'Пользовательские профили не поддерживают подправила, поэтому отброшено ${label} правил SUB-RULE', other: 'Пользовательские профили не поддерживают подправила, поэтому отброшено ${label} правила SUB-RULE')}";

  static String m13(message) =>
      "Ядро не может разобрать этот прокси: ${message}";

  static String m14(proxy, target) =>
      "${proxy} подключается через ${target}, а ${target} снова ведёт к ${proxy}, поэтому подключение зацикливается";

  static String m15(name) =>
      "Имя ${name} уже занято другим прокси или группой прокси";

  static String m16(path) =>
      "Группы прокси ссылаются друг на друга по кругу: ${path}";

  static String m17(name) =>
      "Резервом для пустой группы может быть только прокси, а ${name} не существует или является группой прокси";

  static String m18(name, message) =>
      "${name}: недопустимое регулярное выражение: ${message}";

  static String m19(name) => "Прокси для подключения ${name} не существует";

  static String m20(names) => "Эти провайдеры прокси не существуют: ${names}";

  static String m21(names) => "Эти прокси или политики не существуют: ${names}";

  static String m22(name) =>
      "${name} — встроенное имя политики, его нельзя использовать";

  static String m23(count) =>
      "Проблем: ${count}, применение профиля может завершиться ошибкой";

  static String m24(count) =>
      "${Intl.plural(count, one: '${count} день назад', few: '${count} дня назад', many: '${count} дней назад', other: '${count} дня назад')}";

  static String m25(count) => "${count} дн. назад";

  static String m26(label) =>
      "Вы уверены, что хотите удалить выбранные элементы (${label})?";

  static String m27(label) => "Вы уверены, что хотите удалить «${label}»?";

  static String m28(label) => "Сведения: ${label}";

  static String m29(name) =>
      "Подключение через ${name} ведёт обратно к прокси, который его использует, поэтому соединение остановлено";

  static String m30(label) => "Поле «${label}» не может быть пустым";

  static String m31(group) =>
      "Создана запасная автогруппа ${group}. При необходимости выберите её в Proxies.";

  static String m32(group) => "Автовыбор восстановлен для ${group}";

  static String m33(label) => "«${label}» уже существует";

  static String m34(count) => "Ошибок: ${count}. Нажмите, чтобы посмотреть";

  static String m35(label, message) => "${label}: ${message}";

  static String m36(timezone) => "Восстановить ${timezone}";

  static String m37(detail) =>
      "Не удалось выровнять системную таймзону (${detail})";

  static String m38(timezone) => "Часовой пояс ОС восстановлен в ${timezone}";

  static String m39(name) => "${name}: уже последняя версия";

  static String m40(name) => "${name}: обновлено";

  static String m41(count) => "Групп: ${count}";

  static String m42(count) => "Тайм-аут: ${count}";

  static String m43(action) =>
      "Уже используется для «${action}». При сохранении будет перенесено сюда.";

  static String m44(modifiers) =>
      "Добавьте хотя бы одну из клавиш: ${modifiers}";

  static String m45(count) =>
      "${Intl.plural(count, one: '${count} час назад', few: '${count} часа назад', many: '${count} часов назад', other: '${count} часа назад')}";

  static String m46(count) => "${count} ч назад";

  static String m47(count) =>
      "${Intl.plural(count, one: '${count} час', few: '${count} часа', many: '${count} часов', other: '${count} часа')}";

  static String m48(encoding) =>
      "Не удалось декодировать ${encoding}, показаны данные в том виде, в каком они были переданы.";

  static String m49(memory, body) =>
      "Когда записей станет столько или они займут ${memory} памяти, самые старые удаляются первыми. От каждого тела сохраняются первые ${body}.";

  static String m50(invalid, total) =>
      "Недействительно: ${invalid} из ${total}";

  static String m51(target) => "${target} — недопустимая политика";

  static String m52(proxyName) => "${proxyName} — недопустимый прокси";

  static String m53(providerName) =>
      "${providerName} — недопустимый провайдер прокси";

  static String m54(ruleSet) => "${ruleSet} — недопустимый набор правил";

  static String m55(subRule) => "${subRule} — недопустимый SUB_RULE";

  static String m56(count) =>
      "${Intl.plural(count, one: '${count} элемент', few: '${count} элемента', many: '${count} элементов', other: '${count} элемента')}";

  static String m57(line, message) => "Строка ${line}: ${message}";

  static String m58(appName) =>
      "1. Откройте Системные настройки > Конфиденциальность и безопасность\n2. Выберите Службы геолокации\n3. Найдите и отметьте ${appName} в списке\n\nПосле настройки вернитесь в приложение и продолжайте работу. Спасибо за сотрудничество.";

  static String m59(label, max) => "«${label}» — не более ${max} символов";

  static String m60(size) => "Освобождено ${size}";

  static String m61(count) =>
      "${Intl.plural(count, one: '${count} минуту назад', few: '${count} минуты назад', many: '${count} минут назад', other: '${count} минуты назад')}";

  static String m62(count) => "${count} мин назад";

  static String m63(fileName) =>
      "Файл ${fileName} сохранён в «Загрузки». Установите его в настройках: Безопасность › Шифрование и учётные данные › Установка сертификата › Сертификат ЦС.";

  static String m64(command) =>
      "Chrome и Firefox используют собственные хранилища сертификатов, для которых нужен certutil: ${command}";

  static String m65(host) =>
      "Добавить ${host} в список имён хостов? FlClash сможет читать всё, что на него отправляется, включая cookie и пароли.";

  static String m66(host) =>
      "Добавить -${host} в начало списка имён хостов? После этого узел никогда не будет расшифровываться.";

  static String m67(size) => "Файл больше ${size} МБ";

  static String m68(stores) => "Ещё не добавлен в: ${stores}";

  static String m69(name) =>
      "Скрипты модуля ${name} изменились, модуль выключен";

  static String m70(system) =>
      "Написан для ${system}; некоторые строки могут не подходить к приложениям на этом устройстве.";

  static String m71(name) =>
      "Не удалось удалить старый сертификат ${name}. Удалите его из доверенных корневых сертификатов вручную.";

  static String m72(name) =>
      "Старый сертификат ${name} всё ещё среди доверенных системных сертификатов. Разрешите FlClash доступ root в менеджере root и создайте сертификат заново или удалите там модуль «FlClash MITM CA» и перезагрузите устройство.";

  static String m73(name) =>
      "Удалите старый сертификат ${name} в настройках: Безопасность › Шифрование и учётные данные › Надёжные учётные данные › Пользователь, затем установите новый.";

  static String m74(section) => "Раздел [${section}] не поддерживается";

  static String m75(count) =>
      "${Intl.plural(count, one: '${count} месяц назад', few: '${count} месяца назад', many: '${count} месяцев назад', other: '${count} месяца назад')}";

  static String m76(count) => "${count} мес. назад";

  static String m77(code) =>
      "Сервер запретил доступ (HTTP ${code}). Возможно, ссылка устарела или учётные данные неверны";

  static String m78(code) => "Сервер отклонил запрос (HTTP ${code})";

  static String m79(code) =>
      "По этому адресу ничего не найдено (HTTP ${code}). Проверьте правильность URL";

  static String m80(detail) => "Сетевой запрос не выполнен: ${detail}";

  static String m81(code) =>
      "На сервере произошла ошибка (HTTP ${code}). Повторите попытку позже";

  static String m82(label) => "Пока нет: ${label}";

  static String m83(label, min, max) =>
      "Значение «${label}» должно быть от ${min} до ${max}";

  static String m84(label) => "Значение «${label}» должно быть числом";

  static String m85(message) =>
      "Ядро не может разобрать этот прокси: ${message}";

  static String m86(name) =>
      "Имя ${name} уже занято другим прокси или группой прокси";

  static String m87(path) =>
      "Группы прокси ссылаются друг на друга по кругу: ${path}";

  static String m88(names) => "Эти провайдеры прокси не существуют: ${names}";

  static String m89(names) => "Эти прокси или политики не существуют: ${names}";

  static String m90(name) =>
      "${name} — встроенное имя политики, его нельзя использовать";

  static String m91(names) =>
      "Собственные группы прокси профиля ссылаются на прокси, которых больше нет среди пользовательских: ${names}";

  static String m92(count) =>
      "Проблем: ${count}, применение переопределения может завершиться ошибкой";

  static String m93(label) =>
      "Значение «${label}» должно быть от 1024 до 49151";

  static String m94(port) => "Порт ${port}";

  static String m95(days) => "Осталось дней: ${days}";

  static String m96(date, days) => "Истекает ${date}, осталось дней: ${days}";

  static String m97(time) => "Обновлено ${time}";

  static String m98(label, profiles) =>
      "«${label}» всё ещё используется профилями: ${profiles}. После удаления они будут работать неправильно. Вы уверены, что хотите удалить его?";

  static String m99(profiles, label) =>
      "В подписках профилей ${profiles} уже есть «${label}», и после переименования они будут использовать его. Выберите другое имя";

  static String m100(count, label) =>
      "${Intl.plural(count, other: '${label} прокси')}";

  static String m101(name, count) => "${name} и другие (${count} прокси)";

  static String m102(removed) =>
      "Будут удалены прокси: ${removed}. Строка с изменённым именем считается новым прокси, а пользовательские профили, ссылающиеся на удалённые, пометят их как отсутствующие. Применить?";

  static String m103(removed, added) =>
      "Будут удалены прокси: ${removed}. Будут добавлены: ${added}. Строка с изменённым именем считается новым прокси, а пользовательские профили, ссылающиеся на удалённые, пометят их как отсутствующие. Применить?";

  static String m104(label) =>
      "На «${label}» всё ещё ссылаются правила, группы прокси, прокси для подключения, DNS или NTP этого профиля, и после удаления эти ссылки перестанут работать. Вы уверены, что хотите удалить её?";

  static String m105(count, label) =>
      "${Intl.plural(count, one: '${label} группа прокси', few: '${label} группы прокси', many: '${label} групп прокси', other: '${label} группы прокси')}";

  static String m106(count, label) =>
      "${Intl.plural(count, one: '${label} правило', few: '${label} правила', many: '${label} правил', other: '${label} правила')}";

  static String m107(appName) => "${appName} (Безопасный режим)";

  static String m108(count) =>
      "${Intl.plural(count, one: '${count} секунда', few: '${count} секунды', many: '${count} секунд', other: '${count} секунды')}";

  static String m109(count) => "Действуют: ${count}";

  static String m110(count) => "Выбрано: ${count}";

  static String m111(count) => "Проблем: ${count}";

  static String m112(time) => "Проверено в ${time}";

  static String m113(count) =>
      "${Intl.plural(count, one: '${count} настройка', few: '${count} настройки', many: '${count} настроек', other: '${count} настройки')}";

  static String m114(link) => "Не удалось прочитать прокси из ${link}";

  static String m115(label) => "«${label}» — только одно значение";

  static String m116(node) => "Сейчас: ${node}";

  static String m117(target) => "Фактическая цель: ${target}";

  static String m118(group) => "Следовать подписке (${group})";

  static String m119(group) => "Группа: ${group}";

  static String m120(node) => "Узел: ${node}";

  static String m121(count) => "Маршрутов: ${count}";

  static String m122(count) =>
      "Активных узлов: ${count}. Нажмите ping у узла, чтобы проверить связь.";

  static String m123(value) => "Пик ${value}";

  static String m124(value) => "Всего ${value}";

  static String m125(transport) => "Заголовки ${transport}";

  static String m126(version) => "Сейчас ${version}";

  static String m127(label) => "Значение «${label}» должно быть URL";

  static String m128(date) => "Действителен до ${date}";

  static String m129(count) =>
      "${Intl.plural(count, one: '${count} год назад', few: '${count} года назад', many: '${count} лет назад', other: '${count} года назад')}";

  static String m130(count) =>
      "${Intl.plural(count, one: '${count} г. назад', few: '${count} г. назад', many: '${count} л. назад', other: '${count} г. назад')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("О программе"),
    "accessControl": MessageLookupByLibrary.simpleMessage("Контроль доступа"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Через VPN проходят только выбранные приложения",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа выбирает приложения, использующие прокси.",
    ),
    "accessControlDisabledDesc": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа приложений отключён",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Выбранные приложения исключаются из VPN",
    ),
    "accessControlSelectedCount": m0,
    "accessControlSettings": MessageLookupByLibrary.simpleMessage(
      "Настройки контроля доступа",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
    "action": MessageLookupByLibrary.simpleMessage("Действие"),
    "actionDelayTest": MessageLookupByLibrary.simpleMessage(
      "Проверить все задержки",
    ),
    "actionDirectMode": MessageLookupByLibrary.simpleMessage("Прямой режим"),
    "actionGlobalMode": MessageLookupByLibrary.simpleMessage(
      "Глобальный режим",
    ),
    "actionMode": MessageLookupByLibrary.simpleMessage("Переключить режим"),
    "actionProxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "actionRuleMode": MessageLookupByLibrary.simpleMessage("Режим правил"),
    "actionStart": MessageLookupByLibrary.simpleMessage("Старт/Стоп"),
    "actionTun": MessageLookupByLibrary.simpleMessage("TUN"),
    "actionUpdateProfiles": MessageLookupByLibrary.simpleMessage(
      "Обновить профили",
    ),
    "actionView": MessageLookupByLibrary.simpleMessage("Показать/Скрыть"),
    "add": MessageLookupByLibrary.simpleMessage("Добавить"),
    "addCustomProxy": MessageLookupByLibrary.simpleMessage("Добавить прокси"),
    "addFilters": MessageLookupByLibrary.simpleMessage("Добавить фильтры"),
    "addNodes": MessageLookupByLibrary.simpleMessage("Добавить узлы"),
    "addOverrideEntry": MessageLookupByLibrary.simpleMessage(
      "Добавить параметр",
    ),
    "addProfile": MessageLookupByLibrary.simpleMessage("Добавить профиль"),
    "addProxies": MessageLookupByLibrary.simpleMessage("Добавить прокси"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Добавить группу прокси",
    ),
    "addProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Добавить провайдеров прокси",
    ),
    "addRule": MessageLookupByLibrary.simpleMessage("Добавить правило"),
    "addSettingEntry": MessageLookupByLibrary.simpleMessage(
      "Добавить параметр",
    ),
    "addSsid": MessageLookupByLibrary.simpleMessage("Добавить SSID"),
    "addTailscaleNode": MessageLookupByLibrary.simpleMessage(
      "Добавить узел Tailscale",
    ),
    "addToLocalProxies": MessageLookupByLibrary.simpleMessage(
      "Добавить в локальные прокси",
    ),
    "addWidget": MessageLookupByLibrary.simpleMessage("Добавить виджет"),
    "addedRules": MessageLookupByLibrary.simpleMessage("Добавленные правила"),
    "addedToLocalProxies": m1,
    "additionalParameters": MessageLookupByLibrary.simpleMessage(
      "Дополнительные параметры",
    ),
    "additionalPrefix": MessageLookupByLibrary.simpleMessage("Префикс имени"),
    "additionalSuffix": MessageLookupByLibrary.simpleMessage("Суффикс имени"),
    "address": MessageLookupByLibrary.simpleMessage("Адрес"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("Адрес сервера WebDAV"),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Введите корректный адрес WebDAV",
    ),
    "advancedConfig": MessageLookupByLibrary.simpleMessage(
      "Расширенная конфигурация",
    ),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Расширенная конфигурация включает сеть, DNS, добавленные правила и скрипты.",
    ),
    "ageEncryptedProfile": MessageLookupByLibrary.simpleMessage(
      "Зашифрованный профиль",
    ),
    "ageSecretKey": MessageLookupByLibrary.simpleMessage("Секретный ключ age"),
    "ageSecretKeyRequiredTip": MessageLookupByLibrary.simpleMessage(
      "Профиль зашифрован с помощью age, для расшифровки нужен секретный ключ age",
    ),
    "agree": MessageLookupByLibrary.simpleMessage("Согласен"),
    "allReferencedProxies": MessageLookupByLibrary.simpleMessage(
      "Все используемые прокси",
    ),
    "allReferencedProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Все используемые провайдеры прокси",
    ),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Разрешить приложениям обходить VPN",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("Разрешить LAN"),
    "allowedIps": MessageLookupByLibrary.simpleMessage("Разрешённые IP"),
    "alreadyInLocalProxies": m2,
    "answers": MessageLookupByLibrary.simpleMessage("Ответы"),
    "app": MessageLookupByLibrary.simpleMessage("Приложение"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа приложений",
    ),
    "appIconDesign": MessageLookupByLibrary.simpleMessage(
      "Дизайн значка приложения",
    ),
    "appProxiesEmpty": MessageLookupByLibrary.simpleMessage(
      "Нет локальных прокси",
    ),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage(
      "Добавлять системный DNS",
    ),
    "applied": MessageLookupByLibrary.simpleMessage("Применено"),
    "applyNow": MessageLookupByLibrary.simpleMessage("Применить сейчас"),
    "arguments": MessageLookupByLibrary.simpleMessage("Аргументы"),
    "authentication": MessageLookupByLibrary.simpleMessage("Аутентификация"),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "Аутентификация требует логин и пароль для локального порта прокси.",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Пока включена аутентификация, системный прокси не применяется.",
    ),
    "authorize": MessageLookupByLibrary.simpleMessage("Разрешить"),
    "authorized": MessageLookupByLibrary.simpleMessage("Разрешено"),
    "auto": MessageLookupByLibrary.simpleMessage("Авто"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage(
      "Автопроверка обновлений",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Автозакрытие соединений",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Автозакрытие соединений обрывает открытые соединения при смене прокси.",
    ),
    "autoGroupCurrent": m3,
    "autoGroupOverride": m4,
    "autoGroupStickyRegion": m5,
    "autoGroupTitle": m6,
    "autoInclude": MessageLookupByLibrary.simpleMessage(
      "Автоматическое включение",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Автозапуск"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запускаться автоматически при старте системы",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("Автовключение"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Автовключение запускает прокси при открытии приложения.",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Автонастройка системного DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Автообновление"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "backgroundBlur": MessageLookupByLibrary.simpleMessage("Размытие фона"),
    "backup": MessageLookupByLibrary.simpleMessage("Резервное копирование"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование и восстановление",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Синхронизация данных через WebDAV или файлы",
    ),
    "backupFromNewerVersion": MessageLookupByLibrary.simpleMessage(
      "Резервная копия создана более новой версией приложения. Обновите приложение перед восстановлением",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage(
      "Резервная копия создана",
    ),
    "basicInfo": MessageLookupByLibrary.simpleMessage("Основная информация"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("Базовые политики"),
    "batchAdd": MessageLookupByLibrary.simpleMessage("Массовое добавление"),
    "batchImport": MessageLookupByLibrary.simpleMessage("Массовый импорт"),
    "batchLineInputTip": MessageLookupByLibrary.simpleMessage(
      "По одному элементу в строке",
    ),
    "batchLinkInputTip": MessageLookupByLibrary.simpleMessage(
      "По одной ссылке на строку",
    ),
    "batchListInputTip": MessageLookupByLibrary.simpleMessage(
      "По одному значению на строку или через запятую",
    ),
    "batchMapInputTip": MessageLookupByLibrary.simpleMessage(
      "По одной записи на строку: ключ, пробел, значение",
    ),
    "batchPreviewTip": m7,
    "batchUrlInputTip": MessageLookupByLibrary.simpleMessage(
      "По одному URL на строку",
    ),
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "Игнорирование оптимизации батареи позволяет приложению работать в фоне.",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "Из-за системных ограничений во время работы невозможно корректно получить статус оптимизации батареи",
    ),
    "behavior": MessageLookupByLibrary.simpleMessage("Поведение"),
    "binaryData": MessageLookupByLibrary.simpleMessage("Двоичные данные"),
    "bind": MessageLookupByLibrary.simpleMessage("Привязать"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage(
      "Режим чёрного списка",
    ),
    "blockConnection": MessageLookupByLibrary.simpleMessage(
      "Заблокировать соединение",
    ),
    "blockQuic": MessageLookupByLibrary.simpleMessage("Блокировать QUIC"),
    "bodyRewrite": MessageLookupByLibrary.simpleMessage("Перезапись тела"),
    "brightness": MessageLookupByLibrary.simpleMessage("Яркость"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Исключённые домены"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Исключённые домены действуют только при включённом системном прокси.",
    ),
    "bypassPrivateRoute": MessageLookupByLibrary.simpleMessage(
      "Обходить частные адреса",
    ),
    "bypassPrivateRouteDesc": MessageLookupByLibrary.simpleMessage(
      "При обходе частных адресов адреса LAN, loopback и multicast идут в обход TUN.",
    ),
    "cache": MessageLookupByLibrary.simpleMessage("Кэш"),
    "cacheAlgorithm": MessageLookupByLibrary.simpleMessage("Алгоритм кэша"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "Кэш повреждён. Очистить его?",
    ),
    "cacheMaxSize": MessageLookupByLibrary.simpleMessage("Размер кэша"),
    "cameraPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешите доступ к камере в системных настройках, чтобы сканировать QR-коды, или выберите изображение QR-кода из галереи.",
    ),
    "cameraPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется доступ к камере",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Камера недоступна",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage("Снять выделение"),
    "cannotSave": MessageLookupByLibrary.simpleMessage("Не удалось сохранить"),
    "certificate": MessageLookupByLibrary.simpleMessage("Сертификат"),
    "changeProxyFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось переключить прокси; восстановлен предыдущий выбор",
    ),
    "changelogBreaking": MessageLookupByLibrary.simpleMessage(
      "Важные изменения",
    ),
    "changelogFeatures": MessageLookupByLibrary.simpleMessage("Новые функции"),
    "changelogFixes": MessageLookupByLibrary.simpleMessage("Исправления"),
    "changelogPerformance": MessageLookupByLibrary.simpleMessage(
      "Производительность",
    ),
    "changelogReverts": MessageLookupByLibrary.simpleMessage("Откаты"),
    "checkCertificate": MessageLookupByLibrary.simpleMessage(
      "Проверять TLS-сертификаты",
    ),
    "checkCertificateDesc": MessageLookupByLibrary.simpleMessage(
      "Без проверки TLS-сертификатов подписки и резервные копии уязвимы для атаки «человек посередине».",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Проверить обновления"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "У вас уже последняя версия",
    ),
    "cipher": MessageLookupByLibrary.simpleMessage("Шифр"),
    "clearData": MessageLookupByLibrary.simpleMessage("Очистить данные"),
    "clearDataAndExitTip": MessageLookupByLibrary.simpleMessage(
      "Все профили, настройки и локальные данные будут удалены, после чего приложение закроется. Откройте его снова, чтобы начать заново.",
    ),
    "clearDataFailed": m8,
    "clearDnsCache": MessageLookupByLibrary.simpleMessage("Очистить кэш DNS"),
    "clearDnsCacheFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось очистить кэш DNS",
    ),
    "clearSearch": MessageLookupByLibrary.simpleMessage("Очистить поиск"),
    "clientFingerprint": MessageLookupByLibrary.simpleMessage(
      "Отпечаток клиента",
    ),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Экспорт в буфер обмена",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Импорт из буфера обмена",
    ),
    "clipboardNoPackageNames": MessageLookupByLibrary.simpleMessage(
      "В буфере обмена нет допустимых имён пакетов",
    ),
    "clipboardWriteFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось скопировать в буфер обмена. Возможно, выделение слишком велико",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "closeConnection": MessageLookupByLibrary.simpleMessage(
      "Закрыть соединение",
    ),
    "closeConnections": MessageLookupByLibrary.simpleMessage(
      "Закрыть соединения",
    ),
    "color": MessageLookupByLibrary.simpleMessage("Цвет"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Цветовые схемы"),
    "colorStyle": MessageLookupByLibrary.simpleMessage("Стиль палитры"),
    "columns": MessageLookupByLibrary.simpleMessage("Столбцы"),
    "compact": MessageLookupByLibrary.simpleMessage("Компактный"),
    "compatible": MessageLookupByLibrary.simpleMessage("Режим совместимости"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "В конфигурации обнаружены данные",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите удалить все данные?",
    ),
    "confirmDeleteProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите удалить эту группу прокси?",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите закрыть текущее окно?",
    ),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите принудительно завершить ядро со сбоем?",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "После подтверждения существующие данные будут перезаписаны",
    ),
    "congestionControl": MessageLookupByLibrary.simpleMessage(
      "Управление перегрузкой",
    ),
    "congestionController": MessageLookupByLibrary.simpleMessage(
      "Управление перегрузкой TCP",
    ),
    "congestionControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Управление перегрузкой TCP действует только со стеком mips.",
    ),
    "connected": MessageLookupByLibrary.simpleMessage("Подключено"),
    "connecting": MessageLookupByLibrary.simpleMessage("Подключение…"),
    "connection": MessageLookupByLibrary.simpleMessage("Соединение"),
    "connectionStats": MessageLookupByLibrary.simpleMessage(
      "Статистика подключений",
    ),
    "connectionStatsDesc": MessageLookupByLibrary.simpleMessage(
      "Подключения, запросы и DNS-запросы",
    ),
    "connections": MessageLookupByLibrary.simpleMessage("Соединения"),
    "connectivity": MessageLookupByLibrary.simpleMessage("Подключение: "),
    "content": MessageLookupByLibrary.simpleMessage("Содержимое"),
    "contentNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Содержимое не может быть пустым",
    ),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Контентная"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "Управление глобальными добавленными правилами",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Копировать"),
    "copyAsBase64": MessageLookupByLibrary.simpleMessage(
      "Копировать как Base64",
    ),
    "copyAsCurl": MessageLookupByLibrary.simpleMessage("Копировать как cURL"),
    "copyDestination": MessageLookupByLibrary.simpleMessage(
      "Копировать адрес назначения",
    ),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Копировать переменные окружения",
    ),
    "copyHost": MessageLookupByLibrary.simpleMessage("Копировать хост"),
    "copyLink": MessageLookupByLibrary.simpleMessage("Копировать ссылку"),
    "copyRequest": MessageLookupByLibrary.simpleMessage("Копировать запрос"),
    "copyResponse": MessageLookupByLibrary.simpleMessage("Копировать ответ"),
    "copyResponseBody": MessageLookupByLibrary.simpleMessage(
      "Копировать тело ответа",
    ),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Скопировано"),
    "core": MessageLookupByLibrary.simpleMessage("Ядро"),
    "coreBlockedByPolicyTip": m9,
    "coreBlockedBySmartAppControlTip": MessageLookupByLibrary.simpleMessage(
      "Smart App Control в Windows заблокировал неподписанный FlClashCore.exe. Откройте Безопасность Windows → Управление приложениями и браузером → Параметры Smart App Control, выберите «Выкл.» и снова запустите FlClash. Повторно включить Smart App Control без переустановки Windows нельзя.",
    ),
    "coreStatus": MessageLookupByLibrary.simpleMessage("Статус ядра"),
    "country": MessageLookupByLibrary.simpleMessage("Регион"),
    "crashDetected": MessageLookupByLibrary.simpleMessage("Обнаружен сбой"),
    "crashDetectedTip": m10,
    "crashTest": MessageLookupByLibrary.simpleMessage("Тест сбоя"),
    "crashlytics": MessageLookupByLibrary.simpleMessage("Аналитика сбоев"),
    "crashlyticsTip": MessageLookupByLibrary.simpleMessage(
      "При включении в случае сбоя приложения автоматически загружаются логи сбоя без конфиденциальной информации",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "createProfileFromUrlTip": m11,
    "creationTime": MessageLookupByLibrary.simpleMessage("Время создания"),
    "currentOutboundDesc": MessageLookupByLibrary.simpleMessage(
      "Содержит кнопку запуска, удалить нельзя",
    ),
    "custom": MessageLookupByLibrary.simpleMessage("Вручную"),
    "customColor": MessageLookupByLibrary.simpleMessage("Свой цвет"),
    "customImportDroppedSubRules": m12,
    "customIssueCoreRejected": m13,
    "customIssueDialerLoop": m14,
    "customIssueDuplicateName": m15,
    "customIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "Имя не задано",
    ),
    "customIssueGroupLoop": m16,
    "customIssueInvalidEmptyFallback": m17,
    "customIssueInvalidFilter": m18,
    "customIssueMissingDialer": m19,
    "customIssueMissingProviders": m20,
    "customIssueMissingProxies": m21,
    "customIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "Не выбраны ни прокси, ни провайдеры прокси, поэтому ядро отклонит эту группу",
    ),
    "customIssueReservedName": m22,
    "customIssuesSummary": m23,
    "customProfile": MessageLookupByLibrary.simpleMessage("Пользовательский"),
    "customProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Группы прокси и правила из прокси приложения и других профилей",
    ),
    "customProfileResources": MessageLookupByLibrary.simpleMessage(
      "Ресурсы пользовательских профилей",
    ),
    "customProfileResourcesDesc": MessageLookupByLibrary.simpleMessage(
      "Ресурсы пользовательских профилей — это прокси, провайдеры правил, фильтры и наборы значков, которые вы сами добавляете для пользовательских профилей.",
    ),
    "customProxiesEmpty": MessageLookupByLibrary.simpleMessage(
      "Пользовательских прокси нет, поэтому используются прокси самого профиля",
    ),
    "customResources": MessageLookupByLibrary.simpleMessage("Пользовательские"),
    "cut": MessageLookupByLibrary.simpleMessage("Вырезать"),
    "dark": MessageLookupByLibrary.simpleMessage("Тёмная"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Панель"),
    "dashboardAddableSection": MessageLookupByLibrary.simpleMessage(
      "Можно добавить",
    ),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "Обнаружены изменения данных. Сохранить их?",
    ),
    "dataCollectionContent": MessageLookupByLibrary.simpleMessage(
      "Это приложение использует Firebase Crashlytics для сбора информации о сбоях, чтобы повысить стабильность.\nСобираемые данные включают сведения об устройстве и подробности сбоя и не содержат личных конфиденциальных данных.\nЭту функцию можно отключить в настройках.",
    ),
    "dataCollectionTip": MessageLookupByLibrary.simpleMessage(
      "Уведомление о сборе данных",
    ),
    "databaseWriteFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось сохранить изменение; оно отменено",
    ),
    "daysAgo": m24,
    "daysAgoShort": m25,
    "decryptUntrusted": MessageLookupByLibrary.simpleMessage(
      "Расшифровывать без локального доверия",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешает имена других DNS-серверов. Только IP-адреса.",
    ),
    "defaultSelected": MessageLookupByLibrary.simpleMessage(
      "Выбор по умолчанию",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("По умолчанию"),
    "definitionNotMap": MessageLookupByLibrary.simpleMessage(
      "Конфигурация должна быть YAML-словарём с полями name и type",
    ),
    "delay": MessageLookupByLibrary.simpleMessage("Задержка"),
    "delayFailed": MessageLookupByLibrary.simpleMessage("Сбой"),
    "delayTest": MessageLookupByLibrary.simpleMessage("Тест задержки"),
    "delayTestTimeout": MessageLookupByLibrary.simpleMessage(
      "Тайм-аут теста задержки",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "deleteMultipTip": m26,
    "deleteTip": m27,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Многоплатформенный прокси-клиент на основе ClashMeta: простой и удобный, с открытым исходным кодом и без рекламы.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Назначение"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "GeoIP назначения",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage(
      "ASN IP назначения",
    ),
    "details": m28,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Использует сторонний API; только для справки",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Режим разработчика"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Режим разработчика включён.",
    ),
    "dialerProxy": MessageLookupByLibrary.simpleMessage(
      "Прокси для подключения",
    ),
    "dialerProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Прокси для подключения — исход, через который идёт обращение к NTP-серверу.",
    ),
    "dialerProxyLoopStopped": m29,
    "dialog": MessageLookupByLibrary.simpleMessage("Диалог"),
    "direct": MessageLookupByLibrary.simpleMessage("Прямой"),
    "directNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешает домены прямых соединений.",
    ),
    "disableIcmpForwarding": MessageLookupByLibrary.simpleMessage(
      "Отключить пересылку ICMP",
    ),
    "disableIcmpForwardingDesc": MessageLookupByLibrary.simpleMessage(
      "При отключённой пересылке ICMP TUN сам отвечает на ping, поэтому ping больше не показывает реальную задержку.",
    ),
    "disableKeepAlive": MessageLookupByLibrary.simpleMessage(
      "Отключить TCP keep-alive",
    ),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Отключить UDP"),
    "disabled": MessageLookupByLibrary.simpleMessage("Выключено"),
    "discardChanges": MessageLookupByLibrary.simpleMessage(
      "Отменить изменения?",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage(
      "Отказ от ответственности",
    ),
    "disclaimerAcceptContent": MessageLookupByLibrary.simpleMessage(
      "Это заявление описывает характер, риски и ответственность при использовании Программы. Оно не является дополнительным условием к GPL-3.0 и не ограничивает никаких прав, которые даёт вам эта лицензия, включая право запускать, копировать, изменять и распространять Программу. При расхождении действует GPL-3.0.",
    ),
    "disclaimerAcceptTitle": MessageLookupByLibrary.simpleMessage(
      "Связь с открытой лицензией",
    ),
    "disclaimerAcknowledgeLabel": MessageLookupByLibrary.simpleMessage(
      "Я прочитал(а) и понимаю это заявление",
    ),
    "disclaimerAcknowledgeTip": MessageLookupByLibrary.simpleMessage(
      "Чтобы подтвердить, что вы ознакомились с ним, прочитайте следующее заявление и отметьте пункт ниже:",
    ),
    "disclaimerAcknowledgeTitle": MessageLookupByLibrary.simpleMessage(
      "Подтвердите заявление",
    ),
    "disclaimerAnalyticsContent": MessageLookupByLibrary.simpleMessage(
      "Вместе с Firebase автоматически собирается базовая статистика использования приложения.\n\nЧто собирается: базовые события, такие как первый запуск, открытие приложения и длительность сеанса, обновление приложения; идентификатор экземпляра приложения; модель устройства, версия ОС и язык системы; приблизительное местоположение на уровне страны или региона, определённое по IP-адресу.\n\nЦель: только оценка числа активных устройств, распределения версий и совместимости с ОС. Разработчики не используют эти данные для рекламы, не продают их и не связывают с вашими подписками или конфигурациями.",
    ),
    "disclaimerAnalyticsTitle": MessageLookupByLibrary.simpleMessage(
      "Firebase Analytics (статистика использования)",
    ),
    "disclaimerAndroidOnly": MessageLookupByLibrary.simpleMessage(
      "Только Android",
    ),
    "disclaimerChangesContent": MessageLookupByLibrary.simpleMessage(
      "Это заявление может меняться в следующих версиях; к каждой версии относится заявление, поставляемое с ней.",
    ),
    "disclaimerChangesTitle": MessageLookupByLibrary.simpleMessage(
      "Изменения заявления",
    ),
    "disclaimerCrashlyticsContent": MessageLookupByLibrary.simpleMessage(
      "При сбое приложения отчёт о сбое отправляется автоматически.\n\nЧто собирается: трассировка стека и сообщение об ошибке, время сбоя, версия и номер сборки приложения, производитель и модель устройства, версия Android, ориентация экрана, свободная память и место в хранилище, наличие root-доступа, а также случайный идентификатор установки, который создаётся при установке и сбрасывается при переустановке.\n\nЦель: только поиск и исправление сбоев.\n\nВы можете отключить это в любой момент: «Инструменты > Общие > Аналитика сбоев».",
    ),
    "disclaimerCrashlyticsTitle": MessageLookupByLibrary.simpleMessage(
      "Firebase Crashlytics (аналитика сбоев)",
    ),
    "disclaimerDataProcessingContent": MessageLookupByLibrary.simpleMessage(
      "Эти данные обрабатываются и хранятся компанией Google от нашего имени, могут передаваться на серверы за пределами вашей страны или региона (например, в США) и регулируются Политикой конфиденциальности Google и документацией Firebase о конфиденциальности и безопасности. Отчёты о сбоях хранятся до 90 дней; статистика хранится в соответствии с политикой хранения Firebase по умолчанию.",
    ),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "Перед использованием FlClash («Программа») внимательно прочитайте это заявление и убедитесь, что понимаете его. Нажимая «Согласен», вы подтверждаете, что прочитали и поняли изложенное ниже. Если не хотите продолжать, нажмите «Выход».",
    ),
    "disclaimerFirebasePrivacy": MessageLookupByLibrary.simpleMessage(
      "Конфиденциальность и безопасность Firebase",
    ),
    "disclaimerGooglePrivacy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности Google",
    ),
    "disclaimerLiabilityContent": MessageLookupByLibrary.simpleMessage(
      "В максимальной степени, допустимой применимым законодательством, ни разработчики, ни участники проекта не несут ответственности за любой прямой, косвенный, случайный, особый, штрафной или последующий ущерб, возникший в результате использования или невозможности использования Программы, включая, помимо прочего, потерю данных, повреждение устройства, сбои сети, прерывание деятельности, упущенную выгоду или связанные с этим правовые споры, даже если они были предупреждены о возможности такого ущерба.",
    ),
    "disclaimerLiabilityTitle": MessageLookupByLibrary.simpleMessage(
      "Ограничение ответственности",
    ),
    "disclaimerLicenseContent": MessageLookupByLibrary.simpleMessage(
      "Программа распространяется с открытым исходным кодом по лицензии GPL-3.0. По этой лицензии вы можете запускать, изучать, изменять и распространять её; распространяя Программу или её изменённую версию, вы должны также предоставить исходный код по GPL-3.0 и сохранить исходные уведомления об авторских правах.\n\nСторонние компоненты Программы, включая ядро Clash.Meta, распространяются по своим лицензиям. Исходные авторы не отвечают за проблемы версий, изменённых или распространяемых другими.",
    ),
    "disclaimerLicenseTitle": MessageLookupByLibrary.simpleMessage(
      "Лицензия с открытым исходным кодом",
    ),
    "disclaimerNoServiceStatement": MessageLookupByLibrary.simpleMessage(
      "Сама Программа не предоставляет прокси-серверы, узлы, подписки или услуги доступа к сети и не состоит в партнёрских, агентских или гарантийных отношениях с поставщиками таких услуг.",
    ),
    "disclaimerPrivacyContent": MessageLookupByLibrary.simpleMessage(
      "Программа не собирает и не отправляет адреса ваших подписок, сведения об узлах, содержимое конфигураций, посещённые сайты, записи о подключениях, содержимое трафика и журналы. Эти данные хранятся только на вашем устройстве, и у разработчиков нет к ним доступа.\n\nПрограмма обращается к сети только при использовании соответствующих функций, например загружает указанный вами адрес подписки при обновлении профиля или обращается к GitHub при проверке обновлений.\n\nПрограмма не содержит никаких сервисов статистики или отчётов о сбоях ни на одной платформе.",
    ),
    "disclaimerPrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Сбор данных и конфиденциальность",
    ),
    "disclaimerResponsibilityContent": MessageLookupByLibrary.simpleMessage(
      "Вы самостоятельно убеждаетесь, что использование Программы законно в вашей стране или регионе, и единолично несёте юридическую ответственность за все действия с ней и их последствия.\n\nПодписки, узлы и конфигурации, которые вы импортируете, выбираете вы сами. Законность их источника, безопасность содержимого и надёжность сервиса — вопрос между вами и их поставщиками.",
    ),
    "disclaimerResponsibilityTitle": MessageLookupByLibrary.simpleMessage(
      "Ваша ответственность",
    ),
    "disclaimerRestateHint": MessageLookupByLibrary.simpleMessage(
      "Введите заявление выше",
    ),
    "disclaimerRestateMismatch": MessageLookupByLibrary.simpleMessage(
      "Не совпадает с текстом заявления",
    ),
    "disclaimerRestateTip": MessageLookupByLibrary.simpleMessage(
      "Чтобы подтвердить, что вы ознакомились с ним, полностью введите следующее заявление в поле ниже:",
    ),
    "disclaimerRestateTitle": MessageLookupByLibrary.simpleMessage(
      "Повторите заявление",
    ),
    "disclaimerSoftwareContent": MessageLookupByLibrary.simpleMessage(
      "Программа — это клиент сетевого прокси с открытым исходным кодом на основе ядра Clash.Meta (mihomo). Она предоставляет только локальные инструменты: управление конфигурациями, маршрутизацию по правилам и пересылку трафика.",
    ),
    "disclaimerSoftwareTitle": MessageLookupByLibrary.simpleMessage(
      "Характер программы",
    ),
    "disclaimerThirdPartyContent": MessageLookupByLibrary.simpleMessage(
      "Ссылки на подписки, файлы конфигурации, наборы правил, скрипты, внешние ресурсы и внешние ссылки предоставляются третьими лицами. Разработчики не могут проверять и не проверяют их законность, точность, безопасность и доступность и не дают на них никаких гарантий.\n\nУтечка данных, финансовые потери, блокировка аккаунта или иной ущерб, вызванные сторонним контентом, урегулируются между вами и третьим лицом; разработчики не несут за это никакой ответственности.",
    ),
    "disclaimerThirdPartyTitle": MessageLookupByLibrary.simpleMessage(
      "Сторонний контент",
    ),
    "disclaimerUsageContent": MessageLookupByLibrary.simpleMessage(
      "Любая коммерческая деятельность с использованием Программы, включая платное распространение, продажу в комплекте или использование в составе коммерческого сервиса, не связана с разработчиками Программы, которые её не одобряют, не поддерживают и не гарантируют.\n\nВы сами отвечаете за соблюдение законов страны или региона, где находитесь, и несёте последствия любого незаконного использования Программы.",
    ),
    "disclaimerUsageTitle": MessageLookupByLibrary.simpleMessage(
      "Об использовании",
    ),
    "disclaimerWarrantyContent": MessageLookupByLibrary.simpleMessage(
      "Программа предоставляется «как есть» и «по мере доступности», без каких-либо явных или подразумеваемых гарантий, включая, помимо прочего, гарантии товарной пригодности, пригодности для определённой цели, ненарушения прав, бесперебойной работы, отсутствия ошибок и уязвимостей.\n\nРазработчики не гарантируют, что Программа будет соответствовать вашим потребностям или работать без сбоев и ошибок.",
    ),
    "disclaimerWarrantyTitle": MessageLookupByLibrary.simpleMessage(
      "Отсутствие гарантий",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage("Отключено"),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage(
      "Доступна новая версия",
    ),
    "dnsCacheCleared": MessageLookupByLibrary.simpleMessage("Кэш DNS очищен"),
    "dnsHijackDesc": MessageLookupByLibrary.simpleMessage(
      "Без этого параметра TUN перехватывает все DNS-запросы на порт 53 (any:53).",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("Перехват DNS"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Режим DNS"),
    "dnsOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Добавленные здесь параметры заменяют DNS всех профилей из URL и файлов; остальные остаются такими, как в профиле. DNS пользовательского профиля задаётся в его содержимом.",
    ),
    "dnsQueries": MessageLookupByLibrary.simpleMessage("DNS-запросы"),
    "docked": MessageLookupByLibrary.simpleMessage("Закреплённая"),
    "domain": MessageLookupByLibrary.simpleMessage("Домен"),
    "done": MessageLookupByLibrary.simpleMessage("Готово"),
    "download": MessageLookupByLibrary.simpleMessage("Загрузка"),
    "downloadBandwidth": MessageLookupByLibrary.simpleMessage(
      "Скорость загрузки",
    ),
    "downloadingUpdate": MessageLookupByLibrary.simpleMessage(
      "Загрузка обновления",
    ),
    "duration": MessageLookupByLibrary.simpleMessage("Длительность"),
    "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
    "editDashboard": MessageLookupByLibrary.simpleMessage("Изменить панель"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Редактировать глобальные правила",
    ),
    "editProxy": MessageLookupByLibrary.simpleMessage("Редактировать прокси"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Редактировать группу прокси",
    ),
    "editRule": MessageLookupByLibrary.simpleMessage("Редактировать правило"),
    "editSsid": MessageLookupByLibrary.simpleMessage("Изменить SSID"),
    "editTailscaleNode": MessageLookupByLibrary.simpleMessage(
      "Изменить узел Tailscale",
    ),
    "editorUnavailable": MessageLookupByLibrary.simpleMessage(
      "Редактор недоступен",
    ),
    "elapsed": MessageLookupByLibrary.simpleMessage("Время"),
    "emptyFallback": MessageLookupByLibrary.simpleMessage(
      "Резерв для пустой группы",
    ),
    "emptyTip": m30,
    "en": MessageLookupByLibrary.simpleMessage("Английский"),
    "enableAutoSelect": MessageLookupByLibrary.simpleMessage(
      "Создать запасную автогруппу",
    ),
    "enableAutoSelectCreateTip": MessageLookupByLibrary.simpleMessage(
      "В большинстве подписок уже есть url-test/fallback. Здесь не найдено — создать простую запасную группу «FlClash Auto»? Переключит overwrite на Custom; пустые группы станут Auto + PROXY (узлы сохраняются через include-all-proxies).",
    ),
    "enableAutoSelectCreated": m31,
    "enableAutoSelectFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось создать запасную автогруппу",
    ),
    "enableAutoSelectRestored": m32,
    "enabled": MessageLookupByLibrary.simpleMessage("Включено"),
    "entries": MessageLookupByLibrary.simpleMessage(" записей"),
    "error": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "errorDetails": MessageLookupByLibrary.simpleMessage("Подробности ошибки"),
    "es": MessageLookupByLibrary.simpleMessage("Испанский"),
    "exclude": MessageLookupByLibrary.simpleMessage("Скрыть из недавних задач"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Скрывать приложение из недавних задач, когда оно в фоне",
    ),
    "excludeDstPort": MessageLookupByLibrary.simpleMessage(
      "Исключённые порты назначения",
    ),
    "excludeDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Трафик на исключённые порты назначения идёт в обход TUN.",
    ),
    "excludeFilter": MessageLookupByLibrary.simpleMessage("Фильтр исключения"),
    "excludeInterface": MessageLookupByLibrary.simpleMessage(
      "Исключённые интерфейсы",
    ),
    "excludeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "Трафик с исключённых интерфейсов, например с docker0, идёт в обход TUN.",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage(
      "Фильтр исключения узлов",
    ),
    "excludeSrcPort": MessageLookupByLibrary.simpleMessage(
      "Исключённые исходные порты",
    ),
    "excludeSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Трафик с исключённых исходных портов идёт в обход TUN.",
    ),
    "excludeSsids": MessageLookupByLibrary.simpleMessage("Исключённые SSID"),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "При подключении к Wi-Fi с исключённым SSID состояние работы приложения переключается автоматически.",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Исключаемые типы"),
    "excludeUid": MessageLookupByLibrary.simpleMessage(
      "Исключённые ID пользователей",
    ),
    "excludeUidDesc": MessageLookupByLibrary.simpleMessage(
      "Трафик процессов исключённых ID пользователей идёт в обход TUN.",
    ),
    "existsTip": m33,
    "exit": MessageLookupByLibrary.simpleMessage("Выход"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage(
      "Выйти из полноэкранного режима",
    ),
    "exitNodes": MessageLookupByLibrary.simpleMessage("Выходные узлы"),
    "expand": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Ожидаемый статус"),
    "expireTime": MessageLookupByLibrary.simpleMessage("Срок действия"),
    "exportCertificate": MessageLookupByLibrary.simpleMessage(
      "Экспортировать сертификат",
    ),
    "exportFile": MessageLookupByLibrary.simpleMessage("Экспорт файла"),
    "exportHar": MessageLookupByLibrary.simpleMessage("Экспорт HAR"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Экспорт логов"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Экспорт выполнен"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Экспрессивная"),
    "extend": MessageLookupByLibrary.simpleMessage("Расширение"),
    "extendMode": MessageLookupByLibrary.simpleMessage("Режим расширения"),
    "extendScript": MessageLookupByLibrary.simpleMessage("Скрипт расширения"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "Внешний контроллер",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Внешний контроллер позволяет управлять ядром через порт 9090.",
    ),
    "externalControllerSecret": MessageLookupByLibrary.simpleMessage(
      "Секрет внешнего контроллера",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("Внешняя ссылка"),
    "extraLarge": MessageLookupByLibrary.simpleMessage("Очень крупный"),
    "fade": MessageLookupByLibrary.simpleMessage("Растворение"),
    "failedCount": m34,
    "failedItem": m35,
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Фильтр Fake-IP"),
    "fakeipFilterDesc": MessageLookupByLibrary.simpleMessage(
      "Эти домены получают реальные IP вместо Fake-IP. В режиме whitelist Fake-IP получают только они.",
    ),
    "fakeipFilterMode": MessageLookupByLibrary.simpleMessage(
      "Режим фильтра Fake-IP",
    ),
    "fakeipFilterModeDesc": MessageLookupByLibrary.simpleMessage(
      "В режиме фильтра Fake-IP blacklist исключает совпадения, whitelist применяется только к ним, rule — по правилам.",
    ),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Диапазон Fake-IP"),
    "fakeipRange6": MessageLookupByLibrary.simpleMessage(
      "Диапазон Fake-IP (IPv6)",
    ),
    "fakeipTtl": MessageLookupByLibrary.simpleMessage("TTL Fake-IP"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Используются вместо Nameserver, когда фильтр fallback считает его ответ подменённым.",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Фильтр fallback"),
    "fallbackFilterDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Эти домены сразу разрешаются через Fallback.",
    ),
    "fallbackFilterGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Домены из этих категорий GeoSite сразу разрешаются через Fallback.",
    ),
    "fallbackFilterIpcidrDesc": MessageLookupByLibrary.simpleMessage(
      "Если Nameserver возвращает IP из этих диапазонов, используется ответ Fallback.",
    ),
    "features": MessageLookupByLibrary.simpleMessage("Функции"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Точная передача"),
    "file": MessageLookupByLibrary.simpleMessage("Файл"),
    "fileDesc": MessageLookupByLibrary.simpleMessage(
      "Загрузить файл профиля напрямую",
    ),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "Файл изменён. Сохранить изменения?",
    ),
    "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
    "filters": MessageLookupByLibrary.simpleMessage("Фильтры"),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Поиск процесса"),
    "floating": MessageLookupByLibrary.simpleMessage("Плавающая"),
    "followProfile": MessageLookupByLibrary.simpleMessage("Как в профиле"),
    "followSystem": MessageLookupByLibrary.simpleMessage("Как в системе"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Шрифт"),
    "fontSize": MessageLookupByLibrary.simpleMessage("Размер"),
    "forceDnsMapping": MessageLookupByLibrary.simpleMessage(
      "Принудительно для DNS-сопоставлений",
    ),
    "forceDnsMappingDesc": MessageLookupByLibrary.simpleMessage(
      "«Принудительно для DNS-сопоставлений» анализирует и соединения, домен которых получен из DNS-сопоставления.",
    ),
    "forceDomain": MessageLookupByLibrary.simpleMessage(
      "Принудительные домены",
    ),
    "forceDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Принудительные домены тоже анализируются; остальные соединения с доменом не затрагиваются.",
    ),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите принудительно перезапустить ядро?",
    ),
    "format": MessageLookupByLibrary.simpleMessage("Формат"),
    "fr": MessageLookupByLibrary.simpleMessage("Французский"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("Фруктовый микс"),
    "general": MessageLookupByLibrary.simpleMessage("Общие"),
    "generalOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Добавленные здесь параметры заменяют соответствующие настройки всех профилей; остальные остаются такими, как в профиле, а если профиль их не задаёт, действуют значения ядра по умолчанию.",
    ),
    "generateCertificate": MessageLookupByLibrary.simpleMessage(
      "Создать сертификат",
    ),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("Автообновление"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления",
    ),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления должен быть больше 0",
    ),
    "geoIdentity": MessageLookupByLibrary.simpleMessage("Геоидентичность"),
    "geoIdentityCaptureMode": MessageLookupByLibrary.simpleMessage(
      "Режим перехвата трафика",
    ),
    "geoIdentityCaptureModeAuto": MessageLookupByLibrary.simpleMessage(
      "Авто — не менять текущие настройки; если нет перехвата, включить только TUN",
    ),
    "geoIdentityCaptureModeBoth": MessageLookupByLibrary.simpleMessage(
      "Системный прокси + TUN",
    ),
    "geoIdentityCaptureModeSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Только системный прокси",
    ),
    "geoIdentityCaptureModeTun": MessageLookupByLibrary.simpleMessage(
      "Только TUN / виртуальный NIC",
    ),
    "geoIdentityCheckCancelled": MessageLookupByLibrary.simpleMessage(
      "Проверка сети отменена",
    ),
    "geoIdentityCheckFailed": MessageLookupByLibrary.simpleMessage(
      "Сетевая проверка не удалась",
    ),
    "geoIdentityCopyTerminalProxy": MessageLookupByLibrary.simpleMessage(
      "Скопировать proxy export\'ы для терминала",
    ),
    "geoIdentityCopyTerminalProxyShort": MessageLookupByLibrary.simpleMessage(
      "Скопировать HTTP(S)_PROXY для терминала",
    ),
    "geoIdentityDesc": MessageLookupByLibrary.simpleMessage(
      "Один переключатель для US exit",
    ),
    "geoIdentityHideAdvanced": MessageLookupByLibrary.simpleMessage(
      "Скрыть дополнительно",
    ),
    "geoIdentityHonestyLine": MessageLookupByLibrary.simpleMessage(
      "Это покрывает IP выхода и язык зонда. Шрифты/геолокация браузера всё ещё нуждаются в GeoMirror; Claude Code — в совпадающей системной таймзоне (и TUN или proxy-переменных).",
    ),
    "geoIdentityNeedStart": MessageLookupByLibrary.simpleMessage(
      "Запустите FlClash перед проверкой сетевой среды.",
    ),
    "geoIdentityNetworkBad": MessageLookupByLibrary.simpleMessage(
      "Выход ещё не US — выберите US-узел и нажмите «Проверить снова»",
    ),
    "geoIdentityNetworkExposed": MessageLookupByLibrary.simpleMessage(
      "Сеть всё ещё выглядит раскрытой",
    ),
    "geoIdentityNetworkGood": MessageLookupByLibrary.simpleMessage(
      "Сеть готова к работе",
    ),
    "geoIdentityOffStatus": MessageLookupByLibrary.simpleMessage(
      "Защита геоидентичности выключена",
    ),
    "geoIdentityOpenGeoMirror": MessageLookupByLibrary.simpleMessage(
      "GeoMirror на GitHub",
    ),
    "geoIdentityOpenGeoMirrorShort": MessageLookupByLibrary.simpleMessage(
      "Выравнивание отпечатка браузера",
    ),
    "geoIdentityPendingCheck": MessageLookupByLibrary.simpleMessage(
      "Защита включена — ожидается проверка сети",
    ),
    "geoIdentityProtectEnable": MessageLookupByLibrary.simpleMessage(
      "Включить защиту геоидентичности",
    ),
    "geoIdentityProtectToggleDesc": MessageLookupByLibrary.simpleMessage(
      "Захват трафика, выравнивание часового пояса на ПК и проверка выхода",
    ),
    "geoIdentityPurposeBody": MessageLookupByLibrary.simpleMessage(
      "Включите, чтобы FlClash захватил трафик и проверил US-выход для AI. Для отпечатков браузера по-прежнему может понадобиться GeoMirror.",
    ),
    "geoIdentityRecheck": MessageLookupByLibrary.simpleMessage(
      "Проверить снова",
    ),
    "geoIdentityRestoreOsTimezone": MessageLookupByLibrary.simpleMessage(
      "Восстановить прежний часовой пояс ОС",
    ),
    "geoIdentityRestoreOsTimezoneDesc": m36,
    "geoIdentitySetupDoneNeedUsNode": MessageLookupByLibrary.simpleMessage(
      "Настройка применена, но выход ещё не US. Выберите US-узел и нажмите «Проверить снова».",
    ),
    "geoIdentitySetupDoneProtected": MessageLookupByLibrary.simpleMessage(
      "Готово — сеть выглядит US-защищённой.",
    ),
    "geoIdentitySetupRunning": MessageLookupByLibrary.simpleMessage(
      "Применяется быстрая настройка…",
    ),
    "geoIdentitySetupStarting": MessageLookupByLibrary.simpleMessage(
      "Запуск FlClash…",
    ),
    "geoIdentitySetupTimezone": MessageLookupByLibrary.simpleMessage(
      "Выравнивание часового пояса ОС…",
    ),
    "geoIdentitySetupVerifying": MessageLookupByLibrary.simpleMessage(
      "Проверка сетевой среды…",
    ),
    "geoIdentityShowAdvanced": MessageLookupByLibrary.simpleMessage(
      "Показать дополнительно",
    ),
    "geoIdentityTimezone": MessageLookupByLibrary.simpleMessage(
      "Системный часовой пояс",
    ),
    "geoIdentityTimezoneAlignFailed": m37,
    "geoIdentityTimezoneAndroidTip": MessageLookupByLibrary.simpleMessage(
      "Android без root не даёт приложению менять системный часовой пояс. Откройте Настройки → Система → Дата и время и выберите US-зону под ваш exit.",
    ),
    "geoIdentityTimezoneMissing": MessageLookupByLibrary.simpleMessage(
      "Ещё нет timezone выхода. Сначала проверьте сетевую среду.",
    ),
    "geoIdentityTimezoneNothingToRestore": MessageLookupByLibrary.simpleMessage(
      "Нет сохранённого предыдущего часового пояса ОС.",
    ),
    "geoIdentityTimezoneRestored": m38,
    "geoIdentityTurningOff": MessageLookupByLibrary.simpleMessage(
      "Выключение…",
    ),
    "geoIdentityUsAcceptLanguage": MessageLookupByLibrary.simpleMessage(
      "Проверять с US Accept-Language",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Настройки Geo"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Geo"),
    "geoSkipped": m39,
    "geoUpdated": m40,
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Geo: экономия памяти",
    ),
    "global": MessageLookupByLibrary.simpleMessage("Глобальный"),
    "go": MessageLookupByLibrary.simpleMessage("Перейти"),
    "goDownload": MessageLookupByLibrary.simpleMessage("Скачать"),
    "goToConfigureAddedRules": MessageLookupByLibrary.simpleMessage(
      "Перейти к настройке добавленных правил",
    ),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage(
      "Перейти к настройке скрипта",
    ),
    "grid": MessageLookupByLibrary.simpleMessage("Сетка"),
    "groupBy": MessageLookupByLibrary.simpleMessage("Группировка"),
    "groupCount": m41,
    "groupCountUnit": MessageLookupByLibrary.simpleMessage("групп"),
    "groupTimeoutCount": m42,
    "groupTypeFallback": MessageLookupByLibrary.simpleMessage("Fallback"),
    "groupTypeUrlTest": MessageLookupByLibrary.simpleMessage("URLTest"),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Кэшировать изменения?",
    ),
    "hashByInUser": MessageLookupByLibrary.simpleMessage(
      "Хешировать по пользователю входящего подключения",
    ),
    "headerRewrite": MessageLookupByLibrary.simpleMessage(
      "Перезапись заголовков",
    ),
    "healthCheck": MessageLookupByLibrary.simpleMessage("Проверка состояния"),
    "helperCorruptTip": MessageLookupByLibrary.simpleMessage(
      "Служба Helper недоступна, поэтому TUN-режим включить нельзя. Переустановите FlClash.",
    ),
    "hex": MessageLookupByLibrary.simpleMessage("Hex"),
    "hideAdvanced": MessageLookupByLibrary.simpleMessage(
      "Скрыть дополнительно",
    ),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Скрыть из списка"),
    "hideIp": MessageLookupByLibrary.simpleMessage("Скрыть IP"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Скрыть пароль"),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage(
      "Скрывать прокси с таймаутом",
    ),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "Не показывать прокси, у которых последний тест задержки завершился таймаутом",
    ),
    "hopInterval": MessageLookupByLibrary.simpleMessage("Интервал перескока"),
    "host": MessageLookupByLibrary.simpleMessage("Хост"),
    "hostname": MessageLookupByLibrary.simpleMessage("Имя хоста"),
    "hotkeyConflictWith": m43,
    "hotkeyDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальные горячие клавиши работают, даже когда окно скрыто. Нажмите на действие, чтобы записать сочетание клавиш.",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("Горячие клавиши"),
    "hotkeyNeedsModifier": m44,
    "hotkeyNotSet": MessageLookupByLibrary.simpleMessage("Не задано"),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage(
      "Не зарегистрировано: сочетание может быть занято другим приложением",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("часов"),
    "hoursAgo": m45,
    "hoursAgoShort": m46,
    "hoursCount": m47,
    "http2": MessageLookupByLibrary.simpleMessage("HTTP/2"),
    "httpBodyNotKept": MessageLookupByLibrary.simpleMessage(
      "Не записано: не хватало памяти.",
    ),
    "httpBodyProtobufGuess": MessageLookupByLibrary.simpleMessage(
      "Прочитано как Protobuf без схемы: только номера полей, типы предполагаемые.",
    ),
    "httpBodyTruncated": MessageLookupByLibrary.simpleMessage(
      "Записано только начало тела.",
    ),
    "httpBodyUndecoded": m48,
    "httpCapture": MessageLookupByLibrary.simpleMessage("Захват HTTP"),
    "httpCaptureDesc": MessageLookupByLibrary.simpleMessage(
      "Записывает запросы к хостам из списка имён хостов; их можно посмотреть в сведениях о соединении. Записи хранятся только в памяти.",
    ),
    "httpCaptureLimit": MessageLookupByLibrary.simpleMessage(
      "Максимум записей",
    ),
    "httpCaptureLimitDesc": m49,
    "httpCaptureNoHosts": MessageLookupByLibrary.simpleMessage(
      "Хосты не указаны, поэтому ничего не записывается. Добавьте их в поле «Имя хоста» на странице MITM или из сведений о соединении.",
    ),
    "httpCaptureOff": MessageLookupByLibrary.simpleMessage("Захват выключен"),
    "httpExportPrivate": MessageLookupByLibrary.simpleMessage(
      "Запрос может содержать cookie, токены, пароли и данные форм. Проверьте, что и кому вы передаёте.",
    ),
    "httpExportPrivateTitle": MessageLookupByLibrary.simpleMessage(
      "Содержит личные данные",
    ),
    "httpRequestCleared": MessageLookupByLibrary.simpleMessage(
      "Запись этого запроса удалена",
    ),
    "httpRequests": MessageLookupByLibrary.simpleMessage("HTTP-запросы"),
    "httpRequestsMissing": MessageLookupByLibrary.simpleMessage(
      "Запросы, отправленные до включения захвата или уже удалённые, не показаны.",
    ),
    "httpsDecryption": MessageLookupByLibrary.simpleMessage(
      "Расшифровка HTTPS",
    ),
    "hue": MessageLookupByLibrary.simpleMessage("Оттенок"),
    "icon": MessageLookupByLibrary.simpleMessage("Значок"),
    "iconRecords": MessageLookupByLibrary.simpleMessage("История значков"),
    "iconSets": MessageLookupByLibrary.simpleMessage("Наборы значков"),
    "iconSetsEmptyTip": MessageLookupByLibrary.simpleMessage(
      "Наборов значков пока нет. Добавьте их в разделе «Ресурсы пользовательских профилей → Наборы значков»",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Стиль значков"),
    "iconStyleFilled": MessageLookupByLibrary.simpleMessage("С подложкой"),
    "iconStyleHidden": MessageLookupByLibrary.simpleMessage("Скрыто"),
    "iconStylePlain": MessageLookupByLibrary.simpleMessage("Без подложки"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("URL значка"),
    "ignoreBatteryOptimization": MessageLookupByLibrary.simpleMessage(
      "Игнорировать оптимизацию батареи",
    ),
    "import": MessageLookupByLibrary.simpleMessage("Импорт"),
    "importConfigInvalid": MessageLookupByLibrary.simpleMessage(
      "Этот файл не является конфигурацией, которую можно импортировать",
    ),
    "importConfigReplaceTip": MessageLookupByLibrary.simpleMessage(
      "Импорт заменит текущие группы прокси, правила и настройки этого профиля",
    ),
    "importFile": MessageLookupByLibrary.simpleMessage("Импорт из файла"),
    "importFromLink": MessageLookupByLibrary.simpleMessage("Импорт по ссылке"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Импорт из URL"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Импорт по URL"),
    "inProgress": MessageLookupByLibrary.simpleMessage("Выполняется"),
    "inbound": MessageLookupByLibrary.simpleMessage("Входящие"),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage(
      "Включить все прокси",
    ),
    "includeAllProxiesTip": MessageLookupByLibrary.simpleMessage(
      "Подключает все прокси вне групп; ниже можно добавить дополнительные группы прокси",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Включить всех провайдеров прокси",
    ),
    "includeAllProxyProvidersTip": MessageLookupByLibrary.simpleMessage(
      "При включении группа берёт всех провайдеров прокси этого профиля: собственных провайдеров подписки, а также профили и прокси-провайдеры приложения, которые использует любая группа прокси",
    ),
    "includeInterface": MessageLookupByLibrary.simpleMessage(
      "Включённые интерфейсы",
    ),
    "includeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "Через TUN идёт только трафик с включённых интерфейсов, а исключённые интерфейсы больше не действуют.",
    ),
    "includeUid": MessageLookupByLibrary.simpleMessage(
      "Включённые ID пользователей",
    ),
    "includeUidDesc": MessageLookupByLibrary.simpleMessage(
      "Через TUN идёт только трафик процессов включённых ID пользователей.",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Бессрочно"),
    "init": MessageLookupByLibrary.simpleMessage("Инициализация"),
    "initFailed": MessageLookupByLibrary.simpleMessage("Не удалось запустить"),
    "initFailedTip": MessageLookupByLibrary.simpleMessage(
      "При запуске FlClash произошла ошибка, и работа не может быть продолжена. Скопируйте подробности, чтобы сообщить о проблеме. Если ошибка повторяется, очистка данных обычно позволяет снова запустить приложение.",
    ),
    "initiator": MessageLookupByLibrary.simpleMessage("Инициатор"),
    "initiatorShort": MessageLookupByLibrary.simpleMessage("Источник"),
    "inputProxyGroupName": MessageLookupByLibrary.simpleMessage(
      "Введите название группы прокси",
    ),
    "inputRuleContent": MessageLookupByLibrary.simpleMessage(
      "Введите содержимое правила",
    ),
    "installCertificate": MessageLookupByLibrary.simpleMessage(
      "Установить в систему",
    ),
    "installCertificateSuccess": MessageLookupByLibrary.simpleMessage(
      "Сертификат установлен",
    ),
    "installUpdate": MessageLookupByLibrary.simpleMessage(
      "Установить обновление",
    ),
    "installedAppsPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "Разрешение на список приложений отклонено, поэтому установленные приложения недоступны. Предоставьте его вручную в системных настройках.",
    ),
    "installedAppsPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Эта система не выдаёт список установленных приложений без разрешения. Предоставьте его, чтобы настроить прокси для отдельных приложений.",
    ),
    "installedAppsPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется разрешение на список приложений",
    ),
    "installedFonts": MessageLookupByLibrary.simpleMessage(
      "Установленные шрифты",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage("Умный выбор"),
    "interfaceName": MessageLookupByLibrary.simpleMessage("Имя интерфейса"),
    "interfaceNameDesc": MessageLookupByLibrary.simpleMessage(
      "Имя интерфейса задаёт сетевой интерфейс для исходящих соединений.",
    ),
    "interfaceNameMode": MessageLookupByLibrary.simpleMessage(
      "Исходящий интерфейс",
    ),
    "interfaceNameModeClear": MessageLookupByLibrary.simpleMessage("Очистить"),
    "interfaceNameModeCustom": MessageLookupByLibrary.simpleMessage("Вручную"),
    "interfaceNameModeFollow": MessageLookupByLibrary.simpleMessage(
      "Как в конфигурации",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Интернет"),
    "interval": MessageLookupByLibrary.simpleMessage("Интервал"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Внутренний IP"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Недопустимый файл резервной копии",
    ),
    "invalidCidrContent": MessageLookupByLibrary.simpleMessage(
      "Введите диапазон IP в формате CIDR, например 192.168.0.0/16",
    ),
    "invalidDscpContent": MessageLookupByLibrary.simpleMessage(
      "Метка DSCP не может превышать 63",
    ),
    "invalidHostContent": MessageLookupByLibrary.simpleMessage(
      "Введите домен или IP-адрес",
    ),
    "invalidIconSet": MessageLookupByLibrary.simpleMessage(
      "Это не набор значков",
    ),
    "invalidLinkTip": MessageLookupByLibrary.simpleMessage(
      "Это не ссылка на подписку и не ссылка на прокси",
    ),
    "invalidListenContent": MessageLookupByLibrary.simpleMessage(
      "Введите адрес и порт, например 0.0.0.0:1053",
    ),
    "invalidNetworkContent": MessageLookupByLibrary.simpleMessage(
      "Поддерживаются только tcp и udp",
    ),
    "invalidOfCount": m50,
    "invalidPolicy": m51,
    "invalidPortRangeContent": MessageLookupByLibrary.simpleMessage(
      "Введите порт или диапазон, например 443 или 8000-9000",
    ),
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "Этот QR-код не содержит ссылку на профиль",
    ),
    "invalidProxy": m52,
    "invalidProxyProvider": m53,
    "invalidRangeContent": MessageLookupByLibrary.simpleMessage(
      "Введите числа или диапазоны, например 80 или 8000-9000, через /",
    ),
    "invalidRuleSet": m54,
    "invalidSubRule": m55,
    "ipAddress": MessageLookupByLibrary.simpleMessage("IP-адрес"),
    "ipAsn": MessageLookupByLibrary.simpleMessage("ASN"),
    "ipFlagAbuser": MessageLookupByLibrary.simpleMessage("Злоупотребления"),
    "ipFlagProxy": MessageLookupByLibrary.simpleMessage("Прокси"),
    "ipFlagTor": MessageLookupByLibrary.simpleMessage("Tor"),
    "ipFlagVpn": MessageLookupByLibrary.simpleMessage("VPN"),
    "ipFlags": MessageLookupByLibrary.simpleMessage("Метки"),
    "ipOrganization": MessageLookupByLibrary.simpleMessage("Организация"),
    "ipQualityFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить тип IP",
    ),
    "ipQualityGood": MessageLookupByLibrary.simpleMessage("Хороший"),
    "ipQualityLevel": MessageLookupByLibrary.simpleMessage("Уровень"),
    "ipQualityNormal": MessageLookupByLibrary.simpleMessage("Обычный"),
    "ipQualityRetry": MessageLookupByLibrary.simpleMessage("Проверить снова"),
    "ipQualityRisky": MessageLookupByLibrary.simpleMessage("Рискованный"),
    "ipQualityShort": MessageLookupByLibrary.simpleMessage("Качество"),
    "ipQualitySource": MessageLookupByLibrary.simpleMessage("Источник ответа"),
    "ipQualitySources": MessageLookupByLibrary.simpleMessage("Источники"),
    "ipSourceIpMismatch": MessageLookupByLibrary.simpleMessage(
      "Другой исходящий IP",
    ),
    "ipSourceNoType": MessageLookupByLibrary.simpleMessage("Тип не определён"),
    "ipSourceRateLimited": MessageLookupByLibrary.simpleMessage(
      "Лимит запросов",
    ),
    "ipType": MessageLookupByLibrary.simpleMessage("Тип"),
    "ipTypeBusiness": MessageLookupByLibrary.simpleMessage("Бизнес"),
    "ipTypeHosting": MessageLookupByLibrary.simpleMessage("Дата-центр"),
    "ipTypeMobile": MessageLookupByLibrary.simpleMessage("Мобильная сеть"),
    "ipTypeResidential": MessageLookupByLibrary.simpleMessage("Домашний"),
    "ipTypeUnknown": MessageLookupByLibrary.simpleMessage("Тип неизвестен"),
    "ipVersion": MessageLookupByLibrary.simpleMessage("Версия IP"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "Трафик IPv6 принимается, только когда IPv6 включён.",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "При включённом IPv6 VPN принимает входящий IPv6.",
    ),
    "ipv6Timeout": MessageLookupByLibrary.simpleMessage("Тайм-аут IPv6 (мс)"),
    "itemsCount": m56,
    "ja": MessageLookupByLibrary.simpleMessage("Японский"),
    "justNow": MessageLookupByLibrary.simpleMessage("Только что"),
    "keepAliveIdle": MessageLookupByLibrary.simpleMessage(
      "Простой TCP keep-alive",
    ),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Интервал TCP keep-alive",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "ko": MessageLookupByLibrary.simpleMessage("Корейский"),
    "label": MessageLookupByLibrary.simpleMessage("Метка"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "large": MessageLookupByLibrary.simpleMessage("Крупный"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("Последнее обновление"),
    "launchInterrupted": MessageLookupByLibrary.simpleMessage(
      "Запуск не завершён",
    ),
    "launchInterruptedTip": MessageLookupByLibrary.simpleMessage(
      "В прошлый раз приложение неожиданно завершилось во время запуска. Автоматическая настройка для этого запуска пропущена; вы можете запустить её вручную.",
    ),
    "layout": MessageLookupByLibrary.simpleMessage("Макет"),
    "light": MessageLookupByLibrary.simpleMessage("Светлая"),
    "lineIssueTip": m57,
    "lineWrap": MessageLookupByLibrary.simpleMessage("Перенос строк"),
    "link": MessageLookupByLibrary.simpleMessage("Ссылка"),
    "linkDesc": MessageLookupByLibrary.simpleMessage(
      "Получить профиль по ссылке на подписку или на прокси",
    ),
    "liquidGlass": MessageLookupByLibrary.simpleMessage("Жидкое стекло"),
    "list": MessageLookupByLibrary.simpleMessage("Список"),
    "listen": MessageLookupByLibrary.simpleMessage("Прослушивание"),
    "listenRoutingMark": MessageLookupByLibrary.simpleMessage(
      "Метка маршрутизации",
    ),
    "listenRoutingMarkDesc": MessageLookupByLibrary.simpleMessage(
      "Метка маршрутизации действует только в Linux.",
    ),
    "liveConnections": MessageLookupByLibrary.simpleMessage(
      "Активные соединения",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка…"),
    "local": MessageLookupByLibrary.simpleMessage("Локально"),
    "localImage": MessageLookupByLibrary.simpleMessage("Локальное изображение"),
    "localNetworkDeniedTip": MessageLookupByLibrary.simpleMessage(
      "Доступ к локальной сети запрещён: используется стек gvisor, локальная сеть недоступна.",
    ),
    "localProxies": MessageLookupByLibrary.simpleMessage("Локальные прокси"),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию",
    ),
    "locationPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию отклонено, поэтому невозможно получить имя текущей сети Wi-Fi. Включите разрешение на геолокацию вручную в системных настройках.",
    ),
    "locationPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "По требованию системы для получения имени сети Wi-Fi необходимо разрешение на геолокацию. На Android выберите «Разрешить всегда», иначе имя сети Wi-Fi нельзя получить, пока приложение в фоне.",
    ),
    "locationPermissionGuide": m58,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется разрешение на геолокацию",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Лог"),
    "logLevel": MessageLookupByLibrary.simpleMessage("Уровень логов"),
    "logcat": MessageLookupByLibrary.simpleMessage("Захват логов"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "При отключении захвата логов раздел логов скрывается.",
    ),
    "logs": MessageLookupByLibrary.simpleMessage("Логи"),
    "logsAndDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Логи и диагностика",
    ),
    "logsTest": MessageLookupByLibrary.simpleMessage("Тест логов"),
    "loopback": MessageLookupByLibrary.simpleMessage(
      "Снятие ограничения loopback для UWP",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Свободный"),
    "mapLocal": MessageLookupByLibrary.simpleMessage("Локальная подмена"),
    "matchCase": MessageLookupByLibrary.simpleMessage("Учитывать регистр"),
    "matchSourceIp": MessageLookupByLibrary.simpleMessage(
      "Сопоставлять IP источника",
    ),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchedRules": MessageLookupByLibrary.simpleMessage("Сработавшие правила"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage(
      "Макс. число неудач",
    ),
    "maxLengthTip": m59,
    "maximize": MessageLookupByLibrary.simpleMessage("Развернуть"),
    "memoryAppResident": MessageLookupByLibrary.simpleMessage(
      "Резидентная память",
    ),
    "memoryAppShared": MessageLookupByLibrary.simpleMessage(
      "Приложение и общая",
    ),
    "memoryCoreHeapIdle": MessageLookupByLibrary.simpleMessage(
      "Свободная куча",
    ),
    "memoryCoreHeapInuse": MessageLookupByLibrary.simpleMessage(
      "Используемая куча",
    ),
    "memoryCoreNotRunning": MessageLookupByLibrary.simpleMessage(
      "Ядро не запущено",
    ),
    "memoryCoreRuntime": MessageLookupByLibrary.simpleMessage(
      "Накладные расходы среды",
    ),
    "memoryCoreStack": MessageLookupByLibrary.simpleMessage("Стеки горутин"),
    "memoryEstimateDesc": MessageLookupByLibrary.simpleMessage(
      "Оценка по резидентной памяти процессов; может отличаться от данных системы.",
    ),
    "memoryEstimateSharedDesc": MessageLookupByLibrary.simpleMessage(
      "Ядро работает в процессе приложения. Его доля оценивается по статистике среды выполнения, остальное относится к приложению и общей памяти.",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Память"),
    "memoryInfoDesc": MessageLookupByLibrary.simpleMessage(
      "Память приложения и ядра",
    ),
    "memoryReleased": MessageLookupByLibrary.simpleMessage(
      "Память освобождена",
    ),
    "memoryReleasedSize": m60,
    "messageTest": MessageLookupByLibrary.simpleMessage("Тест сообщения"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("Это сообщение."),
    "method": MessageLookupByLibrary.simpleMessage("Метод"),
    "min": MessageLookupByLibrary.simpleMessage("Минимальный"),
    "minimize": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Сворачивать при выходе",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("минут"),
    "minutesAgo": m61,
    "minutesAgoShort": m62,
    "mitm": MessageLookupByLibrary.simpleMessage("MITM"),
    "mitmAddLocalFile": MessageLookupByLibrary.simpleMessage(
      "Добавить локальный файл",
    ),
    "mitmAddMapLocalRule": MessageLookupByLibrary.simpleMessage(
      "Добавить правило локальной подмены",
    ),
    "mitmAddRejectRule": MessageLookupByLibrary.simpleMessage(
      "Добавить правило блокировки",
    ),
    "mitmAttachments": MessageLookupByLibrary.simpleMessage("Вложения"),
    "mitmAttachmentsDesc": MessageLookupByLibrary.simpleMessage(
      "Строки ссылаются на вложения по имени файла, например script-path=a.js.",
    ),
    "mitmCertificateAndroidReadyTip": MessageLookupByLibrary.simpleMessage(
      "Расшифровываются только приложения, доверяющие пользовательским сертификатам, в основном браузеры.",
    ),
    "mitmCertificateExportTip": MessageLookupByLibrary.simpleMessage(
      "Экспортируйте его и добавьте в доверенные на устройствах, трафик которых нужно расшифровывать.",
    ),
    "mitmCertificateLinuxTip": MessageLookupByLibrary.simpleMessage(
      "В браузеры из Flatpak экспортированный сертификат нужно импортировать вручную.",
    ),
    "mitmCertificateSavedTip": m63,
    "mitmCertutilMissing": m64,
    "mitmClientRefusedCertificate": MessageLookupByLibrary.simpleMessage(
      "Клиент отклонил сертификат. Установите сертификат или исключите этот хост, если приложение закрепляет свой сертификат.",
    ),
    "mitmDecryptHost": MessageLookupByLibrary.simpleMessage(
      "Расшифровывать этот хост",
    ),
    "mitmDecryptHostTip": m65,
    "mitmEnableTip": MessageLookupByLibrary.simpleMessage(
      "FlClash сможет читать всё, что отправляется на расшифровываемые узлы, включая cookie и пароли. Включайте только для узлов, которые нужно перезаписывать.",
    ),
    "mitmExcludeHost": MessageLookupByLibrary.simpleMessage(
      "Исключить из расшифровки",
    ),
    "mitmExcludeHostTip": m66,
    "mitmFileTooLarge": m67,
    "mitmHostnameDesc": MessageLookupByLibrary.simpleMessage(
      "Префикс - исключает хост; действует первое совпадение.",
    ),
    "mitmIgnoredLines": MessageLookupByLibrary.simpleMessage(
      "Пропущенные строки",
    ),
    "mitmInstallSystemCaTip": MessageLookupByLibrary.simpleMessage(
      "Обнаружен root: сертификат будет добавлен в доверенные сертификаты системы как модуль Magisk, KernelSU или APatch «FlClash MITM CA». После этого ему будут доверять все приложения устройства, а любой, у кого есть его закрытый ключ, сможет расшифровать HTTPS-трафик устройства. Чтобы отменить это, создайте сертификат заново или удалите модуль в root-менеджере и перезагрузите устройство. Если в root отказано, сертификат будет установлен как пользовательский.",
    ),
    "mitmInstallUserCaTip": MessageLookupByLibrary.simpleMessage(
      "Root не обнаружен: сертификат можно установить только как пользовательский. Расшифровываются только приложения, доверяющие пользовательским сертификатам, в основном браузеры; остальные не смогут подключиться к указанным узлам, поэтому не указывайте их узлы. Начиная с Android 11 установку нужно завершить вручную в настройках системы.",
    ),
    "mitmMissingStores": m68,
    "mitmModule": MessageLookupByLibrary.simpleMessage("Модуль"),
    "mitmModuleInvalid": MessageLookupByLibrary.simpleMessage(
      "Это не модуль Surge, не плагин Loon, не фрагмент Quantumult X и не переопределение Stash",
    ),
    "mitmModuleRulesDesc": MessageLookupByLibrary.simpleMessage(
      "Правила маршрутизации идут перед правилами профиля.",
    ),
    "mitmModuleScriptsChanged": m69,
    "mitmModuleSystemTip": m70,
    "mitmModules": MessageLookupByLibrary.simpleMessage("Модули"),
    "mitmNewModule": MessageLookupByLibrary.simpleMessage("Новый модуль"),
    "mitmOldCertificateLeftTip": m71,
    "mitmOldSystemCertificateLeftTip": m72,
    "mitmRemoveOldCertificateTip": m73,
    "mitmRootPendingReboot": MessageLookupByLibrary.simpleMessage(
      "Сертификат начнёт действовать после перезагрузки устройства.",
    ),
    "mitmRootUntilReboot": MessageLookupByLibrary.simpleMessage(
      "Не найден Magisk, KernelSU или APatch, чтобы сохранить сертификат. После перезагрузки устройства установите его снова.",
    ),
    "mitmRoutingRules": MessageLookupByLibrary.simpleMessage(
      "Правила маршрутизации",
    ),
    "mitmRuleCopiedForStash": MessageLookupByLibrary.simpleMessage(
      "Этот модуль — переопределение Stash, поэтому правило скопировано, добавьте его вручную.",
    ),
    "mitmRunScript": MessageLookupByLibrary.simpleMessage("Запустить сейчас"),
    "mitmScriptNoOutput": MessageLookupByLibrary.simpleMessage(
      "Скрипт завершился без вывода",
    ),
    "mitmScriptRisk": MessageLookupByLibrary.simpleMessage(
      "Его скрипты читают и меняют трафик подходящих хостов, включая файлы cookie и токены, и могут сами отправлять запросы. Включайте, только если доверяете источнику.",
    ),
    "mitmScriptRiskTitle": MessageLookupByLibrary.simpleMessage(
      "Запускать скрипты этого модуля?",
    ),
    "mitmSkipConditional": MessageLookupByLibrary.simpleMessage(
      "Условные перезаписи не поддерживаются",
    ),
    "mitmSkipDisabled": MessageLookupByLibrary.simpleMessage(
      "Отключено аргументом",
    ),
    "mitmSkipEvent": MessageLookupByLibrary.simpleMessage(
      "Это событие не поддерживается",
    ),
    "mitmSkipJq": MessageLookupByLibrary.simpleMessage(
      "Перезаписи jq не поддерживаются",
    ),
    "mitmSkipJsonBody": MessageLookupByLibrary.simpleMessage(
      "Перезаписи тела JSON не поддерживаются",
    ),
    "mitmSkipNotDownloaded": MessageLookupByLibrary.simpleMessage(
      "Его файл ещё не загружен",
    ),
    "mitmSkipPolicy": MessageLookupByLibrary.simpleMessage(
      "Поддерживаются только политики DIRECT и REJECT",
    ),
    "mitmSkipRawHeader": MessageLookupByLibrary.simpleMessage(
      "Перезапись всех заголовков как одного текста не поддерживается",
    ),
    "mitmSkipRelativeData": MessageLookupByLibrary.simpleMessage(
      "Файл из этой строки не прикреплён; укажите URL или прикрепите его",
    ),
    "mitmSkipRule": MessageLookupByLibrary.simpleMessage(
      "Этот тип правила не поддерживается",
    ),
    "mitmSkipScriptType": MessageLookupByLibrary.simpleMessage(
      "Этот тип скриптов не поддерживается",
    ),
    "mitmSkipSection": m74,
    "mitmSkipSetting": MessageLookupByLibrary.simpleMessage(
      "Этот параметр не поддерживается",
    ),
    "mitmSkipUnreadable": MessageLookupByLibrary.simpleMessage(
      "Эту строку не удалось прочитать",
    ),
    "mitmSystemStoreFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось добавить сертификат в доверенные корневые сертификаты системы",
    ),
    "mitmTrustChecking": MessageLookupByLibrary.simpleMessage("Проверка…"),
    "mitmTrustNotInstalled": MessageLookupByLibrary.simpleMessage(
      "Не установлен",
    ),
    "mitmTrustReady": MessageLookupByLibrary.simpleMessage("Доверенный"),
    "mitmTrustUntrusted": MessageLookupByLibrary.simpleMessage(
      "Доверие неполное",
    ),
    "mixedPort": MessageLookupByLibrary.simpleMessage("Смешанный порт"),
    "mode": MessageLookupByLibrary.simpleMessage("Режим"),
    "monochromeIcon": MessageLookupByLibrary.simpleMessage(
      "Монохромный значок",
    ),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "monthsAgo": m75,
    "monthsAgoShort": m76,
    "more": MessageLookupByLibrary.simpleMessage("Ещё"),
    "name": MessageLookupByLibrary.simpleMessage("Название"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "DNS-серверы по умолчанию, например 223.5.5.5, tls://1.1.1.1 или https://dns.google/dns-query.",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Совпавшие домены используют указанный здесь DNS-сервер вместо Nameserver и Fallback.",
    ),
    "navigationBarStyle": MessageLookupByLibrary.simpleMessage("Нижняя панель"),
    "network": MessageLookupByLibrary.simpleMessage("Сеть"),
    "networkAccessDeniedError": m77,
    "networkBadResponseError": m78,
    "networkCancelledError": MessageLookupByLibrary.simpleMessage(
      "Запрос отменён",
    ),
    "networkConnectionError": MessageLookupByLibrary.simpleMessage(
      "Не удалось подключиться к серверу. Проверьте подключение к сети или настройки прокси",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage("Проверка сети"),
    "networkHostLookupError": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить адрес сервера. Проверьте правильность URL и работу DNS",
    ),
    "networkName": MessageLookupByLibrary.simpleMessage("Имя сети"),
    "networkNotFoundError": m79,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "Слишком много запросов (HTTP 429). Подождите немного и повторите попытку",
    ),
    "networkRequestFailed": m80,
    "networkSecret": MessageLookupByLibrary.simpleMessage("Секрет сети"),
    "networkServerError": m81,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Скорость сети"),
    "networkTakeover": MessageLookupByLibrary.simpleMessage("Перехват трафика"),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "Время ожидания запроса истекло. Проверьте сеть или прокси и повторите попытку",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "Не удалось установить защищённое соединение. Сертификат сервера может быть недействителен, или соединение перехватывается",
    ),
    "networkType": MessageLookupByLibrary.simpleMessage("Тип сети"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Нейтральная"),
    "nextMatch": MessageLookupByLibrary.simpleMessage("Следующее совпадение"),
    "no": MessageLookupByLibrary.simpleMessage("Нет"),
    "noData": MessageLookupByLibrary.simpleMessage("Нет данных"),
    "noInfo": MessageLookupByLibrary.simpleMessage("Нет информации"),
    "noLongerRemind": MessageLookupByLibrary.simpleMessage(
      "Больше не напоминать",
    ),
    "noNetwork": MessageLookupByLibrary.simpleMessage("Нет сети"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("Приложения без сети"),
    "noRecords": MessageLookupByLibrary.simpleMessage("Записей пока нет"),
    "noResolve": MessageLookupByLibrary.simpleMessage("Не разрешать IP"),
    "noResolveHostname": MessageLookupByLibrary.simpleMessage(
      "Не разрешать имя хоста",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "Ничего не найдено",
    ),
    "nodes": MessageLookupByLibrary.simpleMessage("Узлы"),
    "nonTextProviderFile": MessageLookupByLibrary.simpleMessage(
      "Этот внешний ресурс не является текстовым файлом",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Нет"),
    "notRunning": MessageLookupByLibrary.simpleMessage("Не запущено"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Текущую группу прокси нельзя выбрать",
    ),
    "ntpInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал синхронизации (минуты)",
    ),
    "ntpStatusDesc": MessageLookupByLibrary.simpleMessage(
      "NTP берёт время с NTP-сервера, а не из системных часов.",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Добавьте профиль, чтобы начать",
    ),
    "nullTip": m82,
    "numberRangeTip": m83,
    "numberTip": m84,
    "obfs": MessageLookupByLibrary.simpleMessage("Обфускация"),
    "obfsHost": MessageLookupByLibrary.simpleMessage("Хост обфускации"),
    "obfsMode": MessageLookupByLibrary.simpleMessage("Режим обфускации"),
    "obfsParam": MessageLookupByLibrary.simpleMessage("Параметр обфускации"),
    "obfsPassword": MessageLookupByLibrary.simpleMessage("Пароль обфускации"),
    "onDemand": MessageLookupByLibrary.simpleMessage("По условию"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "«По условию» приостанавливает прокси в исключённых сетях Wi-Fi.",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Учитывать только трафик прокси",
    ),
    "openSettings": MessageLookupByLibrary.simpleMessage("Открыть настройки"),
    "optional": MessageLookupByLibrary.simpleMessage("Необязательно"),
    "options": MessageLookupByLibrary.simpleMessage("Опции"),
    "originalUrl": MessageLookupByLibrary.simpleMessage("Исходный URL"),
    "other": MessageLookupByLibrary.simpleMessage("Другое"),
    "otherContributors": MessageLookupByLibrary.simpleMessage(
      "Другие участники",
    ),
    "outbound": MessageLookupByLibrary.simpleMessage("Исходящие"),
    "outboundExit": MessageLookupByLibrary.simpleMessage("Выход"),
    "outboundIp": MessageLookupByLibrary.simpleMessage("Исходящий IP"),
    "outboundLocation": MessageLookupByLibrary.simpleMessage(
      "Расположение выхода",
    ),
    "outboundLocationApproximate": MessageLookupByLibrary.simpleMessage(
      "Метка приблизительная по коду страны. Точный город появится, когда зонд вернёт координаты.",
    ),
    "outboundLocationCoordinates": MessageLookupByLibrary.simpleMessage(
      "Координаты",
    ),
    "outboundLocationCountry": MessageLookupByLibrary.simpleMessage("Страна"),
    "outboundLocationLocality": MessageLookupByLibrary.simpleMessage(
      "Населённый пункт",
    ),
    "outboundLocationUnknown": MessageLookupByLibrary.simpleMessage(
      "Пока нет точки на карте для этого выхода",
    ),
    "outboundMode": MessageLookupByLibrary.simpleMessage(
      "Режим исходящего трафика",
    ),
    "override": MessageLookupByLibrary.simpleMessage("Переопределение"),
    "overrideDestination": MessageLookupByLibrary.simpleMessage(
      "Подменять адрес назначения",
    ),
    "overrideDestinationDesc": MessageLookupByLibrary.simpleMessage(
      "«Подменять адрес назначения» подключается к обнаруженному домену вместо исходного адреса.",
    ),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Переопределить DNS"),
    "overrideEntries": MessageLookupByLibrary.simpleMessage(
      "Переопределяемые параметры",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage(
      "Режим переопределения",
    ),
    "overrideNtp": MessageLookupByLibrary.simpleMessage("Переопределить NTP"),
    "overrideScript": MessageLookupByLibrary.simpleMessage(
      "Скрипт переопределения",
    ),
    "overview": MessageLookupByLibrary.simpleMessage("Обзор"),
    "overwriteIssueCoreRejected": m85,
    "overwriteIssueDuplicateName": m86,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "Имя не задано",
    ),
    "overwriteIssueGroupLoop": m87,
    "overwriteIssueMissingProviders": m88,
    "overwriteIssueMissingProxies": m89,
    "overwriteIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "Не выбраны ни прокси, ни провайдеры прокси, поэтому ядро отклонит эту группу",
    ),
    "overwriteIssueReservedName": m90,
    "overwriteIssueSubscriptionGroupMissingProxies": m91,
    "overwriteIssuesSummary": m92,
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage(
      "Пользовательский",
    ),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Пользовательский режим: полная настройка прокси, групп прокси и правил",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("Палитра"),
    "parsePureIp": MessageLookupByLibrary.simpleMessage("Разбирать чистые IP"),
    "parsePureIpDesc": MessageLookupByLibrary.simpleMessage(
      "«Разбирать чистые IP» анализирует соединения, у которых есть только IP-адрес.",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "paste": MessageLookupByLibrary.simpleMessage("Вставить"),
    "peers": MessageLookupByLibrary.simpleMessage("Пиры"),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage("Выбрать из галереи"),
    "pinWindow": MessageLookupByLibrary.simpleMessage(
      "Закрепить поверх всех окон",
    ),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Привяжите WebDAV",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Введите название скрипта",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Загрузите корректный QR-код",
    ),
    "plugin": MessageLookupByLibrary.simpleMessage("Плагин"),
    "pluginCipher": MessageLookupByLibrary.simpleMessage("Шифр плагина"),
    "pluginHost": MessageLookupByLibrary.simpleMessage("Хост плагина"),
    "pluginMode": MessageLookupByLibrary.simpleMessage("Режим плагина"),
    "pluginPassword": MessageLookupByLibrary.simpleMessage("Пароль плагина"),
    "pluginPath": MessageLookupByLibrary.simpleMessage("Путь плагина"),
    "pluginUsername": MessageLookupByLibrary.simpleMessage(
      "Имя пользователя плагина",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Порт"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Введите другой порт",
    ),
    "portHopping": MessageLookupByLibrary.simpleMessage("Перескок портов"),
    "portTip": m93,
    "portValue": m94,
    "ports": MessageLookupByLibrary.simpleMessage("Порты"),
    "preSharedKey": MessageLookupByLibrary.simpleMessage("Общий ключ"),
    "preferred": MessageLookupByLibrary.simpleMessage("Предпочтительный"),
    "prerequisites": MessageLookupByLibrary.simpleMessage(
      "Предварительные условия",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Нажмите сочетание клавиш",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Предпросмотр"),
    "previousMatch": MessageLookupByLibrary.simpleMessage(
      "Предыдущее совпадение",
    ),
    "privateKey": MessageLookupByLibrary.simpleMessage("Закрытый ключ"),
    "privateKeyPassphrase": MessageLookupByLibrary.simpleMessage(
      "Пароль закрытого ключа",
    ),
    "process": MessageLookupByLibrary.simpleMessage("Процесс"),
    "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("Введите корректный интервал"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage("Введите интервал автообновления"),
    "profileDaysLeft": m95,
    "profileExpiresIn": m96,
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "Профиль изменён. Отключить автообновление?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Введите название профиля",
    ),
    "profileSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только для этого профиля; не добавленные параметры используют значения по умолчанию.",
    ),
    "profileTunSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только для этого профиля и имеет приоритет над переопределяемыми параметрами TUN в настройках сети.",
    ),
    "profileUpdatedAt": m97,
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Введите корректный URL профиля",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Введите URL профиля",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Профили"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Сортировка профилей"),
    "project": MessageLookupByLibrary.simpleMessage("Проект"),
    "protocol": MessageLookupByLibrary.simpleMessage("Протокол"),
    "protocolParam": MessageLookupByLibrary.simpleMessage("Параметр протокола"),
    "protocolVersion": MessageLookupByLibrary.simpleMessage("Версия протокола"),
    "providerInUse": m98,
    "providerRenameShadowed": m99,
    "providerSourceSubscription": MessageLookupByLibrary.simpleMessage(
      "Подписка",
    ),
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "Поддерживаются только удалённые ресурсы",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("Внешние ресурсы"),
    "proxies": MessageLookupByLibrary.simpleMessage("Прокси"),
    "proxiesCount": m100,
    "proxiesEmpty": MessageLookupByLibrary.simpleMessage("Список прокси пуст"),
    "proxiesProfileLabel": m101,
    "proxiesRemovedTip": m102,
    "proxiesReplacedTip": m103,
    "proxyChains": MessageLookupByLibrary.simpleMessage("Цепочка прокси"),
    "proxyDefinition": MessageLookupByLibrary.simpleMessage(
      "Полная конфигурация",
    ),
    "proxyDefinitionNotMap": MessageLookupByLibrary.simpleMessage(
      "Конфигурация должна быть YAML-словарём с полями name и type",
    ),
    "proxyFilter": MessageLookupByLibrary.simpleMessage("Фильтр узлов"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Группа прокси"),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage(
      "Группа прокси пуста",
    ),
    "proxyGroupInUse": m104,
    "proxyGroupNameDuplicate": MessageLookupByLibrary.simpleMessage(
      "Название группы прокси уже используется",
    ),
    "proxyGroupsAfterStart": MessageLookupByLibrary.simpleMessage(
      "Группы появятся здесь после запуска ядра",
    ),
    "proxyGroupsCount": m105,
    "proxyNode": MessageLookupByLibrary.simpleMessage("Прокси-узел"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Провайдеры прокси"),
    "proxyProvidersEmpty": MessageLookupByLibrary.simpleMessage(
      "Список провайдеров прокси пуст",
    ),
    "proxyProvidersNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Провайдеры прокси не могут быть пустыми",
    ),
    "proxyServerNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Используется только для разрешения имён прокси-серверов.",
    ),
    "proxyServerNameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Совпавшие имена прокси-серверов используют указанный здесь DNS-сервер вместо Proxy Server Nameserver.",
    ),
    "proxyType": MessageLookupByLibrary.simpleMessage("Тип прокси"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Очистить кэш"),
    "publicKey": MessageLookupByLibrary.simpleMessage("Открытый ключ"),
    "pureBlack": MessageLookupByLibrary.simpleMessage("Чисто чёрный"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чисто чёрный режим"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Сканируйте QR-код, чтобы получить профиль",
    ),
    "qrcodeTooLongTip": MessageLookupByLibrary.simpleMessage(
      "Ссылка слишком длинная для QR-кода. Используйте «Копировать ссылку».",
    ),
    "quickActions": MessageLookupByLibrary.simpleMessage("Быстрые действия"),
    "quickAdd": MessageLookupByLibrary.simpleMessage("Быстрое добавление"),
    "quickEdit": MessageLookupByLibrary.simpleMessage("Быстрое редактирование"),
    "quickFill": MessageLookupByLibrary.simpleMessage("Быстрое заполнение"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Радуга"),
    "recentRequests": MessageLookupByLibrary.simpleMessage("Последние запросы"),
    "recommendedIcons": MessageLookupByLibrary.simpleMessage("Рекомендуемые"),
    "recordType": MessageLookupByLibrary.simpleMessage("Тип записи"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Порт Redir"),
    "redo": MessageLookupByLibrary.simpleMessage("Повторить"),
    "regenerateCertificate": MessageLookupByLibrary.simpleMessage(
      "Пересоздать сертификат",
    ),
    "regenerateCertificateTip": MessageLookupByLibrary.simpleMessage(
      "Новый сертификат заменит текущий; FlClash по возможности удалит текущий из доверенных корневых сертификатов этого устройства. На каждое другое устройство, доверяющее текущему, нужно установить новый.",
    ),
    "regex": MessageLookupByLibrary.simpleMessage("Регулярное выражение"),
    "releaseMemory": MessageLookupByLibrary.simpleMessage("Освободить память"),
    "releaseMemoryFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось освободить память",
    ),
    "remote": MessageLookupByLibrary.simpleMessage("Удалённо"),
    "remoteDestination": MessageLookupByLibrary.simpleMessage(
      "Удалённое назначение",
    ),
    "remoteDnsResolve": MessageLookupByLibrary.simpleMessage(
      "Удалённое разрешение DNS",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Убрать"),
    "rename": MessageLookupByLibrary.simpleMessage("Переименовать"),
    "replace": MessageLookupByLibrary.simpleMessage("Заменить"),
    "replaceAll": MessageLookupByLibrary.simpleMessage("Заменить все"),
    "request": MessageLookupByLibrary.simpleMessage("Запрос"),
    "requestBody": MessageLookupByLibrary.simpleMessage("Тело запроса"),
    "requestHeaders": MessageLookupByLibrary.simpleMessage("Заголовки запроса"),
    "requests": MessageLookupByLibrary.simpleMessage("Запросы"),
    "requestsAndUpdates": MessageLookupByLibrary.simpleMessage(
      "Запросы и обновления",
    ),
    "required": MessageLookupByLibrary.simpleMessage("Обязательно"),
    "reset": MessageLookupByLibrary.simpleMessage("Сброс"),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "На этой странице есть изменения. Вы уверены, что хотите выполнить сброс?",
    ),
    "resetTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите выполнить сброс?",
    ),
    "resourceUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления",
    ),
    "resourceUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "Интервал автообновления должен быть больше 0",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Ресурсы"),
    "respectRules": MessageLookupByLibrary.simpleMessage("Соблюдать правила"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "«Соблюдать правила» направляет DNS-соединения по правилам; нужен Proxy Server Nameserver.",
    ),
    "response": MessageLookupByLibrary.simpleMessage("Ответ"),
    "responseBody": MessageLookupByLibrary.simpleMessage("Тело ответа"),
    "responseCode": MessageLookupByLibrary.simpleMessage("Код ответа"),
    "responseHeaders": MessageLookupByLibrary.simpleMessage("Заголовки ответа"),
    "restart": MessageLookupByLibrary.simpleMessage("Перезапустить"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите перезапустить ядро?",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Восстановить"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage(
      "Восстановить все данные",
    ),
    "restoreAutoSelect": MessageLookupByLibrary.simpleMessage("Вернуть авто"),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage(
      "Восстановить только профили",
    ),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage(
      "Стратегия восстановления",
    ),
    "restoreStrategyCompatible": MessageLookupByLibrary.simpleMessage(
      "Совместимость",
    ),
    "restoreStrategyOverride": MessageLookupByLibrary.simpleMessage(
      "Перезапись",
    ),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Восстановление выполнено",
    ),
    "result": MessageLookupByLibrary.simpleMessage("Результат"),
    "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "root": MessageLookupByLibrary.simpleMessage("Root"),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Адреса маршрутов"),
    "routeExcludeAddress": MessageLookupByLibrary.simpleMessage(
      "Исключённые адреса маршрутов",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Режим маршрутизации"),
    "routeModeBypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Обходить частные адреса",
    ),
    "routeModeConfig": MessageLookupByLibrary.simpleMessage(
      "Использовать конфигурацию",
    ),
    "routingMark": MessageLookupByLibrary.simpleMessage("Метка маршрутизации"),
    "ru": MessageLookupByLibrary.simpleMessage("Русский"),
    "rule": MessageLookupByLibrary.simpleMessage("Правило"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage(
      "Логическое правило AND",
    ),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить полный домен",
    ),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ключевое слово в домене",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по регулярному выражению домена",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить суффикс домена",
    ),
    "ruleActionDomainWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставление по маске; поддерживаются только * и ?",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить метку DSCP (только для входящих tproxy UDP)",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон портов назначения",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить код страны IP-адреса",
    ),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить домены из Geosite",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить имя входящего подключения",
    ),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить входящий порт",
    ),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить тип входящего подключения",
    ),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить имя пользователя входящего подключения; несколько имён разделяются /",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ASN, которой принадлежит IP",
    ),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон IP-адресов; IP-CIDR6 — просто псевдоним",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон IP-адресов",
    ),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон суффиксов IP",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставляет все запросы, условия не нужны",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить TCP или UDP",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage(
      "Логическое правило NOT",
    ),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage(
      "Логическое правило OR",
    ),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по имени процесса; на Android соответствует имени пакета",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по регулярному выражению имени процесса; на Android соответствует имени пакета",
    ),
    "ruleActionProcessNameWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по маске имени процесса; поддерживаются только * и ?",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по полному пути процесса",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по регулярному выражению пути процесса",
    ),
    "ruleActionProcessPathWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по маске пути процесса; поддерживаются только * и ?",
    ),
    "ruleActionRematchNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить имя повторного сопоставления; несколько имён разделяются /",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "Ссылка на набор правил; требуется настроить rule-providers",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить код страны IP источника",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ASN IP источника",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон IP-адресов источника",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон суффиксов IP источника",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон портов источника",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "Переход к подправилу; обратите внимание на скобки",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить Linux USER ID",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("Правило пусто"),
    "ruleListInvalid": MessageLookupByLibrary.simpleMessage(
      "Правила должны быть YAML-списком, по одному правилу в элементе, например - DOMAIN,example.com,DIRECT",
    ),
    "ruleName": MessageLookupByLibrary.simpleMessage("Название правила"),
    "rulePresetBittorrentDirect": MessageLookupByLibrary.simpleMessage(
      "BitTorrent напрямую",
    ),
    "rulePresetBlockDot": MessageLookupByLibrary.simpleMessage(
      "Блокировать DNS over TLS",
    ),
    "rulePresetBlockLoopback": MessageLookupByLibrary.simpleMessage(
      "Защита от петли прокси",
    ),
    "rulePresetBlockQuic": MessageLookupByLibrary.simpleMessage(
      "Блокировать QUIC",
    ),
    "rulePresetBlockStun": MessageLookupByLibrary.simpleMessage(
      "Блокировать STUN",
    ),
    "rulePresetLanDirect": MessageLookupByLibrary.simpleMessage(
      "Локальная сеть напрямую",
    ),
    "rulePresetSystemServicesDirect": MessageLookupByLibrary.simpleMessage(
      "Apple и Microsoft напрямую",
    ),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Провайдеры правил"),
    "ruleSet": MessageLookupByLibrary.simpleMessage("Набор правил"),
    "ruleSetEmptyTip": MessageLookupByLibrary.simpleMessage(
      "В наборе правил нет пригодных записей",
    ),
    "ruleSetInvalidTip": MessageLookupByLibrary.simpleMessage(
      "Не удаётся прочитать этот файл mrs",
    ),
    "ruleSetMixedTip": MessageLookupByLibrary.simpleMessage(
      "Набор правил смешивает домены и диапазоны IP, поэтому его тип не определить",
    ),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель правила"),
    "ruleTextInvalid": MessageLookupByLibrary.simpleMessage(
      "Правило должно начинаться с поддерживаемого типа, например DOMAIN,example.com,DIRECT",
    ),
    "rules": MessageLookupByLibrary.simpleMessage("Правила"),
    "rulesCount": m106,
    "runTime": MessageLookupByLibrary.simpleMessage("Время работы"),
    "running": MessageLookupByLibrary.simpleMessage("Работает"),
    "runtimeConfig": MessageLookupByLibrary.simpleMessage(
      "Конфигурация выполнения",
    ),
    "safeMode": MessageLookupByLibrary.simpleMessage("Безопасный режим"),
    "safeModeAppTitle": m107,
    "saturation": MessageLookupByLibrary.simpleMessage("Насыщенность"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Сохранить изменения?"),
    "script": MessageLookupByLibrary.simpleMessage("Скрипт"),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Режим скрипта: переписывает весь профиль скриптом расширения",
    ),
    "scrollToSelected": MessageLookupByLibrary.simpleMessage(
      "Прокрутить к выбранному",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "seconds": MessageLookupByLibrary.simpleMessage("секунд"),
    "secondsCount": m108,
    "secretKey": MessageLookupByLibrary.simpleMessage("Ключ"),
    "sectionsInEffect": m109,
    "select": MessageLookupByLibrary.simpleMessage("Выбрать"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Выбрать всё"),
    "selectProxies": MessageLookupByLibrary.simpleMessage("Выбрать прокси"),
    "selectProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Выбрать провайдеров прокси",
    ),
    "selectRuleSet": MessageLookupByLibrary.simpleMessage(
      "Выберите набор правил",
    ),
    "selectSplitStrategy": MessageLookupByLibrary.simpleMessage(
      "Выберите стратегию распределения",
    ),
    "selectSubRule": MessageLookupByLibrary.simpleMessage(
      "Выберите подправило",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Выбрано"),
    "selectedCountTitle": m110,
    "send": MessageLookupByLibrary.simpleMessage("Отправить"),
    "sendFromPhone": MessageLookupByLibrary.simpleMessage(
      "Отправить с телефона",
    ),
    "sendFromPhoneConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Импортировать ссылку с телефона?",
    ),
    "sendFromPhoneNoNetwork": MessageLookupByLibrary.simpleMessage(
      "Это устройство не подключено к локальной сети",
    ),
    "sendFromPhonePageHint": MessageLookupByLibrary.simpleMessage(
      "Ссылка на подписку или ссылка на прокси",
    ),
    "sendFromPhonePageSent": MessageLookupByLibrary.simpleMessage(
      "Отправлено. Подтвердите импорт на другом устройстве.",
    ),
    "sendFromPhonePageTitle": MessageLookupByLibrary.simpleMessage(
      "Отправить ссылку в FlClash",
    ),
    "sendFromPhonePermissionDenied": MessageLookupByLibrary.simpleMessage(
      "Чтобы получить ссылку с телефона, FlClash нужно разрешение «Устройства поблизости» для доступа к локальной сети. Включите его в настройках приложения.",
    ),
    "sendFromPhoneTip": MessageLookupByLibrary.simpleMessage(
      "Отсканируйте код камерой телефона и вставьте ссылку на открывшейся странице. Оба устройства должны быть в одной сети.",
    ),
    "server": MessageLookupByLibrary.simpleMessage("Сервер"),
    "serviceAbnormalCount": m111,
    "serviceAllAvailable": MessageLookupByLibrary.simpleMessage("Все доступны"),
    "serviceAvailable": MessageLookupByLibrary.simpleMessage("Доступен"),
    "serviceBlocked": MessageLookupByLibrary.simpleMessage("Заблокировано"),
    "serviceCheck": MessageLookupByLibrary.simpleMessage("Проверить"),
    "serviceCheckAll": MessageLookupByLibrary.simpleMessage("Проверить все"),
    "serviceCheckedAt": m112,
    "serviceComingSoon": MessageLookupByLibrary.simpleMessage("Скоро появится"),
    "serviceDisallowedIsp": MessageLookupByLibrary.simpleMessage(
      "Недопустимый провайдер",
    ),
    "serviceFailed": MessageLookupByLibrary.simpleMessage("Ошибка проверки"),
    "serviceManage": MessageLookupByLibrary.simpleMessage(
      "Управление сервисами",
    ),
    "serviceOriginalsOnly": MessageLookupByLibrary.simpleMessage(
      "Только оригиналы",
    ),
    "servicePending": MessageLookupByLibrary.simpleMessage("Не проверено"),
    "serviceRestricted": MessageLookupByLibrary.simpleMessage(
      "Доступ ограничен",
    ),
    "serviceShownOnDashboard": MessageLookupByLibrary.simpleMessage(
      "Показан на панели",
    ),
    "serviceStatus": MessageLookupByLibrary.simpleMessage("Состояние сервисов"),
    "serviceUnavailable": MessageLookupByLibrary.simpleMessage("Недоступен"),
    "serviceUnsupportedRegion": MessageLookupByLibrary.simpleMessage(
      "Регион не поддерживается",
    ),
    "settingEntries": MessageLookupByLibrary.simpleMessage("параметры"),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "settingsCount": m113,
    "shareLinkUnreadable": m114,
    "shareLinksInvalid": MessageLookupByLibrary.simpleMessage(
      "Не удалось прочитать прокси из ссылок",
    ),
    "shareQrcodeTip": MessageLookupByLibrary.simpleMessage(
      "Отсканируйте в FlClash на другом устройстве, чтобы импортировать этот профиль.",
    ),
    "show": MessageLookupByLibrary.simpleMessage("Показать"),
    "showAdvanced": MessageLookupByLibrary.simpleMessage(
      "Показать дополнительно",
    ),
    "showLess": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "showMore": MessageLookupByLibrary.simpleMessage("Развернуть"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Кнопка остановки в уведомлении",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("Показать пароль"),
    "shrink": MessageLookupByLibrary.simpleMessage("Компактный"),
    "sidebar": MessageLookupByLibrary.simpleMessage("Боковая панель"),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage(
      "Размытие боковой панели",
    ),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "Размытие фона показывает рабочий стол за окном сквозь боковую панель.",
    ),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("Тихий запуск"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Тихий запуск не показывает окно.",
    ),
    "singleAdd": MessageLookupByLibrary.simpleMessage("По одному"),
    "singleImport": MessageLookupByLibrary.simpleMessage("По одному"),
    "singleShareLinkOnly": MessageLookupByLibrary.simpleMessage(
      "Здесь укажите одну ссылку, несколько можно задать в быстром редактировании списка",
    ),
    "singleValueTip": m115,
    "size": MessageLookupByLibrary.simpleMessage("Размер"),
    "skipCertVerify": MessageLookupByLibrary.simpleMessage(
      "Пропускать проверку сертификата",
    ),
    "skipDomain": MessageLookupByLibrary.simpleMessage("Пропускаемые домены"),
    "skipDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Обнаруженный домен из пропускаемых доменов не используется.",
    ),
    "skipDstAddress": MessageLookupByLibrary.simpleMessage(
      "Пропускаемые адреса назначения",
    ),
    "skipServerCertVerify": MessageLookupByLibrary.simpleMessage(
      "Пропускать проверку сертификата сервера",
    ),
    "skipSrcAddress": MessageLookupByLibrary.simpleMessage(
      "Пропускаемые адреса источника",
    ),
    "slide": MessageLookupByLibrary.simpleMessage("Сдвиг"),
    "sliders": MessageLookupByLibrary.simpleMessage("Ползунки"),
    "sniffProtocols": MessageLookupByLibrary.simpleMessage("Протоколы"),
    "sniffer": MessageLookupByLibrary.simpleMessage("Сниффер"),
    "snifferStatusDesc": MessageLookupByLibrary.simpleMessage(
      "Сниффер определяет домен по трафику TLS, HTTP и QUIC, чтобы правила могли его сопоставить.",
    ),
    "socksPort": MessageLookupByLibrary.simpleMessage("Порт SOCKS"),
    "softStyle": MessageLookupByLibrary.simpleMessage("Мягкий"),
    "sort": MessageLookupByLibrary.simpleMessage("Сортировка"),
    "source": MessageLookupByLibrary.simpleMessage("Источник"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("IP источника"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Специальный прокси"),
    "specialRules": MessageLookupByLibrary.simpleMessage("Специальные правила"),
    "spectrum": MessageLookupByLibrary.simpleMessage("Спектр"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage(
      "Статистика скорости",
    ),
    "splitStrategy": MessageLookupByLibrary.simpleMessage(
      "Стратегия распределения",
    ),
    "splitStrategyNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Стратегия распределения не может быть пустой",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("Список SSID пуст"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Режим стека"),
    "stackTrace": MessageLookupByLibrary.simpleMessage("Трассировка стека"),
    "standard": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "Стандартный режим: добавляет правила поверх профиля",
    ),
    "start": MessageLookupByLibrary.simpleMessage("Старт"),
    "startFromScratch": MessageLookupByLibrary.simpleMessage("С нуля"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Запуск VPN…"),
    "startupAndBackground": MessageLookupByLibrary.simpleMessage(
      "Запуск и фоновая работа",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "При отключённом DNS используется системный DNS.",
    ),
    "stickToRegion": MessageLookupByLibrary.simpleMessage("Закрепить регион"),
    "stop": MessageLookupByLibrary.simpleMessage("Стоп"),
    "stopUpdateDownloadTip": MessageLookupByLibrary.simpleMessage(
      "Остановить загрузку обновления?",
    ),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Остановка VPN…"),
    "strategy": MessageLookupByLibrary.simpleMessage("Стратегия"),
    "strategyLaneCurrent": m116,
    "strategyLaneEffective": m117,
    "strategyLaneFollowSubscription": MessageLookupByLibrary.simpleMessage(
      "Следовать подписке",
    ),
    "strategyLaneFollowWithGroup": m118,
    "strategyLaneFollowing": MessageLookupByLibrary.simpleMessage(
      "Следует подписке",
    ),
    "strategyLaneKindAi": MessageLookupByLibrary.simpleMessage("ИИ"),
    "strategyLaneKindGaming": MessageLookupByLibrary.simpleMessage("Игры"),
    "strategyLaneKindMessaging": MessageLookupByLibrary.simpleMessage(
      "Мессенджеры",
    ),
    "strategyLaneKindOther": MessageLookupByLibrary.simpleMessage(
      "Другие стратегии",
    ),
    "strategyLaneKindProxy": MessageLookupByLibrary.simpleMessage(
      "Прокси / выбор",
    ),
    "strategyLaneKindSearch": MessageLookupByLibrary.simpleMessage("Поиск"),
    "strategyLaneKindSocial": MessageLookupByLibrary.simpleMessage("Соцсети"),
    "strategyLaneKindStreaming": MessageLookupByLibrary.simpleMessage(
      "Стриминг",
    ),
    "strategyLaneOverridden": MessageLookupByLibrary.simpleMessage(
      "Переопределено",
    ),
    "strategyLanePolicyAuto": MessageLookupByLibrary.simpleMessage(
      "Автовыбор FlClash",
    ),
    "strategyLanePolicyGroup": m119,
    "strategyLanePolicyProxy": m120,
    "strategyLaneTypeLoadBalance": MessageLookupByLibrary.simpleMessage(
      "Балансировка",
    ),
    "strategyLaneTypeRelay": MessageLookupByLibrary.simpleMessage("Реле"),
    "strategyLaneTypeSelector": MessageLookupByLibrary.simpleMessage(
      "Ручной выбор",
    ),
    "strategyLaneUncovered": MessageLookupByLibrary.simpleMessage(
      "В подписке нет отдельной стратегии — трафик идёт по умолчанию / MATCH",
    ),
    "strategyLanes": MessageLookupByLibrary.simpleMessage("Стратегии"),
    "strategyLanesApplied": MessageLookupByLibrary.simpleMessage(
      "Стратегии применены",
    ),
    "strategyLanesBusinessTitle": MessageLookupByLibrary.simpleMessage(
      "Частые сервисы",
    ),
    "strategyLanesDesc": MessageLookupByLibrary.simpleMessage(
      "Назначить сервисы стратегиям подписки или переопределить их",
    ),
    "strategyLanesEmpty": MessageLookupByLibrary.simpleMessage(
      "Стратегические группы не найдены",
    ),
    "strategyLanesEmptyDesc": MessageLookupByLibrary.simpleMessage(
      "В профиле пока нет выбираемых групп. Используйте подписку с правилами или выберите автовыбор для сервиса ниже.",
    ),
    "strategyLanesExtraTitle": MessageLookupByLibrary.simpleMessage(
      "Другие группы подписки",
    ),
    "strategyLanesLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить стратегии профиля",
    ),
    "strategyLanesNeedProfile": MessageLookupByLibrary.simpleMessage(
      "Сначала выберите профиль.",
    ),
    "strategyLanesNeedStart": MessageLookupByLibrary.simpleMessage(
      "Запустите FlClash, чтобы загрузить стратегические группы текущего профиля.",
    ),
    "strategyLanesPartialApplied": MessageLookupByLibrary.simpleMessage(
      "Применено, но часть переопределений пропущена (нет группы или узла)",
    ),
    "strategyLanesTip": MessageLookupByLibrary.simpleMessage(
      "Каждая строка — типичный тип трафика. Следуйте подписке, если у неё уже есть стратегия, или переопределите автовыбором / группой / узлом.",
    ),
    "strictRoute": MessageLookupByLibrary.simpleMessage(
      "Строгая маршрутизация",
    ),
    "strictRouteDesc": MessageLookupByLibrary.simpleMessage(
      "Строгая маршрутизация не даёт трафику вроде DNS обходить TUN, а при выключенном IPv6 блокирует IPv6-соединения этого устройства.",
    ),
    "style": MessageLookupByLibrary.simpleMessage("Стиль"),
    "subRule": MessageLookupByLibrary.simpleMessage("Подправило"),
    "subRuleEmpty": MessageLookupByLibrary.simpleMessage("Подправило пусто"),
    "subRuleNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Подправило не может быть пустым",
    ),
    "submit": MessageLookupByLibrary.simpleMessage("Отправить"),
    "subscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о подписке",
    ),
    "sudoPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Введите пароль для sudo",
    ),
    "suspended": MessageLookupByLibrary.simpleMessage("Приостановлено…"),
    "switchProfile": MessageLookupByLibrary.simpleMessage("Сменить профиль"),
    "sync": MessageLookupByLibrary.simpleMessage("Синхронизация"),
    "system": MessageLookupByLibrary.simpleMessage("Система"),
    "systemApp": MessageLookupByLibrary.simpleMessage("Системные приложения"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "tab": MessageLookupByLibrary.simpleMessage("Вкладки"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Анимация вкладок"),
    "tailscale": MessageLookupByLibrary.simpleMessage("Tailscale"),
    "tailscaleAcceptRoutes": MessageLookupByLibrary.simpleMessage(
      "Принимать маршруты",
    ),
    "tailscaleAndroidStep1": MessageLookupByLibrary.simpleMessage(
      "Получите ключ аутентификации в консоли администратора Tailscale (Settings → Keys).",
    ),
    "tailscaleAndroidStep2": MessageLookupByLibrary.simpleMessage(
      "Добавьте узел, вставьте ключ и укажите IP или имя MagicDNS домашнего устройства в пунктах назначения маршрута.",
    ),
    "tailscaleAndroidStep3": MessageLookupByLibrary.simpleMessage(
      "Включите Tailscale. «Оставлять трафик напрямую» обычно выключайте, если приложение Tailscale на телефоне не установлено.",
    ),
    "tailscaleAndroidStep4": MessageLookupByLibrary.simpleMessage(
      "Запустите VPN FlClash, затем нажмите кнопку ping у узла, чтобы проверить соединение.",
    ),
    "tailscaleAuthKey": MessageLookupByLibrary.simpleMessage(
      "Ключ аутентификации",
    ),
    "tailscaleAuthKeyHint": MessageLookupByLibrary.simpleMessage(
      "Из консоли администратора Tailscale → Settings → Keys. Требуется для аутентификации узла.",
    ),
    "tailscaleBypass": MessageLookupByLibrary.simpleMessage(
      "Оставлять трафик Tailscale напрямую",
    ),
    "tailscaleBypassAndroidHint": MessageLookupByLibrary.simpleMessage(
      "На Android обычно оставляйте выключенным. Включайте только если на телефоне также установлено приложение Tailscale.",
    ),
    "tailscaleBypassNudge": MessageLookupByLibrary.simpleMessage(
      "На этом устройстве, возможно, уже запущен Tailscale — включите «Прямой трафик Tailscale», чтобы избежать проблем Fake IP / control plane.",
    ),
    "tailscaleBypassRecommended": MessageLookupByLibrary.simpleMessage(
      "Рекомендуется на ПК, где установлено приложение/служба Tailscale. Автоматически управляет правилами DIRECT и Fake IP Filter.",
    ),
    "tailscaleControlUrl": MessageLookupByLibrary.simpleMessage(
      "URL сервера управления",
    ),
    "tailscaleControlUrlHint": MessageLookupByLibrary.simpleMessage(
      "Необязательно. Только для собственных серверов управления, например Headscale.",
    ),
    "tailscaleDesc": MessageLookupByLibrary.simpleMessage(
      "Управление исходящими узлами Tailscale",
    ),
    "tailscaleDesktopStep1": MessageLookupByLibrary.simpleMessage(
      "Если на этом ПК также работает приложение/служба Tailscale, включите «Оставлять трафик Tailscale напрямую».",
    ),
    "tailscaleDesktopStep2": MessageLookupByLibrary.simpleMessage(
      "Необязательно: добавьте встроенный узел Tailscale с ключом, чтобы направлять выбранный трафик через tailnet из FlClash.",
    ),
    "tailscaleDesktopStep3": MessageLookupByLibrary.simpleMessage(
      "Укажите назначения (домашние IP / MagicDNS) в пунктах назначения маршрута и включите Tailscale.",
    ),
    "tailscaleDesktopStep4": MessageLookupByLibrary.simpleMessage(
      "Запустите FlClash и нажмите ping у узла, чтобы убедиться, что соединение стабильно.",
    ),
    "tailscaleEmptyTip": MessageLookupByLibrary.simpleMessage(
      "Узлов Tailscale пока нет. Добавьте узел, чтобы направлять трафик через вашу сеть tailnet.",
    ),
    "tailscaleEnable": MessageLookupByLibrary.simpleMessage(
      "Включить Tailscale",
    ),
    "tailscaleEnableBypassAction": MessageLookupByLibrary.simpleMessage(
      "Включить",
    ),
    "tailscaleEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Добавлять узлы Tailscale как исходящие. При отключении Tailscale перестаёт обрабатывать трафик; обычный трафик не затрагивается.",
    ),
    "tailscaleEphemeral": MessageLookupByLibrary.simpleMessage(
      "Временный узел",
    ),
    "tailscaleExitNode": MessageLookupByLibrary.simpleMessage("Выходной узел"),
    "tailscaleExitNodeAllowLanAccess": MessageLookupByLibrary.simpleMessage(
      "Разрешить доступ к локальной сети через выходной узел",
    ),
    "tailscaleExitNodeHint": MessageLookupByLibrary.simpleMessage(
      "Необязательно. IP-адрес или имя выходного узла tailnet для маршрутизации всего трафика.",
    ),
    "tailscaleGuideTitle": MessageLookupByLibrary.simpleMessage(
      "Как работает Tailscale",
    ),
    "tailscaleHostname": MessageLookupByLibrary.simpleMessage("Имя хоста"),
    "tailscaleHostnameHint": MessageLookupByLibrary.simpleMessage(
      "Необязательно. Имя устройства, отображаемое в вашей сети tailnet.",
    ),
    "tailscaleNameExistsTip": MessageLookupByLibrary.simpleMessage(
      "Узел с таким именем уже существует",
    ),
    "tailscaleNameHelper": MessageLookupByLibrary.simpleMessage(
      "Имя исходящего узла в Proxies. Переименование меняет привязку выбора и тестов задержки.",
    ),
    "tailscaleNoRoutes": MessageLookupByLibrary.simpleMessage(
      "Нет пунктов назначения",
    ),
    "tailscaleNodesTitle": MessageLookupByLibrary.simpleMessage("Узлы"),
    "tailscaleNotTested": MessageLookupByLibrary.simpleMessage("Не проверено"),
    "tailscaleRoutes": MessageLookupByLibrary.simpleMessage(
      "Пункты назначения маршрута",
    ),
    "tailscaleRoutesCount": m121,
    "tailscaleRoutesHint": MessageLookupByLibrary.simpleMessage(
      "Домены или IP, направляемые через этот узел, по одному в строке (например, Tailscale IP или имя MagicDNS вашего домашнего ПК).",
    ),
    "tailscaleScenarioAndroidBody": MessageLookupByLibrary.simpleMessage(
      "Оставьте FlClash единственным VPN. Не запускайте VPN приложения Tailscale одновременно (Android допускает только один). Добавьте встроенный узел Tailscale ниже и укажите домашнее устройство в пунктах назначения маршрута.",
    ),
    "tailscaleScenarioAndroidTitle": MessageLookupByLibrary.simpleMessage(
      "Настройка клиента Android",
    ),
    "tailscaleScenarioDesktopBody": MessageLookupByLibrary.simpleMessage(
      "Можно запускать FlClash и настоящее приложение Tailscale вместе. Включите «Оставлять трафик Tailscale напрямую», чтобы FlClash не перехватывал плоскость управления Tailscale и fake-IP DNS.",
    ),
    "tailscaleScenarioDesktopTitle": MessageLookupByLibrary.simpleMessage(
      "Настройка ПК / хоста",
    ),
    "tailscaleShowSetupGuide": MessageLookupByLibrary.simpleMessage(
      "Инструкция",
    ),
    "tailscaleStateDir": MessageLookupByLibrary.simpleMessage(
      "Каталог состояния",
    ),
    "tailscaleStateDirHint": MessageLookupByLibrary.simpleMessage(
      "Необязательно. Каталог для хранения состояния Tailscale.",
    ),
    "tailscaleStatusDisabled": MessageLookupByLibrary.simpleMessage(
      "Tailscale выключен — узлы не добавляются в рабочий профиль.",
    ),
    "tailscaleStatusNeedRoutes": MessageLookupByLibrary.simpleMessage(
      "Узлы добавлены, но нет маршрутов — трафик не совпадёт, пока не добавите маршруты (или выберите узел вручную).",
    ),
    "tailscaleStatusNeedStart": MessageLookupByLibrary.simpleMessage(
      "Узлы готовы. Запустите VPN FlClash, затем нажмите ping для проверки.",
    ),
    "tailscaleStatusNoNodes": MessageLookupByLibrary.simpleMessage(
      "Включено, но узлов ещё нет. Добавьте узел, чтобы начать.",
    ),
    "tailscaleStatusReady": m122,
    "tailscaleTestNeedEnable": MessageLookupByLibrary.simpleMessage(
      "Перед проверкой включите Tailscale.",
    ),
    "tailscaleTestNeedStart": MessageLookupByLibrary.simpleMessage(
      "Перед проверкой соединения запустите VPN FlClash.",
    ),
    "tailscaleTestNode": MessageLookupByLibrary.simpleMessage(
      "Проверить соединение",
    ),
    "tailscaleTestTip": MessageLookupByLibrary.simpleMessage(
      "Кнопка ping рядом с узлом проверяет, может ли исходящий Tailscale установить соединение. Задержка означает, что связь есть; Timeout — проверьте ключ, переключатель включения и что VPN FlClash запущен.",
    ),
    "tailscaleUdp": MessageLookupByLibrary.simpleMessage("Ретрансляция UDP"),
    "tapIconToRetry": MessageLookupByLibrary.simpleMessage(
      "Нажмите на значок, чтобы повторить",
    ),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы разрешить",
    ),
    "tapToRetry": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы повторить",
    ),
    "target": MessageLookupByLibrary.simpleMessage("Цель"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("Параллельный TCP"),
    "testInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал тестирования",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage("URL для теста"),
    "testWhenUsed": MessageLookupByLibrary.simpleMessage(
      "Тестировать при использовании",
    ),
    "textScale": MessageLookupByLibrary.simpleMessage("Масштаб текста"),
    "textScalePreview": MessageLookupByLibrary.simpleMessage(
      "Так будет выглядеть текст в приложении",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Цвет темы"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Тёмный режим и настройка цветов",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Режим темы"),
    "tight": MessageLookupByLibrary.simpleMessage("Плотный"),
    "time": MessageLookupByLibrary.simpleMessage("Время"),
    "timeToFirstByte": MessageLookupByLibrary.simpleMessage(
      "Время до первого байта",
    ),
    "timeout": MessageLookupByLibrary.simpleMessage("Тайм-аут"),
    "tintedStyle": MessageLookupByLibrary.simpleMessage("Тонированный"),
    "tip": MessageLookupByLibrary.simpleMessage("Подсказка"),
    "toggle": MessageLookupByLibrary.simpleMessage("Переключить"),
    "tolerance": MessageLookupByLibrary.simpleMessage("Допуск"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("Тональный акцент"),
    "tools": MessageLookupByLibrary.simpleMessage("Инструменты"),
    "torch": MessageLookupByLibrary.simpleMessage("Фонарик"),
    "total": MessageLookupByLibrary.simpleMessage("Всего"),
    "totalDownload": MessageLookupByLibrary.simpleMessage("Загружено"),
    "totalTraffic": MessageLookupByLibrary.simpleMessage("Общий трафик"),
    "totalUpload": MessageLookupByLibrary.simpleMessage("Отдано"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Порт TProxy"),
    "traffic": MessageLookupByLibrary.simpleMessage("Трафик"),
    "trafficPeak": m123,
    "trafficTotal": m124,
    "trafficUsage": MessageLookupByLibrary.simpleMessage("Статистика трафика"),
    "transport": MessageLookupByLibrary.simpleMessage("Транспорт"),
    "transportHeaders": m125,
    "trustCertificate": MessageLookupByLibrary.simpleMessage(
      "Доверять сертификату",
    ),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunAuthorizationFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить права для TUN, поэтому он выключен.",
    ),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "TUN работает только в режиме администратора.",
    ),
    "tunOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Добавленные здесь параметры заменяют настройки TUN всех профилей; остальные остаются такими, как в профиле. Параметры, добавленные в самом пользовательском профиле, имеют приоритет.",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Выключить"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Включить"),
    "udpRelayMode": MessageLookupByLibrary.simpleMessage(
      "Режим ретрансляции UDP",
    ),
    "udpTimeout": MessageLookupByLibrary.simpleMessage("Тайм-аут UDP"),
    "udpTimeoutDesc": MessageLookupByLibrary.simpleMessage(
      "Тайм-аут UDP задаётся в секундах и действует только со стеками gvisor, system и mixed.",
    ),
    "ultra": MessageLookupByLibrary.simpleMessage("Максимум"),
    "undo": MessageLookupByLibrary.simpleMessage("Отменить"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Единая задержка"),
    "unknown": MessageLookupByLibrary.simpleMessage("Неизвестно"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage(
      "Неизвестная сетевая ошибка",
    ),
    "unmaximize": MessageLookupByLibrary.simpleMessage("Свернуть в окно"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Без названия"),
    "unpinWindow": MessageLookupByLibrary.simpleMessage("Открепить окно"),
    "update": MessageLookupByLibrary.simpleMessage("Обновить"),
    "updateChecksumMismatch": MessageLookupByLibrary.simpleMessage(
      "Файл не совпадает с опубликованной контрольной суммой",
    ),
    "updateDownload": MessageLookupByLibrary.simpleMessage(
      "Загрузка обновления",
    ),
    "updateDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить обновление.",
    ),
    "updateDownloadStarted": MessageLookupByLibrary.simpleMessage(
      "Загрузка обновления началась. Следите за ходом на главной странице.",
    ),
    "updateDownloadTest": MessageLookupByLibrary.simpleMessage(
      "Тест загрузки обновления",
    ),
    "updateFailed": MessageLookupByLibrary.simpleMessage("Не удалось обновить"),
    "updateInstall": MessageLookupByLibrary.simpleMessage(
      "Установка обновления",
    ),
    "updateInstallFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось установить обновление. Его можно скачать на странице релиза.",
    ),
    "updateInstallPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешите установку неизвестных приложений и проверьте обновление снова",
    ),
    "updateNotVerified": MessageLookupByLibrary.simpleMessage(
      "Не удалось проверить загруженное обновление.",
    ),
    "updateOpenDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Для этого устройства нет встроенного установщика. Откроется страница загрузки.",
    ),
    "updateOpensInstaller": MessageLookupByLibrary.simpleMessage(
      "Откроется системный установщик",
    ),
    "updatePackageMissing": MessageLookupByLibrary.simpleMessage(
      "В этом выпуске нет пакета для этого устройства",
    ),
    "updateReady": MessageLookupByLibrary.simpleMessage("Обновление готово"),
    "updateReadyTip": MessageLookupByLibrary.simpleMessage(
      "Обновление загружено. Нажмите, чтобы установить.",
    ),
    "updateRestartTip": MessageLookupByLibrary.simpleMessage(
      "FlClash закроется для установки обновления и снова откроется после завершения.",
    ),
    "updateRunningVersion": m126,
    "updateVerify": MessageLookupByLibrary.simpleMessage("Проверка загрузки"),
    "updateWillRestart": MessageLookupByLibrary.simpleMessage(
      "Приложение закроется и откроется снова",
    ),
    "upload": MessageLookupByLibrary.simpleMessage("Отдача"),
    "uploadBandwidth": MessageLookupByLibrary.simpleMessage("Скорость отдачи"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("Получить профиль по URL"),
    "urlRewrite": MessageLookupByLibrary.simpleMessage("Перезапись URL"),
    "urlTip": m127,
    "useHosts": MessageLookupByLibrary.simpleMessage("Использовать hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Использовать системный hosts",
    ),
    "usedShort": MessageLookupByLibrary.simpleMessage("использовано"),
    "usedTraffic": MessageLookupByLibrary.simpleMessage(
      "Использованный трафик",
    ),
    "userAgent": MessageLookupByLibrary.simpleMessage("User-Agent"),
    "username": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
    "validUntil": m128,
    "value": MessageLookupByLibrary.simpleMessage("Значение"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Яркая"),
    "view": MessageLookupByLibrary.simpleMessage("Просмотр"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Показать всё"),
    "virtualIpv4": MessageLookupByLibrary.simpleMessage("Виртуальный IPv4"),
    "vividStyle": MessageLookupByLibrary.simpleMessage("Яркий"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "Настройки VPN изменены. Нажмите, чтобы перезапустить",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "VPN автоматически направляет весь системный трафик через VpnService.",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Изменения вступят в силу после перезапуска VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "Настройка WebDAV",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage(
      "Режим белого списка",
    ),
    "writeToSystem": MessageLookupByLibrary.simpleMessage(
      "Записывать в систему",
    ),
    "writeToSystemDesc": MessageLookupByLibrary.simpleMessage(
      "«Записывать в систему» также устанавливает системные часы; Android это игнорирует.",
    ),
    "yearsAgo": m129,
    "yearsAgoShort": m130,
    "yes": MessageLookupByLibrary.simpleMessage("Да"),
    "zhCN": MessageLookupByLibrary.simpleMessage("Упрощённый китайский"),
  };
}
