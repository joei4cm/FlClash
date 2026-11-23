// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get rule => 'Regla';

  @override
  String get rules => 'Reglas';

  @override
  String get global => 'Global';

  @override
  String get direct => 'Directo';

  @override
  String get dashboard => 'Panel';

  @override
  String get proxies => 'Proxies';

  @override
  String get profile => 'Perfil';

  @override
  String get profiles => 'Perfiles';

  @override
  String get tools => 'Herramientas';

  @override
  String get logs => 'Registros';

  @override
  String get resources => 'Recursos';

  @override
  String get trafficUsage => 'Uso de tráfico';

  @override
  String get networkSpeed => 'Velocidad de red';

  @override
  String get outboundMode => 'Modo de salida';

  @override
  String get serviceStatus => 'Estado del servicio';

  @override
  String get serviceRestricted => 'Acceso restringido';

  @override
  String get serviceAvailable => 'Disponible';

  @override
  String get serviceUnavailable => 'No disponible';

  @override
  String get serviceFailed => 'Error en la comprobación';

  @override
  String get serviceDisallowedIsp => 'ISP no permitido';

  @override
  String get serviceBlocked => 'Bloqueado';

  @override
  String get serviceUnsupportedRegion => 'Región no compatible';

  @override
  String get serviceOriginalsOnly => 'Solo originales';

  @override
  String get serviceComingSoon => 'Próximamente';

  @override
  String get servicePending => 'Sin comprobar';

  @override
  String get serviceManage => 'Gestionar servicios';

  @override
  String get serviceCheckAll => 'Comprobar todo';

  @override
  String get upload => 'Subida';

  @override
  String get download => 'Descarga';

  @override
  String get usedTraffic => 'Tráfico usado';

  @override
  String get totalTraffic => 'Tráfico total';

  @override
  String get expireTime => 'Fecha de vencimiento';

  @override
  String get nullProfileDesc => 'Añade un perfil para empezar';

  @override
  String get settings => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get defaultText => 'Predeterminado';

  @override
  String get more => 'Más';

  @override
  String get other => 'Otros';

  @override
  String get about => 'Acerca de';

  @override
  String get en => 'Inglés';

  @override
  String get es => 'Español';

  @override
  String get fr => 'Francés';

  @override
  String get ja => 'Japonés';

  @override
  String get ko => 'Coreano';

  @override
  String get ru => 'Ruso';

  @override
  String get zhCN => 'Chino simplificado';

  @override
  String get theme => 'Tema';

  @override
  String get extend => 'Extensión';

  @override
  String get runtimeConfig => 'Configuración de ejecución';

  @override
  String get allowLan => 'Permitir LAN';

  @override
  String get tun => 'TUN';

  @override
  String get tunDesc => 'TUN solo funciona en modo administrador.';

  @override
  String get minimizeOnExit => 'Minimizar al salir';

  @override
  String get autoLaunch => 'Inicio automático';

  @override
  String get silentLaunch => 'Inicio silencioso';

  @override
  String get autoRun => 'Ejecución automática';

  @override
  String get autoRunDesc =>
      'La ejecución automática inicia el proxy al abrir la app.';

  @override
  String get logcat => 'Logcat';

  @override
  String get logcatDesc =>
      'Si desactivas Logcat, se oculta la entrada de registros.';

  @override
  String get autoCheckUpdate => 'Buscar actualizaciones automáticamente';

  @override
  String get checkCertificate => 'Verificar certificados TLS';

  @override
  String get checkCertificateDesc =>
      'Con la verificación TLS desactivada, las suscripciones y las copias de seguridad quedan expuestas a ataques de intermediario.';

  @override
  String get accessControl => 'Control de acceso';

  @override
  String get edit => 'Editar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get update => 'Actualizar';

  @override
  String get add => 'Añadir';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get seconds => 'segundos';

  @override
  String get qrcode => 'Código QR';

  @override
  String get qrcodeDesc => 'Escanea un código QR para obtener un perfil';

  @override
  String get url => 'URL';

  @override
  String get link => 'Enlace';

  @override
  String get file => 'Archivo';

  @override
  String get name => 'Nombre';

  @override
  String get profileNameNullValidationDesc => 'Introduce el nombre del perfil';

  @override
  String get rename => 'Renombrar';

  @override
  String get profileUrlNullValidationDesc => 'Introduce la URL del perfil';

  @override
  String get profileUrlInvalidValidationDesc =>
      'Introduce una URL de perfil válida';

  @override
  String get autoUpdate => 'Actualización automática';

  @override
  String get autoUpdateInterval => 'Intervalo de actualización automática';

  @override
  String get profileAutoUpdateIntervalNullValidationDesc =>
      'Introduce el intervalo de actualización automática';

  @override
  String get profileAutoUpdateIntervalInvalidValidationDesc =>
      'Introduce un intervalo válido';

  @override
  String get themeMode => 'Modo del tema';

  @override
  String get themeColor => 'Color del tema';

  @override
  String get preview => 'Vista previa';

  @override
  String get auto => 'Automático';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get importFromLink => 'Importar desde enlace';

  @override
  String get sendFromPhone => 'Enviar desde el teléfono';

  @override
  String get sendFromPhoneTip =>
      'Escanea el código con la cámara del teléfono y pega el enlace en la página que se abre. Ambos dispositivos deben estar en la misma red.';

  @override
  String get sendFromPhoneNoNetwork =>
      'Este dispositivo no está conectado a una red local';

  @override
  String get sendFromPhonePermissionDenied =>
      'Para recibir un enlace desde el teléfono, FlClash necesita el permiso Dispositivos cercanos, que le da acceso a la red local. Actívalo en los ajustes de la aplicación.';

  @override
  String get sendFromPhonePageTitle => 'Enviar un enlace a FlClash';

  @override
  String get sendFromPhonePageHint =>
      'Enlace de suscripción o enlace para compartir un proxy';

  @override
  String get send => 'Enviar';

  @override
  String get sendFromPhonePageSent =>
      'Enviado. Confirma la importación en el otro dispositivo.';

  @override
  String get sendFromPhoneConfirmTitle =>
      '¿Importar el enlace enviado desde el teléfono?';

  @override
  String get shareQrcodeTip =>
      'Escanea con FlClash en otro dispositivo para importar este perfil.';

  @override
  String get qrcodeTooLongTip =>
      'Este enlace es demasiado largo para un código QR. Usa Copiar enlace.';

  @override
  String get submit => 'Enviar';

  @override
  String createProfileFromUrlTip(Object url) {
    return '¿Quieres crear un perfil a partir de $url?';
  }

  @override
  String get create => 'Crear';

  @override
  String get pleaseUploadValidQrcode => 'Sube un código QR válido';

  @override
  String get blacklistMode => 'Modo lista negra';

  @override
  String get whitelistMode => 'Modo lista blanca';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get cancelSelectAll => 'Deseleccionar todo';

  @override
  String get appAccessControl => 'Control de acceso de apps';

  @override
  String get accessControlAllowDesc =>
      'Solo las apps seleccionadas usan la VPN';

  @override
  String get accessControlNotAllowDesc =>
      'Las apps seleccionadas quedan excluidas de la VPN';

  @override
  String get accessControlDisabledDesc =>
      'El control de acceso de apps está desactivado';

  @override
  String accessControlSelectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seleccionadas',
      one: '$count seleccionada',
    );
    return '$_temp0';
  }

  @override
  String get port => 'Puerto';

  @override
  String get logLevel => 'Nivel de registro';

  @override
  String get show => 'Mostrar';

  @override
  String get exit => 'Salir';

  @override
  String get systemProxy => 'Proxy del sistema';

  @override
  String get safeMode => 'Modo seguro';

  @override
  String safeModeAppTitle(Object appName) {
    return '$appName (Modo seguro)';
  }

  @override
  String get project => 'Proyecto';

  @override
  String get core => 'Núcleo';

  @override
  String get tabAnimation => 'Animación de pestañas';

  @override
  String get desc =>
      'Un cliente proxy multiplataforma basado en ClashMeta, sencillo de usar, de código abierto y sin anuncios.';

  @override
  String get startVpn => 'Iniciando VPN…';

  @override
  String get stopVpn => 'Deteniendo VPN…';

  @override
  String get localNetworkDeniedTip =>
      'Permiso de red local denegado: con la pila gvisor, la LAN no es accesible.';

  @override
  String get compatible => 'Modo de compatibilidad';

  @override
  String get notSelectedTip =>
      'No se puede seleccionar el grupo de proxies actual';

  @override
  String get changeProxyFailedTip =>
      'No se pudo cambiar de proxy; se ha restaurado la selección anterior';

  @override
  String get databaseWriteFailedTip =>
      'No se pudo guardar el cambio; se ha revertido';

  @override
  String get tip => 'Consejo';

  @override
  String get account => 'Cuenta';

  @override
  String get backup => 'Copia de seguridad';

  @override
  String get backupSuccess => 'Copia de seguridad completada';

  @override
  String get noInfo => 'Sin información';

  @override
  String get pleaseBindWebDAV => 'Vincula WebDAV';

  @override
  String get bind => 'Vincular';

  @override
  String get connectivity => 'Conectividad: ';

  @override
  String get webDAVConfiguration => 'Configuración de WebDAV';

  @override
  String get address => 'Dirección';

  @override
  String get addressTip => 'Introduce una dirección WebDAV válida';

  @override
  String get password => 'Contraseña';

  @override
  String get authentication => 'Autenticación';

  @override
  String get authenticationSystemProxyDesc =>
      'El proxy del sistema no se aplica mientras la autenticación esté activada.';

  @override
  String get checkUpdate => 'Buscar actualizaciones';

  @override
  String get discoverNewVersion => 'Nueva versión disponible';

  @override
  String get checkUpdateError => 'La app ya está actualizada';

  @override
  String get goDownload => 'Descargar';

  @override
  String get unknown => 'Desconocido';

  @override
  String get country => 'Región';

  @override
  String get search => 'Buscar';

  @override
  String get allowBypass => 'Permitir que las apps eludan la VPN';

  @override
  String get externalController => 'Controlador externo';

  @override
  String get externalControllerDesc =>
      'El controlador externo permite controlar el núcleo en el puerto 9090.';

  @override
  String get externalControllerSecret => 'Clave del controlador externo';

  @override
  String get ipv6Desc =>
      'El tráfico IPv6 solo se recibe mientras IPv6 esté activado.';

  @override
  String get app => 'App';

  @override
  String get general => 'General';

  @override
  String get startupAndBackground => 'Inicio y segundo plano';

  @override
  String get requestsAndUpdates => 'Solicitudes y actualizaciones';

  @override
  String get logsAndDiagnostics => 'Registros y diagnóstico';

  @override
  String get userAgent => 'User-Agent';

  @override
  String get unifiedDelay => 'Latencia unificada';

  @override
  String get tcpConcurrent => 'TCP concurrente';

  @override
  String get geodataLoader => 'Modo geo de poca memoria';

  @override
  String get requests => 'Solicitudes';

  @override
  String get recentRequests => 'Solicitudes recientes';

  @override
  String get alwaysFindProcess => 'Buscar siempre el proceso';

  @override
  String get init => 'Inicio';

  @override
  String get infiniteTime => 'No caduca';

  @override
  String get connections => 'Conexiones';

  @override
  String get liveConnections => 'Conexiones activas';

  @override
  String get inbound => 'Entrada';

  @override
  String get intranetIP => 'IP de intranet';

  @override
  String get view => 'Ver';

  @override
  String get cut => 'Cortar';

  @override
  String get copy => 'Copiar';

  @override
  String get clipboardWriteFailed =>
      'No se pudo copiar al portapapeles. Puede que la selección sea demasiado grande';

  @override
  String get paste => 'Pegar';

  @override
  String get testUrl => 'URL de prueba';

  @override
  String get delayTestTimeout => 'Tiempo de espera de la prueba de latencia';

  @override
  String get sync => 'Sincronizar';

  @override
  String get exclude => 'Ocultar de aplicaciones recientes';

  @override
  String get compact => 'Compacto';

  @override
  String get tab => 'Pestaña';

  @override
  String get list => 'Lista';

  @override
  String get delay => 'Latencia';

  @override
  String get style => 'Estilo';

  @override
  String get size => 'Tamaño';

  @override
  String get sort => 'Ordenar';

  @override
  String get columns => 'Columnas';

  @override
  String get proxyGroup => 'Grupo de proxies';

  @override
  String get go => 'Ir';

  @override
  String get externalLink => 'Enlace externo';

  @override
  String get otherContributors => 'Otros colaboradores';

  @override
  String get appIconDesign => 'Diseño del icono de la app';

  @override
  String get launcherIcon => 'Icono de la app';

  @override
  String get launcherIconClassic => 'Clásico';

  @override
  String get launcherIconFrost => 'Escarcha';

  @override
  String get launcherIconMidnight => 'Medianoche';

  @override
  String get launcherIconIndigo => 'Índigo';

  @override
  String get launcherIconTide => 'Marea';

  @override
  String get launcherIconGraphite => 'Grafito';

  @override
  String get autoCloseConnections => 'Cerrar conexiones automáticamente';

  @override
  String get onlyStatisticsProxy => 'Contar solo el tráfico del proxy';

  @override
  String get showNotificationStopAction =>
      'Botón de detener en la notificación';

  @override
  String get pureBlackMode => 'Modo negro puro';

  @override
  String get sidebar => 'Barra lateral';

  @override
  String get backgroundBlur => 'Desenfoque de fondo';

  @override
  String get liquidGlass => 'Liquid Glass';

  @override
  String get keepAliveIntervalDesc => 'Intervalo de keep-alive TCP';

  @override
  String get entries => ' entradas';

  @override
  String get local => 'Local';

  @override
  String get remote => 'Remoto';

  @override
  String get mode => 'Modo';

  @override
  String get time => 'Hora';

  @override
  String get source => 'Origen';

  @override
  String get action => 'Acción';

  @override
  String get intelligentSelected => 'Selección inteligente';

  @override
  String get clipboardImport => 'Importar desde el portapapeles';

  @override
  String get clipboardNoPackageNames =>
      'No hay nombres de paquete válidos en el portapapeles';

  @override
  String get clipboardExport => 'Exportar al portapapeles';

  @override
  String get layout => 'Diseño';

  @override
  String get tight => 'Ajustado';

  @override
  String get standard => 'Estándar';

  @override
  String get ultra => 'Ultra';

  @override
  String get loose => 'Amplio';

  @override
  String get profilesSort => 'Ordenar perfiles';

  @override
  String get start => 'Iniciar';

  @override
  String get runTime => 'Tiempo de ejecución';

  @override
  String get stop => 'Detener';

  @override
  String get key => 'Clave';

  @override
  String get value => 'Valor';

  @override
  String get options => 'Opciones';

  @override
  String get enabled => 'Activado';

  @override
  String get disabled => 'Desactivado';

  @override
  String get loopback => 'Exención de loopback de UWP';

  @override
  String get providers => 'Recursos externos';

  @override
  String get proxyProviders => 'Proveedores de proxies';

  @override
  String get ruleProviders => 'Proveedores de reglas';

  @override
  String get providerUrlTip => 'Solo se admiten proveedores remotos';

  @override
  String get ruleSetEmptyTip =>
      'El conjunto de reglas no tiene entradas utilizables';

  @override
  String get ruleSetMixedTip =>
      'El conjunto de reglas mezcla dominios y rangos de IP, por lo que no se puede determinar su tipo';

  @override
  String get ruleSetInvalidTip => 'No se puede leer este archivo mrs';

  @override
  String get subscriptionInfo => 'Información de la suscripción';

  @override
  String get server => 'Servidor';

  @override
  String get ntpInterval => 'Intervalo de sincronización (minutos)';

  @override
  String get dialerProxy => 'Proxy de marcación';

  @override
  String get writeToSystem => 'Escribir en el sistema';

  @override
  String get writeToSystemDesc =>
      'Escribir en el sistema también ajusta el reloj del sistema; Android lo ignora.';

  @override
  String get sniffer => 'Sniffer';

  @override
  String get overrideDestination => 'Sobrescribir destino';

  @override
  String get forceDnsMapping => 'Forzar mapeo DNS';

  @override
  String get forceDnsMappingDesc =>
      'Forzar mapeo DNS también analiza las conexiones cuyo dominio provino de un mapeo DNS.';

  @override
  String get parsePureIp => 'Analizar IP pura';

  @override
  String get forceDomain => 'Forzar dominios';

  @override
  String get forceDomainDesc =>
      'Los dominios forzados también se analizan; las demás conexiones que ya tienen dominio se dejan como están.';

  @override
  String get skipDomain => 'Omitir dominios';

  @override
  String get skipSrcAddress => 'Omitir direcciones de origen';

  @override
  String get skipDstAddress => 'Omitir direcciones de destino';

  @override
  String get sniffProtocols => 'Protocolos';

  @override
  String get ports => 'Puertos';

  @override
  String get overrideEntries => 'Entradas de sobrescritura';

  @override
  String get addOverrideEntry => 'Añadir entrada de sobrescritura';

  @override
  String get dnsOverrideDesc =>
      'Las entradas añadidas aquí sustituyen el DNS de todos los perfiles de URL y de archivo; lo que no añadas conserva el ajuste del propio perfil. Los perfiles personalizados definen su DNS en su contenido.';

  @override
  String get settingEntries => 'ajustes';

  @override
  String get addSettingEntry => 'Añadir ajuste';

  @override
  String get profileSettingsDesc =>
      'Se aplica solo a este perfil; lo que no añadas usa su valor predeterminado.';

  @override
  String get healthCheck => 'Comprobación de estado';

  @override
  String get discardChanges => '¿Descartar los cambios?';

  @override
  String get quickEdit => 'Edición rápida';

  @override
  String get status => 'Estado';

  @override
  String get statusDesc => 'Con DNS desactivado, se usa el DNS del sistema.';

  @override
  String get respectRules => 'Respetar reglas';

  @override
  String get respectRulesDesc =>
      'Respetar reglas enruta las conexiones DNS según las reglas y requiere un Proxy Server Nameserver.';

  @override
  String get dnsMode => 'Modo DNS';

  @override
  String get fakeipRange => 'Rango Fake-IP';

  @override
  String get fakeipFilter => 'Filtro Fake-IP';

  @override
  String get useHosts => 'Usar hosts';

  @override
  String get useSystemHosts => 'Usar hosts del sistema';

  @override
  String get fallbackFilter => 'Filtro de respaldo';

  @override
  String get domain => 'Dominio';

  @override
  String get listenRoutingMark => 'Marca de enrutamiento de escucha';

  @override
  String get listenRoutingMarkDesc =>
      'La marca de enrutamiento de escucha solo funciona en Linux.';

  @override
  String get ipv6Timeout => 'Tiempo de espera IPv6 (ms)';

  @override
  String get cacheAlgorithm => 'Algoritmo de caché';

  @override
  String get cacheMaxSize => 'Tamaño de caché';

  @override
  String get fakeipRange6 => 'Rango Fake-IP (IPv6)';

  @override
  String get fakeipFilterMode => 'Modo de filtro Fake-IP';

  @override
  String get fakeipTtl => 'TTL de Fake-IP';

  @override
  String get reset => 'Restablecer';

  @override
  String get actionView => 'Mostrar/Ocultar';

  @override
  String get actionStart => 'Iniciar/Detener';

  @override
  String get actionMode => 'Cambiar modo';

  @override
  String get actionProxy => 'Proxy del sistema';

  @override
  String get actionTun => 'TUN';

  @override
  String get actionRuleMode => 'Modo regla';

  @override
  String get actionGlobalMode => 'Modo global';

  @override
  String get actionDirectMode => 'Modo directo';

  @override
  String get actionDelayTest => 'Probar la latencia de todos';

  @override
  String get actionUpdateProfiles => 'Actualizar perfiles';

  @override
  String get disclaimer => 'Aviso legal';

  @override
  String get disclaimerDesc =>
      'Antes de usar FlClash («el Software»), lee atentamente esta declaración y asegúrate de entenderla. Tocar «Aceptar» significa que has leído y entendido lo que sigue. Si no quieres continuar, toca «Salir».';

  @override
  String get disclaimerSoftwareTitle => 'Naturaleza del software';

  @override
  String get disclaimerSoftwareContent =>
      'El Software es un cliente proxy de red de código abierto basado en el núcleo Clash.Meta (mihomo). Solo ofrece herramientas locales como la gestión de configuración, el enrutamiento basado en reglas y el reenvío de tráfico.';

  @override
  String get disclaimerNoServiceStatement =>
      'El Software en sí no proporciona ningún servidor proxy, nodo, suscripción ni servicio de acceso a la red, y no mantiene ninguna relación de asociación, representación ni garantía con ningún proveedor de dichos servicios.';

  @override
  String get disclaimerUsageTitle => 'Sobre el uso';

  @override
  String get disclaimerUsageContent =>
      'Cualquier actividad comercial que alguien realice con el Software, incluida la distribución de pago, la venta en paquete o su uso como parte de un servicio comercial, no tiene relación con los desarrolladores del Software, que no la respaldan, apoyan ni garantizan.\n\nEres responsable de cumplir las leyes del país o región donde te encuentres y asumes las consecuencias de cualquier uso ilegal del Software.';

  @override
  String get disclaimerResponsibilityTitle => 'Tu responsabilidad';

  @override
  String get disclaimerResponsibilityContent =>
      'Eres responsable de asegurarte de que el uso del Software sea legal donde vives, y asumes tú solo la responsabilidad legal de todo lo que hagas con él y de sus consecuencias.\n\nLas suscripciones, los nodos y las configuraciones que importas son decisión tuya. Que su origen sea legal, su contenido seguro y su servicio fiable es un asunto entre tú y sus proveedores.';

  @override
  String get disclaimerThirdPartyTitle => 'Contenido de terceros';

  @override
  String get disclaimerThirdPartyContent =>
      'Los enlaces de suscripción, los archivos de configuración, los conjuntos de reglas, los scripts, los recursos externos y los enlaces externos los proporcionan terceros. Los desarrolladores no pueden revisar ni garantizar, ni lo hacen, su legalidad, exactitud, seguridad o disponibilidad.\n\nCualquier fuga de datos, pérdida económica, bloqueo de cuenta u otra pérdida causada por contenido de terceros debe resolverse entre tú y el tercero; los desarrolladores no asumen ninguna responsabilidad por ello.';

  @override
  String get disclaimerWarrantyTitle => 'Sin garantía';

  @override
  String get disclaimerWarrantyContent =>
      'El Software se proporciona “tal cual” y “según disponibilidad”, sin garantía de ningún tipo, expresa o implícita, incluidas, entre otras, las garantías de comerciabilidad, idoneidad para un fin concreto, no infracción, disponibilidad ininterrumpida, ausencia de errores o ausencia de vulnerabilidades de seguridad.\n\nLos desarrolladores no garantizan que el Software satisfaga tus necesidades ni que funcione sin interrupciones ni errores.';

  @override
  String get disclaimerLiabilityTitle => 'Limitación de responsabilidad';

  @override
  String get disclaimerLiabilityContent =>
      'En la máxima medida permitida por la ley aplicable, ni los desarrolladores ni ningún colaborador serán responsables de ningún daño directo, indirecto, incidental, especial, punitivo o emergente derivado del uso o de la imposibilidad de usar el Software, incluidos, entre otros, la pérdida de datos, los daños al dispositivo, los fallos de red, la interrupción de la actividad, el lucro cesante o cualquier disputa legal resultante, incluso si se les hubiera advertido de la posibilidad de tales daños.';

  @override
  String get disclaimerPrivacyTitle => 'Recopilación de datos y privacidad';

  @override
  String get disclaimerPrivacyContent =>
      'El Software no recopila ni sube tus URL de suscripción, los detalles de los nodos, el contenido de las configuraciones, los sitios web visitados, los registros de conexión, el contenido del tráfico ni los registros. Estos datos permanecen en tu dispositivo y los desarrolladores no tienen acceso a ellos.\n\nEl Software solo accede a la red cuando usas una función que lo necesita, como obtener la URL de suscripción que indicaste al actualizar un perfil o conectarse a GitHub al buscar actualizaciones.\n\nEl Software no incluye ningún servicio de analítica ni de informes de fallos en ninguna plataforma.';

  @override
  String get disclaimerLicenseTitle => 'Licencia de código abierto';

  @override
  String get disclaimerLicenseContent =>
      'El Software es de código abierto bajo la licencia GPL-3.0. Según esa licencia puedes ejecutarlo, estudiarlo, modificarlo y distribuirlo; al distribuir el Software o una versión modificada, debes proporcionar también su código fuente bajo GPL-3.0 y conservar los avisos de derechos de autor originales.\n\nLos componentes de terceros del Software, incluido el núcleo Clash.Meta, siguen sus propias licencias. Los autores originales no son responsables de los problemas de las versiones modificadas o distribuidas por otros.';

  @override
  String get disclaimerChangesTitle => 'Cambios en esta declaración';

  @override
  String get disclaimerChangesContent =>
      'Esta declaración puede revisarse en versiones posteriores; cada versión incluye la que le corresponde.';

  @override
  String get disclaimerAcceptTitle =>
      'Relación con la licencia de código abierto';

  @override
  String get disclaimerAcceptContent =>
      'Esta declaración explica la naturaleza, los riesgos y las responsabilidades del uso del Software. No es un término adicional a la GPL-3.0 ni limita ninguno de los derechos que esa licencia te otorga, incluidos los de ejecutar, copiar, modificar y distribuir el Software. Si ambas difieren, prevalece la GPL-3.0.';

  @override
  String get disclaimerRestateTitle => 'Repite la declaración';

  @override
  String get disclaimerRestateTip =>
      'Para confirmar que lo entiendes, escribe la siguiente declaración completa en el campo de abajo:';

  @override
  String get disclaimerRestateHint => 'Escribe la declaración anterior';

  @override
  String get disclaimerRestateMismatch => 'No coincide con la declaración';

  @override
  String get disclaimerAcknowledgeTitle => 'Confirma la declaración';

  @override
  String get disclaimerAcknowledgeTip =>
      'Para confirmar que lo entiendes, lee la siguiente declaración y marca la casilla de abajo:';

  @override
  String get disclaimerAcknowledgeLabel =>
      'He leído y entiendo esta declaración';

  @override
  String get agree => 'Aceptar';

  @override
  String get hotkeyManagement => 'Gestión de atajos';

  @override
  String get hotkeyDesc =>
      'Los atajos globales funcionan incluso con la ventana oculta. Toca una acción para grabar su combinación de teclas.';

  @override
  String get hotkeyNotSet => 'Sin asignar';

  @override
  String get pressKeyboard => 'Pulsa una combinación de teclas';

  @override
  String hotkeyNeedsModifier(Object modifiers) {
    return 'Incluye al menos una de estas teclas: $modifiers';
  }

  @override
  String hotkeyConflictWith(Object action) {
    return 'Ya lo usa “$action”. Al guardar, pasará a este.';
  }

  @override
  String get hotkeyUnavailable =>
      'No registrado; puede que otra app lo esté usando';

  @override
  String get remove => 'Quitar';

  @override
  String get noNetwork => 'Sin red';

  @override
  String get exportLogs => 'Exportar registros';

  @override
  String get exportSuccess => 'Exportación completada';

  @override
  String get iconStyle => 'Estilo de icono';

  @override
  String get iconStyleFilled => 'Relleno';

  @override
  String get iconStylePlain => 'Simple';

  @override
  String get iconStyleHidden => 'Oculto';

  @override
  String get filter => 'Filtro';

  @override
  String get groupBy => 'Agrupar por';

  @override
  String get hideTimeoutProxies => 'Ocultar proxies sin respuesta';

  @override
  String get stackMode => 'Modo de pila';

  @override
  String get network => 'Red';

  @override
  String get bypassDomain => 'Dominios excluidos';

  @override
  String get pacMode => 'Modo PAC';

  @override
  String get pacScript => 'Script PAC';

  @override
  String get bypassDomainDesc =>
      'Los dominios excluidos solo se aplican mientras el proxy del sistema esté activado.';

  @override
  String get bypassLocalWindowsOnly =>
      'Solo Windows: nombres de host sin punto';

  @override
  String get resetTip => '¿Seguro que quieres restablecer?';

  @override
  String get icon => 'Icono';

  @override
  String get noData => 'Sin datos';

  @override
  String get fontFamily => 'Familia de fuente';

  @override
  String get installedFonts => 'Fuentes instaladas';

  @override
  String get toggle => 'Alternar';

  @override
  String get system => 'Sistema';

  @override
  String get routeAddress => 'Direcciones de ruta';

  @override
  String get interfaceNameMode => 'Interfaz de salida';

  @override
  String get interfaceNameModeClear => 'Ninguna';

  @override
  String get interfaceNameModeFollow => 'Seguir configuración';

  @override
  String get interfaceNameModeCustom => 'Personalizada';

  @override
  String get interfaceName => 'Nombre de interfaz';

  @override
  String get copyEnvVar => 'Copiar variables de entorno';

  @override
  String get memoryInfo => 'Información de memoria';

  @override
  String get total => 'Total';

  @override
  String get releaseMemory => 'Liberar memoria';

  @override
  String get memoryCoreHeapInuse => 'Heap en uso';

  @override
  String get memoryCoreHeapIdle => 'Heap inactivo';

  @override
  String get memoryCoreStack => 'Pilas de goroutines';

  @override
  String get memoryCoreRuntime => 'Sobrecarga del runtime';

  @override
  String get memoryCoreNotRunning => 'El núcleo no se está ejecutando';

  @override
  String get memoryAppResident => 'Memoria residente';

  @override
  String get memoryAppShared => 'App y compartida';

  @override
  String get memoryEstimateDesc =>
      'Estimado a partir de la memoria residente del proceso; puede diferir de lo que indica el sistema.';

  @override
  String get memoryEstimateSharedDesc =>
      'El núcleo se ejecuta dentro del proceso de la app. Su parte se estima a partir de las estadísticas del runtime, y el resto cuenta como memoria de la app y compartida.';

  @override
  String get memoryReleased => 'Memoria liberada';

  @override
  String memoryReleasedSize(Object size) {
    return 'Liberado: $size';
  }

  @override
  String get releaseMemoryFailed => 'No se pudo liberar la memoria';

  @override
  String get dialog => 'Diálogo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get fileIsUpdate =>
      'El archivo se ha modificado. ¿Guardar los cambios?';

  @override
  String get profileHasUpdate =>
      'El perfil se ha modificado. ¿Desactivar la actualización automática?';

  @override
  String get hasCacheChange => '¿Guardar los cambios en la caché?';

  @override
  String get copySuccess => 'Copiado correctamente';

  @override
  String get copyLink => 'Copiar enlace';

  @override
  String get exportFile => 'Exportar archivo';

  @override
  String get cacheCorrupt => 'La caché está dañada. ¿Borrarla?';

  @override
  String get detectionTip =>
      'Depende de una API de terceros; solo con fines informativos';

  @override
  String get listen => 'Escucha';

  @override
  String get undo => 'Deshacer';

  @override
  String get redo => 'Rehacer';

  @override
  String get lineWrap => 'Ajuste de línea';

  @override
  String get none => 'Ninguno';

  @override
  String get advancedConfig => 'Configuración avanzada';

  @override
  String get addRule => 'Añadir regla';

  @override
  String get content => 'Contenido';

  @override
  String get ruleTarget => 'Destino de la regla';

  @override
  String get exitDefault => 'Predeterminado';

  @override
  String get customExit => 'Salida personalizada';

  @override
  String get inputExitName => 'Introduce el nombre de la salida';

  @override
  String get scriptFailed => 'El script falló';

  @override
  String get sourceIp => 'IP de origen';

  @override
  String get noResolve => 'No resolver IP';

  @override
  String get saveChanges => '¿Guardar los cambios?';

  @override
  String get applyNow => 'Aplicar ahora';

  @override
  String get applied => 'Aplicado';

  @override
  String get cannotSave => 'No se puede guardar';

  @override
  String get navigationBarStyle => 'Barra inferior';

  @override
  String get floating => 'Flotante';

  @override
  String get docked => 'Fija';

  @override
  String get slide => 'Deslizar';

  @override
  String get fade => 'Fundido';

  @override
  String get pureBlack => 'Negro puro';

  @override
  String get customColor => 'Color personalizado';

  @override
  String get colorStyle => 'Estilo de color';

  @override
  String get grid => 'Cuadrícula';

  @override
  String get spectrum => 'Espectro';

  @override
  String get sliders => 'Reguladores';

  @override
  String get hue => 'Tono';

  @override
  String get saturation => 'Saturación';

  @override
  String get brightness => 'Brillo';

  @override
  String get hex => 'Hex';

  @override
  String get monochromeScheme => 'Monocromo';

  @override
  String get vividStyle => 'Vivo';

  @override
  String get tintedStyle => 'Tintado';

  @override
  String get softStyle => 'Suave';

  @override
  String get developerMode => 'Modo desarrollador';

  @override
  String get developerModeEnableTip => 'El modo desarrollador está activado.';

  @override
  String get messageTest => 'Prueba de mensaje';

  @override
  String get messageTestTip => 'Esto es un mensaje.';

  @override
  String get crashTest => 'Prueba de fallo';

  @override
  String get crashDetected => 'Fallo detectado';

  @override
  String crashDetectedTip(Object name) {
    return 'La app no pudo terminar de iniciarse dos veces seguidas. Para romper el ciclo, se ha deseleccionado el perfil $name y se ha omitido la configuración automática. Puedes volver a seleccionarlo en cualquier momento.';
  }

  @override
  String get launchInterrupted => 'El inicio no se completó';

  @override
  String get launchInterruptedTip =>
      'La última vez, la app se cerró inesperadamente mientras se iniciaba. En este inicio se ha omitido la configuración automática; puedes iniciarla manualmente para reintentarlo.';

  @override
  String get clearData => 'Borrar datos';

  @override
  String get textScale => 'Escala del texto';

  @override
  String get textScalePreview => 'Así se verá el texto en la app';

  @override
  String get followSystem => 'Seguir el sistema';

  @override
  String get internet => 'Internet';

  @override
  String get systemApp => 'Apps del sistema';

  @override
  String get noNetworkApp => 'Apps sin red';

  @override
  String get restoreStrategy => 'Estrategia de restauración';

  @override
  String get restoreStrategyOverride => 'Sobrescribir';

  @override
  String get restoreStrategyCompatible => 'Compatible';

  @override
  String get logsTest => 'Prueba de registros';

  @override
  String emptyTip(Object label) {
    return '$label no puede estar vacío';
  }

  @override
  String urlTip(Object label) {
    return '$label debe ser una URL';
  }

  @override
  String get invalidLinkTip =>
      'No es un enlace de suscripción ni un enlace para compartir proxies';

  @override
  String numberTip(Object label) {
    return '$label debe ser un número';
  }

  @override
  String numberRangeTip(Object label, Object min, Object max) {
    return '$label debe estar entre $min y $max';
  }

  @override
  String get interval => 'Intervalo';

  @override
  String existsTip(Object label) {
    return '$label ya existe';
  }

  @override
  String maxLengthTip(Object label, Object max) {
    return '$label debe tener como máximo $max caracteres';
  }

  @override
  String get singleImport => 'Importar uno';

  @override
  String get batchImport => 'Importar en lote';

  @override
  String get batchUrlInputTip => 'Una URL por línea';

  @override
  String get batchLinkInputTip => 'Un enlace por línea';

  @override
  String batchPreviewTip(Object count, Object skipped) {
    return '$count por añadir, $skipped omitidos por ya existir';
  }

  @override
  String lineIssueTip(Object line, Object message) {
    return 'Línea $line: $message';
  }

  @override
  String singleValueTip(Object label) {
    return '$label debe ser un solo elemento';
  }

  @override
  String deleteTip(Object label) {
    return '¿Seguro que quieres eliminar este elemento ($label)?';
  }

  @override
  String deleteMultipTip(Object label) {
    return '¿Seguro que quieres eliminar los elementos seleccionados ($label)?';
  }

  @override
  String nullTip(Object label) {
    return 'Aún no hay ningún elemento ($label)';
  }

  @override
  String get script => 'Script';

  @override
  String get color => 'Color';

  @override
  String get unnamed => 'Sin nombre';

  @override
  String get pleaseEnterScriptName => 'Introduce un nombre para el script';

  @override
  String get mixedPort => 'Puerto mixto';

  @override
  String get socksPort => 'Puerto SOCKS';

  @override
  String get redirPort => 'Puerto Redir';

  @override
  String get tproxyPort => 'Puerto TProxy';

  @override
  String portTip(Object label) {
    return '$label debe estar entre 1024 y 49151';
  }

  @override
  String get portConflictTip => 'Introduce un puerto diferente';

  @override
  String get import => 'Importar';

  @override
  String get importFile => 'Importar desde archivo';

  @override
  String get importUrl => 'Importar desde URL';

  @override
  String get startFromScratch => 'Empezar desde cero';

  @override
  String details(Object label) {
    return 'Detalles de $label';
  }

  @override
  String get creationTime => 'Fecha de creación';

  @override
  String get process => 'Proceso';

  @override
  String get host => 'Host';

  @override
  String get destination => 'Destino';

  @override
  String get destinationGeoIP => 'GeoIP de destino';

  @override
  String get destinationIPASN => 'ASN de la IP de destino';

  @override
  String get specialProxy => 'Proxy especial';

  @override
  String get specialRules => 'Reglas especiales';

  @override
  String get remoteDestination => 'Destino remoto';

  @override
  String get networkType => 'Tipo de red';

  @override
  String get proxyChains => 'Cadena de proxies';

  @override
  String get log => 'Registro';

  @override
  String get connection => 'Conexión';

  @override
  String get request => 'Solicitud';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String get connecting => 'Conectando…';

  @override
  String get restartCoreTip => '¿Seguro que quieres reiniciar el núcleo?';

  @override
  String get forceRestartCoreTip =>
      '¿Seguro que quieres forzar el reinicio del núcleo?';

  @override
  String get dnsHijacking => 'Secuestro de DNS';

  @override
  String get coreStatus => 'Estado del núcleo';

  @override
  String get appendSystemDns => 'Añadir DNS del sistema';

  @override
  String get editRule => 'Editar regla';

  @override
  String get addedRules => 'Reglas añadidas';

  @override
  String get addedRulesAfterScript =>
      'Se insertan tras ejecutar el script, antes de las reglas del perfil';

  @override
  String get controlGlobalAddedRules =>
      'Controlar las reglas añadidas globales';

  @override
  String get quickActions => 'Acciones rápidas';

  @override
  String get rulePresetBlockQuic => 'Bloquear QUIC';

  @override
  String get rulePresetBlockStun => 'Bloquear STUN';

  @override
  String get rulePresetBlockDot => 'Bloquear DNS sobre TLS';

  @override
  String get rulePresetBlockLoopback => 'Bloquear bucle del proxy';

  @override
  String get rulePresetSystemServicesDirect => 'Apple y Microsoft directos';

  @override
  String get rulePresetBittorrentDirect => 'BitTorrent directo';

  @override
  String get rulePresetLanDirect => 'LAN directa';

  @override
  String get extendScript => 'Script de extensión';

  @override
  String get goToConfigureScript => 'Ir a la configuración del script';

  @override
  String get goToConfigureAddedRules =>
      'Ir a la configuración de las reglas añadidas';

  @override
  String get editGlobalRules => 'Editar reglas globales';

  @override
  String get confirmForceCrashCore =>
      '¿Seguro que quieres forzar el fallo del núcleo?';

  @override
  String get confirmClearAllData =>
      '¿Seguro que quieres borrar todos los datos?';

  @override
  String get loading => 'Cargando…';

  @override
  String yearsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count años',
      one: 'hace 1 año',
    );
    return '$_temp0';
  }

  @override
  String monthsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count meses',
      one: 'hace 1 mes',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count días',
      one: 'hace 1 día',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count horas',
      one: 'hace 1 hora',
    );
    return '$_temp0';
  }

  @override
  String minutesAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count minutos',
      one: 'hace 1 minuto',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Ahora mismo';

  @override
  String yearsAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count a',
    );
    return '$_temp0';
  }

  @override
  String monthsAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count m',
    );
    return '$_temp0';
  }

  @override
  String daysAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count d',
    );
    return '$_temp0';
  }

  @override
  String hoursAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count h',
    );
    return '$_temp0';
  }

  @override
  String minutesAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count min',
    );
    return '$_temp0';
  }

  @override
  String get noLongerRemind => 'No volver a recordármelo';

  @override
  String get turnOn => 'Activar';

  @override
  String get turnOff => 'Desactivar';

  @override
  String get vpnConfigChangeDetected =>
      'La configuración de la VPN cambió. Toca para reiniciar';

  @override
  String get restart => 'Reiniciar';

  @override
  String get speedStatistics => 'Estadísticas de velocidad';

  @override
  String get resetPageChangesTip =>
      'Esta página tiene cambios. ¿Seguro que quieres restablecer?';

  @override
  String get customProfile => 'Personalizado';

  @override
  String get customResources => 'Personalizado';

  @override
  String get unknownNetworkError => 'Error de red desconocido';

  @override
  String get backupFromNewerVersion =>
      'Esta copia de seguridad procede de una versión más reciente de la app. Actualiza la app antes de restaurarla';

  @override
  String get networkTimeoutError =>
      'Se agotó el tiempo de espera de la solicitud. Comprueba tu red o el proxy e inténtalo de nuevo';

  @override
  String get networkHostLookupError =>
      'No se pudo resolver la dirección del servidor. Comprueba que la URL sea correcta y que el DNS funcione';

  @override
  String get monochromeIcon => 'Icono monocromo';

  @override
  String get networkConnectionError =>
      'No se pudo conectar con el servidor. Comprueba tu conexión de red o los ajustes del proxy';

  @override
  String get networkTlsError =>
      'Falló la conexión segura. Puede que el certificado del servidor no sea válido o que la conexión esté siendo interceptada';

  @override
  String get networkCancelledError => 'Se canceló la solicitud';

  @override
  String networkAccessDeniedError(Object code) {
    return 'El servidor denegó el acceso (HTTP $code). Puede que el enlace haya caducado o que las credenciales sean incorrectas';
  }

  @override
  String networkNotFoundError(Object code) {
    return 'No se encontró nada en esta dirección (HTTP $code). Comprueba que la URL sea correcta';
  }

  @override
  String get networkRateLimitedError =>
      'Demasiadas solicitudes (HTTP 429). Espera un momento e inténtalo de nuevo';

  @override
  String networkServerError(Object code) {
    return 'El servidor tuvo un problema (HTTP $code). Inténtalo de nuevo más tarde';
  }

  @override
  String networkBadResponseError(Object code) {
    return 'El servidor rechazó la solicitud (HTTP $code)';
  }

  @override
  String networkRequestFailed(Object detail) {
    return 'Falló la solicitud de red: $detail';
  }

  @override
  String get invalidBackupFile => 'Archivo de copia de seguridad no válido';

  @override
  String get pruneCache => 'Depurar caché';

  @override
  String get backupAndRestore => 'Copia de seguridad y restauración';

  @override
  String get restore => 'Restaurar';

  @override
  String get restoreSuccess => 'Restauración completada';

  @override
  String get restoreOnlyConfig => 'Restaurar solo los perfiles';

  @override
  String get restoreAllData => 'Restaurar todos los datos';

  @override
  String get addProfile => 'Añadir perfil';

  @override
  String get delayTest => 'Prueba de latencia';

  @override
  String get proxyGroupEmpty => 'El grupo de proxies está vacío';

  @override
  String get confirmExitWindow =>
      '¿Seguro que quieres salir de la ventana actual?';

  @override
  String get optional => 'Opcional';

  @override
  String get maxFailedTimes => 'Máximo de fallos';

  @override
  String get testInterval => 'Intervalo de prueba';

  @override
  String get excludeFilter => 'Filtro de exclusión';

  @override
  String get expectedStatus => 'Estado esperado';

  @override
  String get strategy => 'Estrategia';

  @override
  String get tolerance => 'Tolerancia';

  @override
  String get inputProxyGroupName => 'Introduce el nombre del grupo de proxies';

  @override
  String get helperCorruptTip =>
      'El servicio auxiliar (Helper) no está disponible; no se puede activar el modo TUN. Reinstala FlClash para restaurarlo.';

  @override
  String get tunAuthorizationFailed =>
      'No se pudo autorizar TUN, por lo que se desactivó.';

  @override
  String get sudoPasswordTitle => 'Introduce tu contraseña para sudo';

  @override
  String coreBlockedByPolicyTip(Object code) {
    return 'Windows se negó a ejecutar FlClashCore.exe (error $code). Una directiva de control de aplicaciones, como Smart App Control o AppLocker, bloquea los programas sin firmar; permite FlClash en esa directiva o desactívala e inténtalo de nuevo.';
  }

  @override
  String get coreBlockedBySmartAppControlTip =>
      'Smart App Control de Windows bloqueó FlClashCore.exe porque no está firmado. Abre Seguridad de Windows → Control de aplicaciones y navegador → Configuración de Smart App Control, elige Desactivado y vuelve a iniciar FlClash. Smart App Control no se puede volver a activar sin reinstalar Windows.';

  @override
  String get hideFromList => 'Ocultar de la lista';

  @override
  String get testWhenUsed => 'Probar al usarse';

  @override
  String get disableUDP => 'Desactivar UDP';

  @override
  String get confirmDeleteProxyGroup =>
      '¿Seguro que quieres eliminar este grupo de proxies?';

  @override
  String get ruleEmpty => 'La regla está vacía';

  @override
  String get inputRuleContent => 'Introduce el contenido de la regla';

  @override
  String get ruleSet => 'Conjunto de reglas';

  @override
  String get selectRuleSet => 'Selecciona un conjunto de reglas';

  @override
  String get splitStrategy => 'Estrategia de división';

  @override
  String get selectSplitStrategy => 'Selecciona una estrategia de división';

  @override
  String get noResolveHostname => 'No resolver nombre de host';

  @override
  String get matchSourceIp => 'Coincidir con IP de origen';

  @override
  String get basicInfo => 'Información básica';

  @override
  String get additionalParameters => 'Parámetros adicionales';

  @override
  String get proxyType => 'Tipo de proxy';

  @override
  String get basicStrategy => 'Estrategias básicas';

  @override
  String get editProxy => 'Editar proxy';

  @override
  String get addNodes => 'Añadir nodos';

  @override
  String get addProxyGroup => 'Añadir grupo de proxies';

  @override
  String get editProxyGroup => 'Editar grupo de proxies';

  @override
  String get iconUrl => 'URL del icono';

  @override
  String get iconRecords => 'Registros de iconos';

  @override
  String get custom => 'Personalizado';

  @override
  String get ruleActionDomainDesc => 'Coincide con el dominio completo';

  @override
  String get ruleActionDomainSuffixDesc => 'Coincide con un sufijo de dominio';

  @override
  String get ruleActionDomainKeywordDesc =>
      'Coincide con una palabra clave del dominio';

  @override
  String get ruleActionDomainRegexDesc =>
      'Coincide con una expresión regular de dominio';

  @override
  String get ruleActionDomainWildcardDesc =>
      'Coincidencia con comodines; solo se admiten * y ?';

  @override
  String get ruleActionGeositeDesc => 'Coincide con los dominios de Geosite';

  @override
  String get ruleActionIpCidrDesc => 'Coincide con un rango de direcciones IP';

  @override
  String get ruleActionIpCidr6Desc =>
      'Coincide con un rango de direcciones IP; IP-CIDR6 es solo un alias';

  @override
  String get ruleActionIpSuffixDesc => 'Coincide con un rango de sufijo de IP';

  @override
  String get ruleActionIpAsnDesc => 'Coincide con el ASN de la IP';

  @override
  String get ruleActionGeoipDesc => 'Coincide con el código de país de la IP';

  @override
  String get ruleActionSrcGeoipDesc =>
      'Coincide con el código de país de la IP de origen';

  @override
  String get ruleActionSrcIpAsnDesc => 'Coincide con el ASN de la IP de origen';

  @override
  String get ruleActionSrcIpCidrDesc =>
      'Coincide con un rango de direcciones IP de origen';

  @override
  String get ruleActionSrcIpSuffixDesc =>
      'Coincide con un rango de sufijo de IP de origen';

  @override
  String get ruleActionDstPortDesc =>
      'Coincide con el rango de puertos de destino';

  @override
  String get ruleActionSrcPortDesc =>
      'Coincide con el rango de puertos de origen';

  @override
  String get ruleActionInPortDesc => 'Coincide con el puerto de entrada';

  @override
  String get ruleActionInTypeDesc => 'Coincide con el tipo de entrada';

  @override
  String get ruleActionInUserDesc =>
      'Coincide con el nombre de usuario de entrada; separa varios usuarios con /';

  @override
  String get ruleActionInNameDesc => 'Coincide con el nombre de la entrada';

  @override
  String get ruleActionRematchNameDesc =>
      'Coincide con el nombre de rematch; separa varios nombres con /';

  @override
  String get ruleActionProcessPathDesc =>
      'Coincide con la ruta completa del proceso';

  @override
  String get ruleActionProcessPathRegexDesc =>
      'Coincide con una expresión regular de la ruta del proceso';

  @override
  String get ruleActionProcessPathWildcardDesc =>
      'Coincide con comodines en la ruta del proceso; solo se admiten * y ?';

  @override
  String get ruleActionProcessNameDesc =>
      'Coincide con el nombre del proceso; en Android coincide con el nombre del paquete';

  @override
  String get ruleActionProcessNameRegexDesc =>
      'Coincide con una expresión regular del nombre del proceso; en Android coincide con el nombre del paquete';

  @override
  String get ruleActionProcessNameWildcardDesc =>
      'Coincide con comodines en el nombre del proceso; solo se admiten * y ?';

  @override
  String get ruleActionUidDesc => 'Coincide con el ID de usuario de Linux';

  @override
  String get ruleActionNetworkDesc => 'Coincide con TCP o UDP';

  @override
  String get ruleActionDscpDesc =>
      'Coincide con la marca DSCP (solo entrada UDP de tproxy)';

  @override
  String get ruleActionRuleSetDesc =>
      'Hace referencia a un conjunto de reglas; requiere rule-providers';

  @override
  String get ruleActionAndDesc => 'Regla lógica AND';

  @override
  String get ruleActionOrDesc => 'Regla lógica OR';

  @override
  String get ruleActionNotDesc => 'Regla lógica NOT';

  @override
  String get ruleActionSubRuleDesc =>
      'Coincide con una subregla; cuidado con los paréntesis';

  @override
  String get ruleActionMatchDesc =>
      'Coincide con todas las solicitudes, sin necesidad de condiciones';

  @override
  String get contentNotEmpty => 'El contenido no puede estar vacío';

  @override
  String get splitStrategyNotEmpty =>
      'La estrategia de división no puede estar vacía';

  @override
  String get timeout => 'Tiempo agotado';

  @override
  String get delayFailed => 'Fallido';

  @override
  String invalidSubRule(Object subRule) {
    return '$subRule no es una SUB_RULE válida';
  }

  @override
  String invalidPolicy(Object target) {
    return '$target no es una política válida';
  }

  @override
  String invalidProxyProvider(Object providerName) {
    return '$providerName no es un proveedor de proxies válido';
  }

  @override
  String invalidRuleSet(Object ruleSet) {
    return '$ruleSet no es un conjunto de reglas válido';
  }

  @override
  String get invalidNetworkContent => 'Solo se admite tcp o udp';

  @override
  String get invalidRangeContent =>
      'Introduce números o rangos como 80 u 8000-9000, separados por /';

  @override
  String get invalidDscpContent => 'Una marca DSCP no puede superar 63';

  @override
  String get invalidCidrContent =>
      'Introduce un rango de IP en formato CIDR, como 192.168.0.0/16';

  @override
  String get invalidPortRangeContent =>
      'Introduce un puerto o un rango como 443 u 8000-9000';

  @override
  String get invalidHostContent => 'Introduce un dominio o una dirección IP';

  @override
  String get invalidListenContent =>
      'Introduce una dirección y un puerto, como 0.0.0.0:1053';

  @override
  String invalidProxy(Object proxyName) {
    return '$proxyName no es un proxy válido';
  }

  @override
  String get locationPermissionRequired => 'Se requiere permiso de ubicación';

  @override
  String locationPermissionGuide(Object appName) {
    return '1. Abre Ajustes del sistema > Privacidad y seguridad\n2. Elige Servicios de localización\n3. Busca $appName en la lista y márcalo\n\nCuando termines, vuelve a la app para continuar. Gracias por tu colaboración.';
  }

  @override
  String get prerequisites => 'Requisitos previos';

  @override
  String get ignoreBatteryOptimization => 'Ignorar optimización de batería';

  @override
  String get locationPermission => 'Permiso de ubicación';

  @override
  String get locationPermissionDesc =>
      'El sistema requiere el permiso de ubicación para leer el nombre de la red Wi-Fi. En Android elige “Permitir todo el tiempo”; de lo contrario, no se podrá leer el nombre de la red Wi-Fi mientras la app esté en segundo plano.';

  @override
  String get excludeSsids => 'Excluir SSID';

  @override
  String get excludeSsidsDesc =>
      'Al conectarte a una red Wi-Fi con un SSID excluido, el estado de ejecución de la app cambia automáticamente.';

  @override
  String get ssidsEmpty => 'No hay SSID';

  @override
  String get onDemand => 'Bajo demanda';

  @override
  String get locationPermissionDeniedMessage =>
      'Se denegó el permiso de ubicación, por lo que no se puede leer el nombre de la red Wi-Fi actual. Activa el permiso de ubicación manualmente en los ajustes del sistema.';

  @override
  String get addSsid => 'Añadir SSID';

  @override
  String get editSsid => 'Editar SSID';

  @override
  String get authorized => 'Autorizado';

  @override
  String get tapToAuthorize => 'Toca para autorizar';

  @override
  String get suspended => 'Suspendido…';

  @override
  String get resourceUpdateInterval => 'Intervalo de actualización automática';

  @override
  String get resourceUpdateIntervalTip =>
      'El intervalo de actualización automática debe ser mayor que 0';

  @override
  String get hours => 'horas';

  @override
  String get minutes => 'minutos';

  @override
  String get geoResources => 'Geo';

  @override
  String geoSkipped(Object name) {
    return '$name ya está actualizado';
  }

  @override
  String geoUpdated(Object name) {
    return '$name actualizado';
  }

  @override
  String secondsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count segundos',
      one: '1 segundo',
    );
    return '$_temp0';
  }

  @override
  String proxiesCount(num count, Object label) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$label proxies',
      one: '1 proxy',
    );
    return '$_temp0';
  }

  @override
  String rulesCount(num count, Object label) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$label reglas',
      one: '1 regla',
    );
    return '$_temp0';
  }

  @override
  String proxyGroupsCount(num count, Object label) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$label grupos de proxies',
      one: '1 grupo de proxies',
    );
    return '$_temp0';
  }

  @override
  String get changelogBreaking => 'Cambios incompatibles';

  @override
  String get changelogFeatures => 'Novedades';

  @override
  String get changelogFixes => 'Correcciones';

  @override
  String get changelogPerformance => 'Rendimiento';

  @override
  String get changelogReverts => 'Reversiones';

  @override
  String get close => 'Cerrar';

  @override
  String get back => 'Atrás';

  @override
  String get minimize => 'Minimizar';

  @override
  String get maximize => 'Maximizar';

  @override
  String get unmaximize => 'Restaurar tamaño';

  @override
  String get pinWindow => 'Fijar ventana';

  @override
  String get unpinWindow => 'Desfijar ventana';

  @override
  String get exitFullScreen => 'Salir de pantalla completa';

  @override
  String get torch => 'Linterna';

  @override
  String get pickFromAlbum => 'Elegir del álbum';

  @override
  String get closeConnections => 'Cerrar conexiones';

  @override
  String get scrollToSelected => 'Ir a la selección';

  @override
  String get showMore => 'Expandir';

  @override
  String get showLess => 'Contraer';

  @override
  String get previousMatch => 'Coincidencia anterior';

  @override
  String get nextMatch => 'Coincidencia siguiente';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get noSearchResults => 'No hay resultados';

  @override
  String get showPassword => 'Mostrar contraseña';

  @override
  String get hidePassword => 'Ocultar contraseña';

  @override
  String get authorize => 'Autorizar';

  @override
  String get installedAppsPermissionRequired =>
      'Se requiere permiso de lista de apps';

  @override
  String get installedAppsPermissionDesc =>
      'Este sistema oculta la lista de apps instaladas hasta que se concede el permiso. Autorízalo para configurar el proxy por app.';

  @override
  String get installedAppsPermissionDeniedMessage =>
      'Se denegó el permiso de lista de apps, por lo que no se pueden mostrar las apps instaladas. Concédelo manualmente en los ajustes del sistema.';

  @override
  String get outboundIp => 'IP de salida';

  @override
  String get ipAddress => 'Dirección IP';

  @override
  String get ipQualityLevel => 'Nivel';

  @override
  String get ipQualityGood => 'Buena';

  @override
  String get ipQualityNormal => 'Normal';

  @override
  String get ipQualityRisky => 'Arriesgada';

  @override
  String get ipType => 'Tipo';

  @override
  String get ipTypeResidential => 'Residencial';

  @override
  String get ipTypeMobile => 'Red móvil';

  @override
  String get ipTypeBusiness => 'Empresarial';

  @override
  String get ipTypeHosting => 'Centro de datos';

  @override
  String get ipFlags => 'Indicadores';

  @override
  String get ipFlagProxy => 'Proxy';

  @override
  String get ipFlagVpn => 'VPN';

  @override
  String get ipFlagTor => 'Tor';

  @override
  String get ipFlagAbuser => 'Historial de abusos';

  @override
  String get ipOrganization => 'Organización';

  @override
  String get ipAsn => 'ASN';

  @override
  String get ipQualitySource => 'Respondido por';

  @override
  String get ipQualitySources => 'Fuentes';

  @override
  String get ipQualityFailed => 'No se pudo determinar el tipo de IP';

  @override
  String get ipQualityRetry => 'Comprobar de nuevo';

  @override
  String get ipSourceNoType => 'Sin tipo';

  @override
  String get ipSourceRateLimited => 'Límite de solicitudes';

  @override
  String get ipSourceIpMismatch => 'IP de salida distinta';

  @override
  String get hideIp => 'Ocultar IP';

  @override
  String get editorUnavailable => 'Editor no disponible';

  @override
  String get replace => 'Reemplazar';

  @override
  String get replaceAll => 'Reemplazar todo';

  @override
  String get cameraPermissionRequired => 'Se requiere permiso de cámara';

  @override
  String get cameraPermissionDesc =>
      'Permite el acceso a la cámara en los ajustes del sistema para escanear códigos QR, o elige una imagen de código QR del álbum.';

  @override
  String get cameraUnavailable => 'Cámara no disponible';

  @override
  String get retry => 'Reintentar';

  @override
  String get invalidProfileQrcode =>
      'Este código QR no contiene un enlace de perfil';

  @override
  String get dnsQueries => 'Consultas DNS';

  @override
  String get recordType => 'Tipo de registro';

  @override
  String get answers => 'Respuestas';

  @override
  String get responseCode => 'Código de respuesta';

  @override
  String get error => 'Error';

  @override
  String get initiator => 'Origen de la solicitud';

  @override
  String get cache => 'Caché';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get nonTextProviderFile =>
      'Este recurso externo no es un archivo de texto';

  @override
  String get addCustomProxy => 'Añadir proxy';

  @override
  String get definitionNotMap =>
      'La configuración debe ser un mapa YAML con un nombre y un tipo';

  @override
  String get ruleTextInvalid =>
      'La regla debe empezar con un tipo admitido, por ejemplo DOMAIN,example.com,DIRECT';

  @override
  String get ruleListInvalid =>
      'Las reglas deben ser una lista YAML con una regla por elemento, por ejemplo - DOMAIN,example.com,DIRECT';

  @override
  String get shareLinksInvalid => 'No se pudo leer ningún proxy de los enlaces';

  @override
  String shareLinkUnreadable(Object link) {
    return 'No se pudo leer ningún proxy de $link';
  }

  @override
  String proxiesProfileLabel(Object name, Object count) {
    return '$name y otros ($count proxies)';
  }

  @override
  String get singleShareLinkOnly =>
      'Introduce aquí un solo enlace; para varios, usa la edición rápida de la lista';

  @override
  String get username => 'Usuario';

  @override
  String get emptyFallback => 'Respaldo si está vacío';

  @override
  String get defaultSelected => 'Selección predeterminada';

  @override
  String get hashByInUser => 'Hash por usuario de entrada';

  @override
  String get appProxiesEmpty => 'No hay proxies locales';

  @override
  String get nodes => 'Nodos';

  @override
  String get localProxies => 'Proxies locales';

  @override
  String get customIssueEmptyName => 'El nombre está vacío';

  @override
  String customIssueReservedName(Object name) {
    return '$name es un nombre de política integrada y no se puede usar aquí';
  }

  @override
  String customIssueDuplicateName(Object name) {
    return 'El nombre $name ya lo usa otro proxy o grupo de proxies';
  }

  @override
  String customIssueCoreRejected(Object message) {
    return 'El núcleo no puede interpretar este proxy: $message';
  }

  @override
  String customIssueMissingProxies(Object names) {
    return 'Estos proxies o políticas no existen: $names';
  }

  @override
  String customIssueMissingProviders(Object names) {
    return 'Estos proveedores de proxies no existen: $names';
  }

  @override
  String get customIssueNoProxySource =>
      'No hay proxies ni proveedores de proxies seleccionados, por lo que el núcleo rechaza este grupo';

  @override
  String customIssueGroupLoop(Object path) {
    return 'Los grupos de proxies se referencian entre sí en bucle: $path';
  }

  @override
  String customIssueInvalidEmptyFallback(Object name) {
    return 'El respaldo si está vacío debe ser un proxy, pero $name no existe o es un grupo de proxies';
  }

  @override
  String customIssueInvalidFilter(Object name, Object message) {
    return '$name no es una expresión regular válida: $message';
  }

  @override
  String customIssueMissingDialer(Object name) {
    return 'El proxy de marcación $name no existe';
  }

  @override
  String customIssueDialerLoop(Object proxy, Object target) {
    return '$proxy marca a través de $target, que lleva de vuelta a $proxy, por lo que la marcación entra en bucle';
  }

  @override
  String dialerProxyLoopStopped(Object name) {
    return 'La marcación a través de $name lleva de vuelta al proxy que lo usa, por lo que se detuvo la conexión';
  }

  @override
  String customIssuesSummary(Object count) {
    return '$count elementos tienen problemas, y aplicar este perfil puede fallar';
  }

  @override
  String providerInUse(Object label, Object profiles) {
    return '$label sigue en uso en $profiles, que dejarán de funcionar correctamente si se elimina. ¿Seguro que quieres eliminarlo?';
  }

  @override
  String proxyGroupInUse(Object label) {
    return '$label sigue mencionado por reglas, grupos de proxies, proxies de marcación, DNS o NTP de este perfil, que dejarán de funcionar si se elimina. ¿Seguro que quieres eliminarlo?';
  }

  @override
  String proxiesRemovedTip(Object removed) {
    return 'Se eliminarán estos proxies: $removed. Una línea cuyo nombre cambió cuenta como un proxy nuevo, y los perfiles personalizados que mencionen los eliminados los marcarán como ausentes. ¿Aplicar de todos modos?';
  }

  @override
  String proxiesReplacedTip(Object removed, Object added) {
    return 'Se eliminarán estos proxies: $removed. Se añadirán estos: $added. Una línea cuyo nombre cambió cuenta como un proxy nuevo, y los perfiles personalizados que mencionen los eliminados los marcarán como ausentes. ¿Aplicar de todos modos?';
  }

  @override
  String get fontSize => 'Tamaño';

  @override
  String get large => 'Grande';

  @override
  String get extraLarge => 'Muy grande';

  @override
  String get switchProfile => 'Cambiar de perfil';

  @override
  String get lastUpdated => 'Última actualización';

  @override
  String get filters => 'Filtros';

  @override
  String get label => 'Etiqueta';

  @override
  String get regex => 'Expresión regular';

  @override
  String get matchCase => 'Coincidir mayúsculas y minúsculas';

  @override
  String get iconSets => 'Conjuntos de iconos';

  @override
  String get invalidIconSet => 'No es un conjunto de iconos válido';

  @override
  String get recommendedIcons => 'Sugeridos';

  @override
  String get localImage => 'Imagen local';

  @override
  String get iconSetsEmptyTip =>
      'Aún no hay conjuntos de iconos. Añádelos en Recursos de perfil personalizado → Conjuntos de iconos';

  @override
  String get outbound => 'Salida';

  @override
  String get strictRoute => 'Ruta estricta';

  @override
  String get congestionController => 'Control de congestión TCP';

  @override
  String get congestionControllerDesc =>
      'El control de congestión TCP solo funciona con la pila mips.';

  @override
  String get routeExcludeAddress => 'Direcciones excluidas de la ruta';

  @override
  String get keepAliveIdle => 'Inactividad de keep-alive TCP';

  @override
  String get disableKeepAlive => 'Desactivar keep-alive TCP';

  @override
  String get routingMark => 'Marca de enrutamiento';

  @override
  String get strictRouteDesc =>
      'La ruta estricta evita que el tráfico, como el DNS, eluda TUN y, con IPv6 desactivado, bloquea las conexiones IPv6 de este dispositivo.';

  @override
  String get initFailed => 'Error al iniciar';

  @override
  String get initFailedTip =>
      'FlClash encontró un error al iniciarse y no puede continuar. Copia los detalles para informar del problema. Si sigue ocurriendo, borrar los datos suele permitir que la app vuelva a iniciarse.';

  @override
  String get errorDetails => 'Detalles del error';

  @override
  String get stackTrace => 'Seguimiento de pila';

  @override
  String get clearDataAndExitTip =>
      'Esto elimina todos los perfiles, ajustes y datos locales, y luego cierra la app. Ábrela de nuevo para empezar de cero.';

  @override
  String clearDataFailed(Object detail) {
    return 'No se pudieron borrar los datos: $detail';
  }

  @override
  String get bypassPrivateRoute => 'Omitir direcciones privadas';

  @override
  String get disableIcmpForwarding => 'Desactivar reenvío ICMP';

  @override
  String get disableIcmpForwardingDesc =>
      'Con el reenvío ICMP desactivado, TUN responde él mismo al ping, por lo que ping ya no muestra la latencia real.';

  @override
  String get excludeInterface => 'Interfaces excluidas';

  @override
  String get includeInterface => 'Interfaces incluidas';

  @override
  String get includeInterfaceDesc =>
      'Solo el tráfico que llega por las interfaces incluidas pasa por TUN, y las interfaces excluidas dejan de aplicarse.';

  @override
  String get includeUid => 'ID de usuario incluidos';

  @override
  String get excludeUid => 'ID de usuario excluidos';

  @override
  String get excludeSrcPort => 'Puertos de origen excluidos';

  @override
  String get excludeDstPort => 'Puertos de destino excluidos';

  @override
  String get udpTimeout => 'Tiempo de espera UDP';

  @override
  String get udpTimeoutDesc =>
      'El tiempo de espera UDP se indica en segundos y solo funciona con las pilas gvisor, system y mixed.';

  @override
  String get dnsHijackDesc =>
      'Sin esta entrada, TUN secuestra todas las consultas DNS al puerto 53 (any:53).';

  @override
  String get tunOverrideDesc =>
      'Las entradas añadidas aquí sustituyen los ajustes de TUN de todos los perfiles; lo que no añadas conserva el ajuste del propio perfil. Las entradas que añade un perfil personalizado tienen prioridad.';

  @override
  String get generalOverrideDesc =>
      'Las entradas añadidas aquí sustituyen el ajuste correspondiente de todos los perfiles; lo que no añadas conserva el ajuste del propio perfil, o el valor predeterminado del núcleo si el perfil no lo define.';

  @override
  String get profileTunSettingsDesc =>
      'Se aplica solo a este perfil y tiene prioridad sobre las entradas de sobrescritura de TUN de los ajustes de red.';

  @override
  String settingsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ajustes',
      one: '1 ajuste',
    );
    return '$_temp0';
  }

  @override
  String sectionsInEffect(Object count) {
    return '$count en vigor';
  }

  @override
  String itemsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementos',
      one: '1 elemento',
    );
    return '$_temp0';
  }

  @override
  String get additionalPrefix => 'Prefijo del nombre';

  @override
  String get additionalSuffix => 'Sufijo del nombre';

  @override
  String get skipCertVerify => 'Omitir verificación de certificado';

  @override
  String get ipVersion => 'Versión de IP';

  @override
  String get addFilters => 'Añadir filtros';

  @override
  String failedItem(Object label, Object message) {
    return '$label: $message';
  }

  @override
  String failedCount(Object count) {
    return '$count elementos fallaron. Toca para ver';
  }

  @override
  String get importConfigInvalid =>
      'Este archivo no es una configuración importable';

  @override
  String get importConfigReplaceTip =>
      'Al importar se reemplazan los grupos de proxies, las reglas y los ajustes que tiene ahora este perfil';

  @override
  String get networkName => 'Nombre de la red';

  @override
  String get networkSecret => 'Clave de la red';

  @override
  String get peers => 'Pares';

  @override
  String get virtualIpv4 => 'IPv4 virtual';

  @override
  String get hostname => 'Nombre de host';

  @override
  String get exitNodes => 'Nodos de salida';

  @override
  String get cipher => 'Cifrado';

  @override
  String get protocol => 'Protocolo';

  @override
  String get protocolParam => 'Parámetro del protocolo';

  @override
  String get obfs => 'Ofuscación';

  @override
  String get obfsParam => 'Parámetro de ofuscación';

  @override
  String get obfsPassword => 'Contraseña de ofuscación';

  @override
  String get obfsMode => 'Modo de ofuscación';

  @override
  String get obfsHost => 'Host de ofuscación';

  @override
  String get plugin => 'Complemento';

  @override
  String get pluginMode => 'Modo del complemento';

  @override
  String get pluginHost => 'Host del complemento';

  @override
  String get pluginPath => 'Ruta del complemento';

  @override
  String get pluginUsername => 'Usuario del complemento';

  @override
  String get pluginPassword => 'Contraseña del complemento';

  @override
  String get pluginCipher => 'Cifrado del complemento';

  @override
  String get privateKey => 'Clave privada';

  @override
  String get publicKey => 'Clave pública';

  @override
  String get privateKeyPassphrase => 'Frase de contraseña de la clave privada';

  @override
  String get preSharedKey => 'Clave precompartida';

  @override
  String get secretKey => 'Clave';

  @override
  String get transport => 'Transporte';

  @override
  String get uploadBandwidth => 'Ancho de banda de subida';

  @override
  String get downloadBandwidth => 'Ancho de banda de descarga';

  @override
  String get protocolVersion => 'Versión del protocolo';

  @override
  String get portHopping => 'Salto de puertos';

  @override
  String get hopInterval => 'Intervalo de salto';

  @override
  String get congestionControl => 'Control de congestión';

  @override
  String get udpRelayMode => 'Modo de retransmisión UDP';

  @override
  String get allowedIps => 'IP permitidas';

  @override
  String get remoteDnsResolve => 'Resolución DNS remota';

  @override
  String get clientFingerprint => 'Huella del cliente';

  @override
  String get requestHeaders => 'Encabezados de solicitud';

  @override
  String transportHeaders(Object transport) {
    return 'Encabezados $transport';
  }

  @override
  String get required => 'Obligatorio';

  @override
  String get ageSecretKey => 'Clave secreta de age';

  @override
  String get ageEncryptedProfile => 'Perfil cifrado';

  @override
  String get ageSecretKeyRequiredTip =>
      'Este perfil está cifrado con age y necesita una clave secreta de age para descifrarse';

  @override
  String get currentOutboundDesc =>
      'Contiene el botón de inicio y no se puede quitar';

  @override
  String get running => 'En ejecución';

  @override
  String get root => 'Root';

  @override
  String get notRunning => 'Detenido';

  @override
  String trafficPeak(Object value) {
    return 'Pico: $value';
  }

  @override
  String trafficTotal(Object value) {
    return 'Total: $value';
  }

  @override
  String get ipQualityShort => 'Calidad';

  @override
  String get ipTypeUnknown => 'Tipo desconocido';

  @override
  String get tapIconToRetry => 'Toca el icono para reintentar';

  @override
  String get networkTakeover => 'Control del tráfico';

  @override
  String portValue(Object port) {
    return 'Puerto $port';
  }

  @override
  String serviceAbnormalCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count problemas',
      one: '1 problema',
    );
    return '$_temp0';
  }

  @override
  String get serviceAllAvailable => 'Todo disponible';

  @override
  String get serviceShownOnDashboard => 'Se muestra en el panel';

  @override
  String groupTimeoutCount(Object count) {
    return '$count sin respuesta';
  }

  @override
  String get groupCountUnit => 'grupos';

  @override
  String groupCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grupos',
      one: '1 grupo',
    );
    return '$_temp0';
  }

  @override
  String get proxyGroupsAfterStart =>
      'Los grupos aparecen aquí cuando se inicia el núcleo';

  @override
  String get usedShort => 'usado';

  @override
  String profileUpdatedAt(Object time) {
    return 'Actualizado $time';
  }

  @override
  String profileExpiresIn(Object date, num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'quedan $days días',
      one: 'queda 1 día',
    );
    return 'Vence el $date, $_temp0';
  }

  @override
  String profileDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Quedan $days días',
      one: 'Queda 1 día',
    );
    return '$_temp0';
  }

  @override
  String get target => 'Destino';

  @override
  String get outboundExit => 'Salida';

  @override
  String get duration => 'Duración';

  @override
  String get traffic => 'Tráfico';

  @override
  String get totalDownload => 'Descargado';

  @override
  String get totalUpload => 'Subido';

  @override
  String get initiatorShort => 'De';

  @override
  String get result => 'Resultado';

  @override
  String get elapsed => 'Tardó';

  @override
  String get connectionStats => 'Estadísticas de conexión';

  @override
  String get connectionStatsDesc =>
      'Conexiones activas, solicitudes recientes y consultas DNS';

  @override
  String get memoryInfoDesc => 'Memoria que usan la app y el núcleo';

  @override
  String get editDashboard => 'Editar panel';

  @override
  String get done => 'Hecho';

  @override
  String get dashboardAddableSection => 'Disponibles para añadir';

  @override
  String customImportDroppedSubRules(num count, Object label) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Se descartaron $label reglas SUB-RULE, porque los perfiles personalizados no admiten subreglas',
      one:
          'Se descartó 1 regla SUB-RULE, porque los perfiles personalizados no admiten subreglas',
    );
    return '$_temp0';
  }

  @override
  String get autoInclude => 'Incluir automáticamente';

  @override
  String get allReferencedProxies => 'Todos los proxies referenciados';

  @override
  String get allReferencedProxyProviders =>
      'Todos los proveedores de proxies referenciados';

  @override
  String get clearDnsCache => 'Borrar la caché DNS';

  @override
  String get dnsCacheCleared => 'Caché DNS borrada';

  @override
  String get clearDnsCacheFailed => 'No se pudo borrar la caché DNS';

  @override
  String get select => 'Seleccionar';

  @override
  String get preferred => 'Preferido';

  @override
  String get addToLocalProxies => 'Añadir a proxies locales';

  @override
  String addedToLocalProxies(Object name) {
    return '$name añadido a proxies locales';
  }

  @override
  String alreadyInLocalProxies(Object name) {
    return '$name ya está en proxies locales';
  }

  @override
  String get mitm => 'MITM';

  @override
  String get httpsDecryption => 'Descifrado HTTPS';

  @override
  String get httpCapture => 'Captura HTTP';

  @override
  String get httpCaptureDesc =>
      'Registra las solicitudes a los hosts indicados en Nombre de host, para verlas en los detalles de la conexión. Los registros solo se guardan en memoria.';

  @override
  String get httpCaptureNoHosts =>
      'No hay ningún host indicado, así que no se registra nada. Añade hosts en Nombre de host, en la página MITM, o desde los detalles de una conexión.';

  @override
  String get httpCaptureLimit => 'Máximo de registros';

  @override
  String httpCaptureLimitDesc(Object memory, Object body) {
    return 'Los registros más antiguos se eliminan primero al alcanzar este número u ocupar $memory de memoria. De cada cuerpo se conservan solo los primeros $body.';
  }

  @override
  String get httpRequests => 'Solicitudes HTTP';

  @override
  String get httpRequestsMissing =>
      'Las solicitudes enviadas antes de activar la captura, o ya borradas, no aparecen.';

  @override
  String get httpRequestCleared =>
      'El registro de esta solicitud se ha borrado';

  @override
  String get httpCaptureOff => 'La captura está desactivada';

  @override
  String get inProgress => 'En curso';

  @override
  String get method => 'Método';

  @override
  String get originalUrl => 'URL original';

  @override
  String get timeToFirstByte => 'Tiempo hasta el primer byte';

  @override
  String get requestBody => 'Cuerpo de la solicitud';

  @override
  String get response => 'Respuesta';

  @override
  String get responseBody => 'Cuerpo de la respuesta';

  @override
  String get responseHeaders => 'Encabezados de respuesta';

  @override
  String get matchedRules => 'Reglas aplicadas';

  @override
  String get overview => 'Resumen';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get copyAsBase64 => 'Copiar como Base64';

  @override
  String get copyAsCurl => 'Copiar como cURL';

  @override
  String get closeConnection => 'Cerrar conexión';

  @override
  String get copyHost => 'Copiar host';

  @override
  String get copyDestination => 'Copiar destino';

  @override
  String get copyRequest => 'Copiar solicitud';

  @override
  String get copyResponse => 'Copiar respuesta';

  @override
  String get copyResponseBody => 'Copiar cuerpo de la respuesta';

  @override
  String get httpBodyProtobufGuess =>
      'Leído como Protobuf sin esquema: solo números de campo, y los tipos son supuestos.';

  @override
  String get exportHar => 'Exportar HAR';

  @override
  String get mitmAddRejectRule => 'Añadir una regla de rechazo';

  @override
  String get mitmAddMapLocalRule => 'Añadir una regla de mapeo local';

  @override
  String get httpExportPrivateTitle => 'Contiene datos privados';

  @override
  String get httpExportPrivate =>
      'Una solicitud puede llevar cookies, tokens, contraseñas y contenido de formularios. Revisa qué compartes y con quién.';

  @override
  String get mitmRuleCopiedForStash =>
      'Este módulo es una sobrescritura de Stash, así que la regla se copió para que la añadas a mano.';

  @override
  String get binaryData => 'Datos binarios';

  @override
  String get httpBodyNotKept => 'No se registró por falta de memoria.';

  @override
  String get httpBodyTruncated =>
      'Solo se registró el comienzo de este cuerpo.';

  @override
  String httpBodyUndecoded(Object encoding) {
    return 'No se pudo decodificar $encoding, así que se muestran los datos tal como se enviaron.';
  }

  @override
  String get mitmEnableTip =>
      'FlClash podrá leer todo lo que se envíe a los hosts descifrados, incluidas cookies y contraseñas. Actívalo solo para los hosts que quieras reescribir.';

  @override
  String get generateCertificate => 'Generar certificado';

  @override
  String get regenerateCertificate => 'Regenerar certificado';

  @override
  String get regenerateCertificateTip =>
      'El nuevo certificado sustituye al actual, que FlClash quita de las raíces de confianza de este dispositivo cuando puede. Cada otro dispositivo que confía en el actual tiene que instalar el nuevo.';

  @override
  String get exportCertificate => 'Exportar certificado';

  @override
  String get installCertificate => 'Instalar en el sistema';

  @override
  String get installCertificateSuccess => 'Certificado instalado';

  @override
  String validUntil(Object date) {
    return 'Válido hasta el $date';
  }

  @override
  String get mitmCertificateExportTip =>
      'Expórtalo y confía en él en los dispositivos que quieras descifrar.';

  @override
  String get mitmTrustReady => 'De confianza';

  @override
  String get mitmTrustUntrusted => 'Sin confianza completa';

  @override
  String get mitmTrustNotInstalled => 'No instalado';

  @override
  String get mitmTrustChecking => 'Comprobando…';

  @override
  String get mitmCertificateAndroidReadyTip =>
      'Solo se descifran las apps que confían en certificados de usuario, sobre todo los navegadores.';

  @override
  String get mitmAndroidRootDesc =>
      'Sin root, solo se pueden descifrar las apps que confían en certificados de usuario, sobre todo los navegadores. Con root, todas las apps.';

  @override
  String get mitmCertificateLinuxTip =>
      'Los navegadores Flatpak necesitan que importes el certificado exportado a mano.';

  @override
  String mitmCertutilMissing(Object command) {
    return 'Chrome y Firefox tienen sus propios almacenes de certificados, que necesitan certutil: $command';
  }

  @override
  String mitmMissingStores(Object stores) {
    return 'Aún no está en: $stores';
  }

  @override
  String get httpRequestsReadFailed => 'No se pudieron leer las solicitudes';

  @override
  String get requestBodyReadFailed =>
      'No se pudo leer el cuerpo de la solicitud';

  @override
  String get responseBodyReadFailed =>
      'No se pudo leer el cuerpo de la respuesta';

  @override
  String mitmGrpcOverLimit(Object size) {
    return 'Descomprimido supera $size MB; se muestra comprimido';
  }

  @override
  String mitmUntrustedStores(Object stores) {
    return 'Instalado pero sin confianza en: $stores';
  }

  @override
  String get mitmSystemStoreFailed =>
      'No se pudo añadir el certificado a las raíces de confianza del sistema';

  @override
  String get mitmRootUntilReboot =>
      'No se encontró Magisk, KernelSU ni APatch para conservar el certificado. Vuelve a instalarlo después de reiniciar el dispositivo.';

  @override
  String get mitmRootPendingReboot =>
      'El certificado se aplicará después de reiniciar el dispositivo.';

  @override
  String get mitmInstallSystemCaTip =>
      'Se detectó root: el certificado se añadirá a los certificados de confianza del sistema como el módulo de Magisk, KernelSU o APatch «FlClash MITM CA». Todas las apps del dispositivo confiarán en él, y quien tenga su clave privada podrá descifrar el tráfico HTTPS del dispositivo. Para deshacerlo, regenera el certificado o quita el módulo en el gestor de root y reinicia. Si se deniega root, se instalará como certificado de usuario.';

  @override
  String get mitmInstallUserCaTip =>
      'No se detectó root: el certificado solo puede instalarse como certificado de usuario. Solo se descifran las apps que confían en certificados de usuario, sobre todo los navegadores; las demás fallan en los hosts que indiques, así que no indiques sus hosts. Desde Android 11 terminas la instalación tú mismo en los ajustes del sistema.';

  @override
  String mitmCertificateSavedTip(Object fileName) {
    return 'Se guardó $fileName en Descargas. Instálalo en Ajustes › Seguridad › Cifrado y credenciales › Instalar un certificado › Certificado de CA.';
  }

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String mitmRemoveOldCertificateTip(Object name) {
    return 'Quita el certificado antiguo, $name, en Ajustes › Seguridad › Cifrado y credenciales › Credenciales de confianza › Usuario, y después instala el nuevo.';
  }

  @override
  String mitmOldCertificateLeftTip(Object name) {
    return 'No se pudo quitar el certificado antiguo, $name. Quítalo tú de las raíces de confianza.';
  }

  @override
  String mitmOldSystemCertificateLeftTip(Object name) {
    return 'El certificado antiguo, $name, sigue entre los certificados de confianza del sistema. Permite el acceso root a FlClash en tu gestor de root y vuelve a generarlo, o elimina allí el módulo «FlClash MITM CA» y reinicia.';
  }

  @override
  String get removeCertificate => 'Quitar certificado';

  @override
  String get removeCertificateSuccess => 'Certificado quitado';

  @override
  String get mitmSystemStoreRemoveFailed =>
      'No se pudo quitar el certificado de las raíces de confianza del sistema';

  @override
  String get mitmRemoveInSettings => 'Quitar en Ajustes';

  @override
  String mitmRemoveUserCertificateTip(Object name) {
    return 'Android no permite que las apps quiten certificados de usuario. Quita $name en Ajustes › Seguridad › Cifrado y credenciales › Credenciales de confianza › Usuario.';
  }

  @override
  String get mitmCannotRemove => 'No se puede quitar';

  @override
  String get mitmRemoveSystemCertificateTip =>
      'El módulo root «FlClash MITM CA» añadió el certificado al sistema. Permite el acceso root a FlClash en tu gestor de root y vuelve a intentarlo, o elimina allí el módulo y reinicia.';

  @override
  String get mitmDecryptHost => 'Descifrar este host';

  @override
  String mitmDecryptHostTip(Object host) {
    return '¿Añadir $host a la lista de nombres de host? FlClash podrá leer lo que se le envíe, incluidas cookies y contraseñas.';
  }

  @override
  String get mitmClientRefusedCertificate =>
      'El cliente rechazó el certificado. Instala la CA o excluye este host si la app fija su certificado.';

  @override
  String get mitmExcludeHost => 'Excluir del descifrado';

  @override
  String mitmExcludeHostTip(Object host) {
    return '¿Añadir -$host al principio de la lista de nombres de host? El host ya no se descifrará nunca.';
  }

  @override
  String get urlRewrite => 'Reescritura de URL';

  @override
  String get headerRewrite => 'Reescritura de cabeceras';

  @override
  String get bodyRewrite => 'Reescritura del cuerpo';

  @override
  String get mapLocal => 'Mapeo local';

  @override
  String get requestBodyMock => 'Sustitución del cuerpo de la solicitud';

  @override
  String get clientSourceAddress => 'Direcciones de clientes';

  @override
  String get skipVerifyHostname => 'Hosts sin verificación de certificado';

  @override
  String get mitmModules => 'Módulos';

  @override
  String get mitmModule => 'Módulo';

  @override
  String get mitmModuleInvalid =>
      'No es un módulo de Surge, un plugin de Loon, un fragmento de Quantumult X ni una sobrescritura de Stash';

  @override
  String get arguments => 'Argumentos';

  @override
  String get mitmRoutingRules => 'Reglas de enrutamiento';

  @override
  String get mitmIgnoredLines => 'Líneas ignoradas';

  @override
  String get mitmModuleRulesDesc =>
      'Las reglas de enrutamiento van antes que las del perfil.';

  @override
  String get mitmRequestRulesDesc =>
      'Las reglas URL-REGEX y USER-AGENT del módulo se convierten en reescrituras de URL que se evalúan en cada solicitud: en toda solicitud HTTP sin cifrar y, en HTTPS, solo para los hosts de la lista de MITM.';

  @override
  String mitmModuleSystemTip(Object system) {
    return 'Escrito para $system; algunas líneas pueden no coincidir con las apps de este dispositivo.';
  }

  @override
  String mitmModuleRequirementTip(Object requirement) {
    return 'El módulo requiere $requirement, que este dispositivo no cumple; puede que no funcione como se espera.';
  }

  @override
  String mitmExitModules(Object modules) {
    return 'De los módulos: $modules';
  }

  @override
  String get mitmModuleRiskTitle => '¿Activar este módulo?';

  @override
  String get mitmNetworkRisk =>
      'Al generar la configuración, cambia los ajustes de red de abajo, por encima de lo que hayas configurado para esos mismos en FlClash. Al desactivar o eliminar el módulo, se deshace.';

  @override
  String mitmSkipVerifyRisk(Object hosts) {
    return 'Al activarlo, deja de verificarse el certificado de los servidores de estos hosts, así que un servidor que se haga pasar por ellos pasará desapercibido: $hosts';
  }

  @override
  String mitmClientSourceRisk(Object addresses) {
    return 'Solo descifra el tráfico de estos clientes: $addresses. Con TUN activado, las apps de este dispositivo llegan desde la dirección de TUN, así que pueden quedar fuera.';
  }

  @override
  String get mitmClientSourceTunTip =>
      'Con TUN activado, las apps de este dispositivo llegan desde la dirección de TUN; si la lista no la incluye, su tráfico no se descifra.';

  @override
  String get mitmNetworkChanges => 'Ajustes de red';

  @override
  String mitmChangeReplace(Object values) {
    return 'Se sustituye por $values';
  }

  @override
  String mitmChangeInsert(Object values) {
    return 'Añade $values al principio';
  }

  @override
  String mitmChangeAppend(Object values) {
    return 'Añade $values';
  }

  @override
  String get mitmChangeOverridesYours => 'Se impone a tu ajuste';

  @override
  String mitmChangeReplacedBy(Object module) {
    return 'Lo anula el módulo $module';
  }

  @override
  String mitmSkipSection(Object section) {
    return 'La sección [$section] no es compatible';
  }

  @override
  String get mitmSkipSetting => 'Este ajuste no es compatible';

  @override
  String get mitmSkipScriptType => 'Este tipo de script no es compatible';

  @override
  String get mitmSkipRule => 'Este tipo de regla no es compatible';

  @override
  String get mitmSkipHttpRulePolicy =>
      'Las reglas URL-REGEX y USER-AGENT solo admiten una política REJECT';

  @override
  String get mitmSkipFinalRule =>
      'Las reglas del módulo van primero, así que una regla final ocultaría todas las siguientes';

  @override
  String get mitmSkipDeviceRule =>
      'Esta regla necesita datos del dispositivo o de la red que FlClash no puede leer';

  @override
  String get mitmSkipRequirement =>
      'Este dispositivo no cumple el requisito de esta línea';

  @override
  String get mitmSkipManagedCa =>
      'FlClash gestiona el certificado de la CA; un módulo no puede cambiarlo';

  @override
  String get mitmSkipProxies =>
      'Un módulo no puede cambiar proxies ni grupos de proxies';

  @override
  String get mitmSkipAppOnly =>
      'Es una función propia de la app original que FlClash no tiene';

  @override
  String get mitmSkipReflect =>
      'FlClash no puede devolver los paquetes a su remitente';

  @override
  String get mitmSkipConditional =>
      'Las reescrituras condicionales no son compatibles';

  @override
  String get mitmSkipSkipVerifyAll =>
      'No se desactiva la verificación de certificados para todos los hosts';

  @override
  String get mitmSkipRelativeData =>
      'El archivo que nombra esta línea no está adjunto; usa una URL o adjúntalo';

  @override
  String get mitmSkipNotDownloaded => 'Su archivo aún no se ha descargado';

  @override
  String get mitmSkipUnreadable => 'No se puede leer esta línea';

  @override
  String get mitmAddLocalFile => 'Añadir un archivo local';

  @override
  String get mitmNewModule => 'Nuevo módulo';

  @override
  String get mitmAttachments => 'Adjuntos';

  @override
  String get mitmAttachmentsDesc =>
      'Las líneas hacen referencia a los adjuntos por nombre de archivo, como script-path=a.js.';

  @override
  String mitmFileTooLarge(Object size) {
    return 'El archivo supera los $size MB';
  }

  @override
  String get mitmSkipDisabled => 'Desactivado por un argumento';

  @override
  String get mitmSkipEvent => 'Este evento no es compatible';

  @override
  String get mitmRunScript => 'Ejecutar ahora';

  @override
  String get mitmScriptCron => 'Programado';

  @override
  String get mitmScriptEvent => 'Evento';

  @override
  String get mitmScriptGeneric => 'Genérico';

  @override
  String get mitmExcluded => 'Excluido';

  @override
  String get mitmScriptNoOutput => 'El script terminó sin salida';

  @override
  String get mitmScriptRiskTitle => '¿Ejecutar los scripts de este módulo?';

  @override
  String get mitmModulesTurnedOff => 'Módulos desactivados';

  @override
  String mitmModuleTurnedOffDesc(Object name) {
    return 'Una actualización de $name trajo scripts o cambios de red que no has aceptado';
  }

  @override
  String mitmModulesTurnedOffDesc(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Las actualizaciones de $count módulos trajeron scripts o cambios de red que no has aceptado',
    );
    return '$_temp0';
  }

  @override
  String get mitmScriptRisk =>
      'Sus scripts leen y modifican el tráfico de los hosts que coinciden, incluidas las cookies y los tokens, y pueden enviar sus propias solicitudes. Actívalo solo si confías en su origen. Una vez activado, sus actualizaciones se aplican sin volver a preguntar.';

  @override
  String get mitmModuleUnreadableRisk =>
      'No se pudo leer el archivo del módulo, así que no se sabe qué cambia. Actívalo solo si confías en su origen.';

  @override
  String get skipServerCertVerify =>
      'Omitir la verificación del certificado del servidor';

  @override
  String get blockQuic => 'Bloquear QUIC';

  @override
  String get http2 => 'HTTP/2';

  @override
  String get decryptUntrusted => 'Descifrar sin confianza local';

  @override
  String invalidOfCount(Object invalid, Object total) {
    return '$invalid de $total no válidos';
  }

  @override
  String get batchLineInputTip => 'Un elemento por línea';

  @override
  String get downloadingUpdate => 'Descargando actualización';

  @override
  String get updateFailed => 'Error al actualizar';

  @override
  String get updateDownloadTest => 'Prueba de descarga de actualización';

  @override
  String get liveStatusTest => 'Prueba de tarjetas de estado en vivo';

  @override
  String get updateDownloadStarted =>
      'Se inició la descarga de la actualización. Consulta el progreso en el panel.';

  @override
  String get updateReady => 'Actualización lista';

  @override
  String get updateReadyTip =>
      'La actualización se descargó. Toca para instalarla.';

  @override
  String get stopUpdateDownloadTip =>
      '¿Detener la descarga de la actualización?';

  @override
  String get forceRestartCoreAsk => '¿Forzar el reinicio del núcleo?';

  @override
  String get forceRestartCoreAskDesc => 'Las conexiones en curso se cortarán';

  @override
  String get stopUpdateDownloadDesc => 'Se borra lo ya descargado';

  @override
  String get stopDownload => 'Detener';

  @override
  String get updateInstallFailed =>
      'No se pudo instalar la actualización. Puedes descargarla desde la página de la versión.';

  @override
  String get updateNotVerified =>
      'No se pudo verificar la actualización descargada.';

  @override
  String get updateRestartTip =>
      'FlClash se cerrará para instalar la actualización y se volverá a abrir al terminar.';

  @override
  String get updateDownloadFailed => 'No se pudo descargar la actualización.';

  @override
  String get updateFileMissing =>
      'La versión no incluye el archivo de actualización. Descárgalo desde la página de la versión.';

  @override
  String get defaultNameserverDesc =>
      'Resuelve los nombres de los demás servidores DNS. Solo direcciones IP.';

  @override
  String get nameserverDesc =>
      'Servidores DNS predeterminados, como 223.5.5.5, tls://1.1.1.1 o https://dns.google/dns-query.';

  @override
  String get fallbackDesc =>
      'Se usan en lugar de Nameserver cuando el filtro de respaldo considera contaminada su respuesta.';

  @override
  String get proxyServerNameserverDesc =>
      'Solo resuelve los nombres de los servidores proxy.';

  @override
  String get proxyServerNameserverPolicyDesc =>
      'Los nombres de servidores proxy coincidentes usan el servidor DNS indicado aquí en lugar de Proxy Server Nameserver.';

  @override
  String get directNameserverDesc =>
      'Resuelve los dominios de las conexiones directas.';

  @override
  String get nameserverPolicyDesc =>
      'Los dominios coincidentes usan el servidor DNS indicado aquí en lugar de Nameserver y Fallback.';

  @override
  String get fakeipFilterDesc =>
      'Estos dominios reciben su IP real en lugar de una Fake-IP. En modo whitelist, solo ellos reciben Fake-IP.';

  @override
  String get fallbackFilterGeositeDesc =>
      'Los dominios de estas categorías GeoSite se resuelven directamente con Fallback.';

  @override
  String get fallbackFilterIpcidrDesc =>
      'Si Nameserver devuelve una IP de estos rangos, se usa la respuesta de Fallback.';

  @override
  String get fallbackFilterDomainDesc =>
      'Estos dominios se resuelven directamente con Fallback.';

  @override
  String get silentLaunchDesc =>
      'El inicio silencioso arranca sin mostrar la ventana.';

  @override
  String get accessControlDesc =>
      'El control de acceso elige qué apps usan el proxy.';

  @override
  String get addressHelp => 'Dirección del servidor WebDAV';

  @override
  String get authenticationDesc =>
      'La autenticación pide usuario y contraseña en el puerto del proxy local.';

  @override
  String get updateDownload => 'Descargando la actualización';

  @override
  String get updateVerify => 'Comprobando la descarga';

  @override
  String get updateInstall => 'Instalando la actualización';

  @override
  String get updateChecksumMismatch =>
      'La descarga no coincide con la suma publicada';

  @override
  String get updatePackageMissing =>
      'Esta versión no tiene un instalador para este dispositivo';

  @override
  String get updateInstallPermission =>
      'Permite instalar aplicaciones desconocidas y vuelve a buscar actualizaciones';

  @override
  String get updateWillRestart =>
      'La aplicación se cerrará y se abrirá de nuevo';

  @override
  String get updateOpensInstaller => 'Se abrirá el instalador del sistema';

  @override
  String get updateOpenDownloadPage =>
      'Este dispositivo no tiene instalador en la app. Se abrirá la página de descarga.';

  @override
  String get installUpdate => 'Instalar actualización';

  @override
  String updateRunningVersion(String version) {
    return 'Versión actual $version';
  }

  @override
  String get tapToRetry => 'Toca para reintentar';

  @override
  String get autoCloseConnectionsDesc =>
      'Cerrar conexiones automáticamente corta las conexiones abiertas al cambiar de proxy.';

  @override
  String get sidebarBlurDesc =>
      'El desenfoque de fondo deja ver el escritorio detrás de la ventana a través de la barra lateral.';

  @override
  String get vpnEnableDesc =>
      'La VPN enruta automáticamente todo el tráfico del sistema a través de VpnService.';

  @override
  String get ntpStatusDesc =>
      'NTP obtiene la hora de un servidor NTP en lugar del reloj del sistema.';

  @override
  String get dialerProxyDesc =>
      'El proxy de marcación es la salida que se usa para llegar al servidor NTP.';

  @override
  String get snifferStatusDesc =>
      'El sniffer lee el dominio del tráfico TLS, HTTP y QUIC para que las reglas puedan aplicarse.';

  @override
  String get overrideDestinationDesc =>
      'Sobrescribir destino se conecta al dominio detectado en lugar de a la dirección original.';

  @override
  String get parsePureIpDesc =>
      'Analizar IP pura analiza las conexiones que solo llevan una dirección IP.';

  @override
  String get skipDomainDesc =>
      'Un dominio detectado que esté en la lista de dominios omitidos no se usa.';

  @override
  String get fakeipFilterModeDesc =>
      'En el modo de filtro Fake-IP, la lista negra excluye las coincidencias, la lista blanca aplica Fake-IP solo a las coincidencias y rule coincide según las reglas.';

  @override
  String get ipv6InboundDesc =>
      'Con IPv6 activado, la VPN permite el tráfico IPv6 entrante.';

  @override
  String get interfaceNameDesc =>
      'El nombre de interfaz es la interfaz de red que usan las conexiones salientes.';

  @override
  String get advancedConfigDesc =>
      'La configuración avanzada incluye la red, el DNS, las reglas añadidas y los scripts.';

  @override
  String get singleAdd => 'Añadir uno';

  @override
  String get batchAdd => 'Añadir en lote';

  @override
  String get batchListInputTip =>
      'Un elemento por línea, o separados por comas';

  @override
  String get batchMapInputTip =>
      'Una entrada por línea: clave, un espacio y el valor';

  @override
  String get customProfileResources => 'Recursos de perfil personalizado';

  @override
  String get customProfileResourcesDesc =>
      'Los recursos de perfil personalizado son los proxies, proveedores de reglas, filtros y conjuntos de iconos que añades tú para usarlos en perfiles personalizados.';

  @override
  String get batteryOptimizationDesc =>
      'Ignorar la optimización de batería mantiene la app en ejecución en segundo plano.';

  @override
  String get onDemandDesc =>
      'Bajo demanda pausa el proxy en las redes Wi-Fi excluidas.';

  @override
  String get blockConnection => 'Bloquear conexión';

  @override
  String get outboundLocation => 'Ubicación de salida';

  @override
  String get outboundLocationCountry => 'País';

  @override
  String get outboundLocationLocality => 'Localidad';

  @override
  String get outboundLocationCoordinates => 'Coordenadas';

  @override
  String get outboundLocationApproximate =>
      'El pin es aproximado según el código de país. Aparece una ciudad precisa cuando la sonda devuelve coordenadas.';

  @override
  String get outboundLocationUnknown =>
      'Aún no hay posición en el mapa para esta salida';

  @override
  String get bypassPrivateRouteDesc =>
      'Con Omitir direcciones privadas activado, las direcciones de LAN, loopback y multidifusión no pasan por TUN.';

  @override
  String get excludeInterfaceDesc =>
      'El tráfico que llega por las interfaces excluidas, como docker0, no pasa por TUN.';

  @override
  String get includeUidDesc =>
      'Solo el tráfico de los procesos de los ID de usuario incluidos pasa por TUN.';

  @override
  String get excludeUidDesc =>
      'El tráfico de los procesos de los ID de usuario excluidos no pasa por TUN.';

  @override
  String get excludeSrcPortDesc =>
      'El tráfico desde los puertos de origen excluidos no pasa por TUN.';

  @override
  String get excludeDstPortDesc =>
      'El tráfico hacia los puertos de destino excluidos no pasa por TUN.';

  @override
  String get serviceCheck => 'Comprobar';

  @override
  String serviceCheckedAt(Object time) {
    return 'Comprobado a las $time';
  }

  @override
  String get linkDesc =>
      'Obtén un perfil desde un enlace de suscripción o un enlace para compartir proxies';

  @override
  String get fileDesc => 'Sube un archivo de perfil directamente';

  @override
  String get selected => 'Seleccionado';

  @override
  String get sidebarBlur => 'Desenfoque de la barra lateral';

  @override
  String get hideTimeoutProxiesDesc =>
      'Omite los proxies cuya última prueba de latencia superó el tiempo de espera';

  @override
  String get accessControlSettings => 'Ajustes de control de acceso';

  @override
  String get customProfileDesc =>
      'Crea grupos de proxies y reglas a partir de los proxies de la app y de otros perfiles';

  @override
  String get networkDetection => 'Network detection';

  @override
  String get themeDesc => 'Set dark mode and adjust colors';

  @override
  String get autoLaunchDesc => 'Launch automatically at system startup';

  @override
  String get urlDesc => 'Obtain a profile from a URL';

  @override
  String get importFromURL => 'Import from URL';

  @override
  String get excludeDesc =>
      'Hide the app from recent tasks while it is in the background';

  @override
  String get expand => 'Standard';

  @override
  String get shrink => 'Compact';

  @override
  String get min => 'Minimal';

  @override
  String get vpnTip => 'Changes take effect after restarting the VPN';

  @override
  String get behavior => 'Behavior';

  @override
  String get format => 'Format';

  @override
  String get overrideDns => 'Override DNS';

  @override
  String get overrideNtp => 'Override NTP';

  @override
  String get disclaimerCrashlyticsTitle =>
      'Firebase Crashlytics (crash analytics)';

  @override
  String get disclaimerCrashlyticsContent =>
      'When the app crashes, a crash report is uploaded automatically.\n\nWhat is collected: the crash stack trace and error message, the time of the crash, the app version and build number, the device brand and model, the Android version, screen orientation, free memory and storage, whether the device is rooted, and a random installation ID that is created on install and reset on reinstall.\n\nPurpose: only to locate and fix crashes.\n\nYou can turn it off at any time under \"Tools > General > Crash analytics\".';

  @override
  String get disclaimerAnalyticsTitle =>
      'Firebase Analytics (usage statistics)';

  @override
  String get disclaimerAnalyticsContent =>
      'Basic app usage statistics are collected automatically with Firebase.\n\nWhat is collected: basic events such as first launch, app opens and session length, and app updates; an app instance ID; the device model, OS version, and system language; and an approximate country- or region-level location inferred from the IP address.\n\nPurpose: only to understand the number of active devices, version distribution, and OS compatibility. The developers do not use this data for advertising, do not sell it, and do not link it to your subscriptions or configurations.';

  @override
  String get disclaimerDataProcessingContent =>
      'This data is processed and stored by Google on our behalf, may be transferred to servers outside your country or region (such as in the United States), and is governed by the Google Privacy Policy and the Firebase privacy and security documentation. Crash reports are kept for up to 90 days; statistics are kept under the Firebase default retention policy.';

  @override
  String get disclaimerAndroidOnly => 'Android only';

  @override
  String get disclaimerGooglePrivacy => 'Google Privacy Policy';

  @override
  String get disclaimerFirebasePrivacy => 'Firebase privacy and security';

  @override
  String get routeMode => 'Route mode';

  @override
  String get routeModeBypassPrivate => 'Bypass private addresses';

  @override
  String get routeModeConfig => 'Use config';

  @override
  String selectedCountTitle(Object count) {
    return '$count selected';
  }

  @override
  String get ruleName => 'Rule name';

  @override
  String get subRule => 'Sub-rule';

  @override
  String get colorSchemes => 'Color schemes';

  @override
  String get palette => 'Palette';

  @override
  String get tonalSpotScheme => 'Tonal spot';

  @override
  String get fidelityScheme => 'Fidelity';

  @override
  String get neutralScheme => 'Neutral';

  @override
  String get vibrantScheme => 'Vibrant';

  @override
  String get expressiveScheme => 'Expressive';

  @override
  String get contentScheme => 'Content';

  @override
  String get rainbowScheme => 'Rainbow';

  @override
  String get fruitSaladScheme => 'Fruit salad';

  @override
  String get dataCollectionTip => 'Data collection notice';

  @override
  String get dataCollectionContent =>
      'This app uses Firebase Crashlytics to collect crash information to improve stability.\nThe collected data includes device information and crash details, and contains no personally sensitive data.\nYou can turn this off in settings.';

  @override
  String get crashlytics => 'Crash analytics';

  @override
  String get crashlyticsTip =>
      'When enabled, crash logs without sensitive information are uploaded automatically when the app crashes';

  @override
  String get overrideMode => 'Override mode';

  @override
  String get quickAdd => 'Quick add';

  @override
  String get overrideScript => 'Override script';

  @override
  String get overwriteTypeCustom => 'Custom';

  @override
  String get overwriteTypeCustomDesc =>
      'Custom mode: fully customize proxies, proxy groups and rules';

  @override
  String get backupAndRestoreDesc => 'Sync data via WebDAV or files';

  @override
  String get proxyGroupNameDuplicate => 'Duplicate proxy group name';

  @override
  String get dataChangedSave => 'Data changes detected. Save them?';

  @override
  String get selectProxyProviders => 'Select proxy providers';

  @override
  String get proxyFilter => 'Proxy filter';

  @override
  String get excludeProxyFilter => 'Exclude proxy filter';

  @override
  String get excludeType => 'Exclude type';

  @override
  String get selectProxies => 'Select proxies';

  @override
  String get selectSubRule => 'Please select a sub-rule';

  @override
  String get includeAllProxyProviders => 'Include all proxy providers';

  @override
  String get includeAllProxyProvidersTip =>
      'When enabled, the group takes every proxy provider of this profile: the subscription\'s own, plus the profiles and app proxy providers any proxy group uses';

  @override
  String get addProxyProviders => 'Add proxy providers';

  @override
  String get includeAllProxies => 'Include all proxies';

  @override
  String get includeAllProxiesTip =>
      'Imports all proxies outside proxy groups; extra proxy groups can be added below';

  @override
  String get proxiesEmpty => 'Proxies are empty';

  @override
  String get addProxies => 'Add proxies';

  @override
  String get confirmOverwriteTip => 'Confirming will overwrite existing data';

  @override
  String get configDataDetected => 'Data detected in the configuration';

  @override
  String get quickFill => 'Quick fill';

  @override
  String get noRecords => 'No records';

  @override
  String get subRuleEmpty => 'Sub-rule is empty';

  @override
  String get proxyProvidersNotEmpty => 'Proxy providers cannot be empty';

  @override
  String get subRuleNotEmpty => 'Sub-rule cannot be empty';

  @override
  String get proxyProvidersEmpty => 'Proxy providers are empty';

  @override
  String get batteryOptimizationStatusTip =>
      'Due to system limitations, the battery optimization status cannot be read correctly while running';

  @override
  String get geoOptions => 'Geo options';

  @override
  String get geoAutoUpdate => 'Auto update';

  @override
  String get geoAutoUpdateInterval => 'Auto-update interval';

  @override
  String get geoAutoUpdateIntervalTip =>
      'The auto-update interval must be greater than 0';

  @override
  String hoursCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '1 hour',
    );
    return '$_temp0';
  }

  @override
  String get addWidget => 'Add widget';

  @override
  String get proxyNode => 'Proxy node';

  @override
  String get proxyDefinition => 'Full configuration';

  @override
  String get proxyDefinitionNotMap =>
      'The configuration must be a YAML mapping with a name and a type';

  @override
  String get customProxiesEmpty =>
      'No custom proxies, so the profile\'s own proxies are used';

  @override
  String get overwriteIssueEmptyName => 'The name is empty';

  @override
  String overwriteIssueReservedName(Object name) {
    return '$name is a built-in policy name and cannot be used here';
  }

  @override
  String overwriteIssueDuplicateName(Object name) {
    return 'The name $name is already used by another proxy or proxy group';
  }

  @override
  String overwriteIssueCoreRejected(Object message) {
    return 'The core cannot parse this proxy: $message';
  }

  @override
  String overwriteIssueMissingProxies(Object names) {
    return 'These proxies or policies do not exist: $names';
  }

  @override
  String overwriteIssueMissingProviders(Object names) {
    return 'These proxy providers do not exist: $names';
  }

  @override
  String get overwriteIssueNoProxySource =>
      'No proxies or proxy providers are selected, so the core rejects this group';

  @override
  String overwriteIssueGroupLoop(Object path) {
    return 'Proxy groups reference each other in a loop: $path';
  }

  @override
  String overwriteIssuesSummary(Object count) {
    return '$count items have problems, and applying this override may fail';
  }

  @override
  String overwriteIssueSubscriptionGroupMissingProxies(Object names) {
    return 'The profile\'s own proxy groups name proxies that the custom proxies no longer include: $names';
  }

  @override
  String get providerSourceSubscription => 'Subscription';

  @override
  String providerRenameShadowed(String profiles, String label) {
    return 'The subscriptions of $profiles already have $label, so those profiles would switch to theirs. Choose another name';
  }

  @override
  String get features => 'Features';

  @override
  String get tailscale => 'Tailscale';

  @override
  String get tailscaleDesc => 'Manage Tailscale outbound nodes';

  @override
  String get tailscaleEnable => 'Enable Tailscale';

  @override
  String get tailscaleEnableDesc =>
      'Inject Tailscale nodes as outbounds. Turning this off stops Tailscale from handling traffic; normal traffic is unaffected.';

  @override
  String get tailscaleEmptyTip =>
      'No Tailscale nodes yet. Add one to route traffic through your tailnet.';

  @override
  String get tailscaleAuthKey => 'Auth key';

  @override
  String get tailscaleHostname => 'Hostname';

  @override
  String get tailscaleControlUrl => 'Control URL';

  @override
  String get tailscaleStateDir => 'State directory';

  @override
  String get tailscaleEphemeral => 'Ephemeral';

  @override
  String get tailscaleUdp => 'UDP relay';

  @override
  String get tailscaleAcceptRoutes => 'Accept routes';

  @override
  String get tailscaleExitNode => 'Exit node';

  @override
  String get tailscaleExitNodeAllowLanAccess =>
      'Allow LAN access via exit node';

  @override
  String get tailscaleNameExistsTip => 'A node with this name already exists';

  @override
  String get tailscaleGuideTitle => 'How Tailscale works';

  @override
  String get tailscaleAuthKeyHint =>
      'From the Tailscale admin console → Settings → Keys. Required to authenticate the node.';

  @override
  String get tailscaleHostnameHint =>
      'Optional. Device name shown in your tailnet.';

  @override
  String get tailscaleControlUrlHint =>
      'Optional. Only for self-hosted control servers such as Headscale.';

  @override
  String get tailscaleStateDirHint =>
      'Optional. Directory used to persist Tailscale state.';

  @override
  String get tailscaleExitNodeHint =>
      'Optional. IP or name of a tailnet exit node to route all traffic through.';

  @override
  String get tailscaleBypass => 'Keep Tailscale traffic direct';

  @override
  String get tailscaleRoutes => 'Route destinations';

  @override
  String get tailscaleRoutesHint =>
      'Domains or IPs sent through this node, one per line (e.g. your home PC\'s Tailscale IP or MagicDNS name).';

  @override
  String get tailscaleScenarioAndroidTitle => 'Android client setup';

  @override
  String get tailscaleScenarioAndroidBody =>
      'Keep FlClash as the only VPN. Do not run the Tailscale app VPN at the same time (Android allows only one). Use an embedded Tailscale node below, then add your home device to Route destinations.';

  @override
  String get tailscaleAndroidModeTitle => 'Android VPN coexistence';

  @override
  String get tailscaleAndroidModeDesc =>
      'Android allows only one VPN at a time. Pick how FlClash and the Tailscale app should share this phone.';

  @override
  String get tailscaleAndroidModeFlclashTitle => 'FlClash as VPN (recommended)';

  @override
  String get tailscaleAndroidModeFlclashBody =>
      'Keep FlClash\'s VPN on and use embedded Tailscale nodes below for your tailnet. Turn the Tailscale app\'s VPN switch off.';

  @override
  String get tailscaleAndroidModeAppTitle => 'Tailscale app as VPN';

  @override
  String get tailscaleAndroidModeAppBody =>
      'Turn FlClash VPN off so the Tailscale app can own the tunnel. FlClash will not route system traffic until you switch back.';

  @override
  String get tailscaleAndroidModeFlclashApplied =>
      'Applied: FlClash VPN + embedded Tailscale. Disable VPN inside the Tailscale app if it is installed.';

  @override
  String get tailscaleAndroidModeAppApplied =>
      'Applied: FlClash VPN off. Start the Tailscale app VPN if you need the tunnel there; start FlClash only as a local proxy if needed.';

  @override
  String get tailscaleAndroidConflictBuiltin =>
      'Tailscale app detected. Keep its VPN off while FlClash VPN is on, or this VPN will drop when Tailscale connects.';

  @override
  String get tailscaleAndroidConflictApp =>
      'Tailscale app detected. FlClash VPN is off so Tailscale can own the tunnel.';

  @override
  String get tailscaleScenarioDesktopTitle => 'Desktop / host setup';

  @override
  String get tailscaleScenarioDesktopBody =>
      'You can run FlClash and the real Tailscale app together. Turn on \"Keep Tailscale traffic direct\" so FlClash does not hijack Tailscale\'s control plane or fake-IP DNS.';

  @override
  String get tailscaleAndroidStep1 =>
      'Get an auth key from the Tailscale admin console (Settings → Keys).';

  @override
  String get tailscaleAndroidStep2 =>
      'Add a node, paste the auth key, and put your home device IP or MagicDNS name in Route destinations.';

  @override
  String get tailscaleAndroidStep3 =>
      'Pick a coexistence mode at the top (FlClash as VPN recommended). Then turn on Enable Tailscale.';

  @override
  String get tailscaleAndroidStep4 =>
      'Add a node with an auth key and route destinations, start FlClash VPN, then tap ping on a node. Keep the Tailscale app VPN off in FlClash-as-VPN mode.';

  @override
  String get tailscaleDesktopStep1 =>
      'If this PC also runs the Tailscale app/service, turn on \"Keep Tailscale traffic direct\".';

  @override
  String get tailscaleDesktopStep2 =>
      'Optional: add an embedded Tailscale node with an auth key to route selected traffic through the tailnet from FlClash.';

  @override
  String get tailscaleDesktopStep3 =>
      'Put destinations (home IPs / MagicDNS) in Route destinations, then turn on Enable Tailscale.';

  @override
  String get tailscaleDesktopStep4 =>
      'Start FlClash, then tap the ping button on a node to verify the connection is solid.';

  @override
  String get tailscaleBypassRecommended =>
      'Recommended on desktop when the Tailscale app/service is installed. Auto-manages DIRECT rules and Fake IP Filter.';

  @override
  String get tailscaleBypassAndroidHint =>
      'Usually leave this off on Android. Turn on only if the Tailscale app is also installed on this phone.';

  @override
  String get tailscaleStatusDisabled =>
      'Tailscale is off — nodes are not injected into the running profile.';

  @override
  String get tailscaleStatusNoNodes =>
      'Enabled, but no nodes yet. Add a node to get started.';

  @override
  String get tailscaleStatusNeedStart =>
      'Nodes are ready. Start FlClash VPN, then tap ping to test.';

  @override
  String tailscaleStatusReady(Object count) {
    return '$count node(s) active. Tap ping on a node to test connectivity.';
  }

  @override
  String get tailscaleStatusNeedRoutes =>
      'Nodes are added, but no route destinations yet — traffic will not match until you add routes (or pick the node manually).';

  @override
  String get tailscaleBypassNudge =>
      'This device likely runs Tailscale already — turn on “Keep Tailscale traffic direct” to avoid fake-IP / control-plane breakage.';

  @override
  String get tailscaleShowSetupGuide => 'Setup guide';

  @override
  String get tailscaleEnableBypassAction => 'Enable';

  @override
  String get tailscaleNameHelper =>
      'Outbound name used in Proxies. Renaming changes how selections and delay tests key this node.';

  @override
  String get tailscaleTestNeedEnable =>
      'Turn on Enable Tailscale before testing.';

  @override
  String get tailscaleTestNeedStart =>
      'Start FlClash VPN before testing the connection.';

  @override
  String get tailscaleTestNode => 'Test Tailscale config';

  @override
  String get tailscaleNotTested => 'Not tested';

  @override
  String get tailscaleNoRoutes => 'No route destinations';

  @override
  String tailscaleRoutesCount(Object count) {
    return '$count route(s)';
  }

  @override
  String get tailscaleNodesTitle => 'Nodes';

  @override
  String get tailscaleTestTip =>
      'Tap the bolt or delay on a node to check that the auth key joined the tailnet. A delay means the config is valid; timeout means join failed — check the key, Enable Tailscale, and that FlClash VPN is running. This does not test public internet access.';

  @override
  String get tailscaleTestConfigOk =>
      'Tailscale config is valid — this node has joined the tailnet.';

  @override
  String get tailscaleTestConfigFailed =>
      'Could not join the tailnet. Check the auth key, Enable Tailscale, and that FlClash VPN is running.';

  @override
  String get geoIdentity => 'Geo identity';

  @override
  String get geoIdentityDesc => 'One switch for US exit undercover';

  @override
  String get geoIdentityPurposeBody =>
      'Turn this on so FlClash captures traffic and checks that your exit looks US-ready for AI tools. Browsers may still need GeoMirror for page fingerprints.';

  @override
  String get geoIdentityProtectToggleDesc =>
      'Capture traffic, align desktop timezone when possible, then verify the exit';

  @override
  String get geoIdentityNetworkGood => 'Network looks good to go';

  @override
  String get geoIdentityNetworkBad =>
      'Exit is not US yet — pick a US node, then tap Recheck';

  @override
  String get geoIdentityOffStatus => 'Geo identity protect is off';

  @override
  String get geoIdentityTurningOff => 'Turning off…';

  @override
  String get geoIdentityRecheck => 'Recheck';

  @override
  String get geoIdentityPendingCheck =>
      'Protect is on — waiting for a network check';

  @override
  String get geoIdentityCheckCancelled => 'Network check was cancelled';

  @override
  String get geoIdentityHonestyLine =>
      'This covers exit IP + probe language. Browser fonts/geolocation still need GeoMirror; Claude Code still needs a matching OS timezone (and TUN or proxy exports).';

  @override
  String geoIdentityTimezoneAlignFailed(Object detail) {
    return 'Could not align OS timezone ($detail)';
  }

  @override
  String get geoIdentityProtectEnable => 'Enable geo identity protect';

  @override
  String get geoIdentityCaptureMode => 'Traffic capture mode';

  @override
  String get geoIdentityCaptureModeAuto =>
      'Auto — keep current settings; enable TUN only if needed';

  @override
  String get geoIdentityCaptureModeTun => 'TUN / virtual NIC only';

  @override
  String get geoIdentityCaptureModeSystemProxy => 'System proxy only';

  @override
  String get geoIdentityCaptureModeBoth => 'System proxy + TUN';

  @override
  String get geoIdentityUsAcceptLanguage => 'Probe with US Accept-Language';

  @override
  String get geoIdentityNeedStart =>
      'Start FlClash before verifying the network environment.';

  @override
  String get geoIdentityCheckFailed => 'Network check failed';

  @override
  String get geoIdentityNetworkExposed => 'Network still looks exposed';

  @override
  String get geoIdentityTimezone => 'System timezone';

  @override
  String get geoIdentityOpenGeoMirror => 'GeoMirror on GitHub';

  @override
  String get geoIdentityRestoreOsTimezone => 'Restore previous OS timezone';

  @override
  String geoIdentityRestoreOsTimezoneDesc(Object timezone) {
    return 'Restore $timezone';
  }

  @override
  String geoIdentityTimezoneRestored(Object timezone) {
    return 'OS timezone restored to $timezone';
  }

  @override
  String get geoIdentityTimezoneMissing =>
      'No exit timezone yet. Verify the network environment first.';

  @override
  String get geoIdentityTimezoneNothingToRestore =>
      'No previous OS timezone saved.';

  @override
  String get geoIdentityTimezoneAndroidTip =>
      'Android cannot change the system timezone without root. Open Settings → System → Date & time and pick a US zone that matches your exit.';

  @override
  String get geoIdentityCopyTerminalProxy => 'Copy terminal proxy exports';

  @override
  String get geoIdentitySetupRunning => 'Applying newbie setup…';

  @override
  String get geoIdentitySetupStarting => 'Starting FlClash…';

  @override
  String get geoIdentitySetupVerifying => 'Verifying network environment…';

  @override
  String get geoIdentitySetupTimezone => 'Aligning OS timezone…';

  @override
  String get geoIdentitySetupDoneProtected =>
      'Setup complete — network looks US-protected.';

  @override
  String get geoIdentitySetupDoneNeedUsNode =>
      'Setup applied, but the exit is not US-protected yet. Select a US node, then tap Recheck.';

  @override
  String get geoIdentityCopyTerminalProxyShort =>
      'Copy HTTP(S)_PROXY for terminals';

  @override
  String get geoIdentityOpenGeoMirrorShort => 'Browser fingerprint alignment';

  @override
  String get geoIdentityShowAdvanced => 'Show advanced';

  @override
  String get geoIdentityHideAdvanced => 'Hide advanced';

  @override
  String get enableAutoSelect => 'Create fallback auto group';

  @override
  String get enableAutoSelectCreateTip =>
      'Most subscriptions already include url-test/fallback. None was found here—create a simple “FlClash Auto” fallback group? This switches overwrite to Custom; empty custom strategy groups become Auto + PROXY (nodes stay via include-all-proxies).';

  @override
  String get enableAutoSelectFailed => 'Failed to create fallback auto group';

  @override
  String get restoreAutoSelect => 'Restore auto';

  @override
  String get groupTypeUrlTest => 'URLTest';

  @override
  String get groupTypeFallback => 'Fallback';

  @override
  String enableAutoSelectRestored(String group) {
    return 'Auto select restored for $group';
  }

  @override
  String enableAutoSelectCreated(String group) {
    return 'Created fallback auto group $group. Select it under Proxies if needed.';
  }

  @override
  String autoGroupTitle(String type) {
    return 'Auto · $type';
  }

  @override
  String autoGroupCurrent(String node) {
    return 'Current node: $node';
  }

  @override
  String autoGroupOverride(String node) {
    return 'Manual override: $node';
  }

  @override
  String get stickToRegion => 'Stick to region';

  @override
  String autoGroupStickyRegion(String region) {
    return 'Región preferida: $region';
  }

  @override
  String get autoGroupPickRegion => 'Cambiar por región';

  @override
  String autoGroupTestingRegion(String region) {
    return 'Probando $region…';
  }

  @override
  String autoGroupRegionNodes(String region, int count) {
    return '$region · $count';
  }

  @override
  String get strategyLanes => 'Strategy lanes';

  @override
  String get strategyLanesDesc =>
      'Map common services to subscription strategies or override them';

  @override
  String get strategyLanesTip =>
      'Each row is a common traffic type. Follow the subscription when it already has a strategy, or override with auto-select / a group / a node.';

  @override
  String get strategyLanesNeedStart =>
      'Start FlClash to load strategy groups from the current profile.';

  @override
  String get strategyLanesNeedProfile => 'Select a profile first.';

  @override
  String get strategyLanesLoadFailed => 'Could not load profile strategies';

  @override
  String get strategyLanesEmpty => 'No strategy groups found';

  @override
  String get strategyLanesEmptyDesc =>
      'This profile has no selectable proxy groups yet. Use a subscription with rules, or pick Auto for a business lane below.';

  @override
  String get strategyLanesBusinessTitle => 'Common services';

  @override
  String get strategyLanesExtraTitle => 'Other subscription groups';

  @override
  String get strategyLanesApplied => 'Strategy lanes applied';

  @override
  String get strategyLanesPartialApplied =>
      'Applied, but some overrides were skipped (missing group or node)';

  @override
  String get strategyLaneFollowSubscription => 'Follow subscription';

  @override
  String strategyLaneFollowWithGroup(String group) {
    return 'Follow subscription ($group)';
  }

  @override
  String get strategyLaneFollowing => 'Following subscription';

  @override
  String get strategyLaneOverridden => 'Overridden';

  @override
  String get strategyLaneUncovered =>
      'Subscription has no dedicated strategy — traffic uses the default / MATCH path';

  @override
  String strategyLaneCurrent(String node) {
    return 'Current: $node';
  }

  @override
  String strategyLaneEffective(String target) {
    return 'Effective target: $target';
  }

  @override
  String get strategyLanePolicyAuto => 'FlClash auto-select';

  @override
  String strategyLanePolicyGroup(String group) {
    return 'Group: $group';
  }

  @override
  String strategyLanePolicyProxy(String node) {
    return 'Node: $node';
  }

  @override
  String get strategyLaneKindStreaming => 'Streaming';

  @override
  String get strategyLaneKindAi => 'AI';

  @override
  String get strategyLaneKindSocial => 'Social';

  @override
  String get strategyLaneKindSearch => 'Search';

  @override
  String get strategyLaneKindMessaging => 'Messaging';

  @override
  String get strategyLaneKindGaming => 'Gaming';

  @override
  String get strategyLaneKindProxy => 'Proxy / select';

  @override
  String get strategyLaneKindOther => 'Other strategies';

  @override
  String get strategyLaneTypeSelector => 'Manual select';

  @override
  String get strategyLaneTypeLoadBalance => 'Load balance';

  @override
  String get strategyLaneTypeRelay => 'Relay';

  @override
  String get hideAdvanced => 'Hide advanced';

  @override
  String get showAdvanced => 'Show advanced';

  @override
  String get addTailscaleNode => 'Add Tailscale node';

  @override
  String get editTailscaleNode => 'Edit Tailscale node';

  @override
  String get appRouting => 'Enrutado de apps';

  @override
  String get appRoutingDesc =>
      'Enviar una app o proceso local por DIRECT, un grupo o un nodo';

  @override
  String get appRoutingTip =>
      'Estas reglas usan PROCESS-NAME y se aplican como reglas globales añadidas en perfiles estándar (no script). Activa «Buscar proceso». En Android usa el control de acceso.';

  @override
  String get appRoutingFindProcessTip =>
      'Necesario para el enrutado por proceso. Sube un poco el uso de CPU.';

  @override
  String get appRoutingEmpty => 'Aún no hay reglas de enrutado de apps';

  @override
  String get appRoutingEmptyDesc =>
      'Añade un nombre de proceso (por ejemplo chrome.exe o Cursor) y elige DIRECT, REJECT, un grupo o un nodo.';

  @override
  String get appRoutingRules => 'Reglas de proceso';

  @override
  String get appRoutingAdd => 'Añadir ruta de app';

  @override
  String get appRoutingEdit => 'Editar ruta de app';

  @override
  String get appRoutingProcessName => 'Nombre del proceso';

  @override
  String get appRoutingProcessHint => 'chrome.exe / Cursor / firefox';

  @override
  String get tuiControllerTip =>
      'TUI de escritorio: con el controlador activado, ejecuta flclash-tui en otra terminal. Puntual: flclash-tui status. En macOS: /Applications/FlClash.app/Contents/MacOS/flclash-tui. Se conecta sin bloquear la GUI.';

  @override
  String get appRoutingPickProcess => 'Elegir proceso en ejecución';

  @override
  String get appRoutingPickProcessDesc =>
      'Elige entre los procesos en ejecución en este equipo';

  @override
  String get appRoutingPickProcessTitle => 'Procesos en ejecución';

  @override
  String get appRoutingProcessLoadFailed =>
      'No se pudieron listar los procesos';

  @override
  String get appRoutingNoProcesses => 'No se encontraron procesos';

  @override
  String get tailscaleUsageTitle => 'How to use Tailscale';

  @override
  String get tailscaleUsageDesc =>
      'Pick one path. Advanced overrides stay under Advanced.';

  @override
  String get tailscaleUsageEmbeddedTitle => 'FlClash embedded node';

  @override
  String get tailscaleUsageEmbeddedBody =>
      'FlClash joins your tailnet and routes the destinations you add. On Android, keep the Tailscale app VPN off.';

  @override
  String get tailscaleUsageSystemTitle => 'System Tailscale app';

  @override
  String get tailscaleUsageSystemBodyAndroid =>
      'Let the Tailscale app own VPN. FlClash will not take the Android VPN slot.';

  @override
  String get tailscaleUsageSystemBodyDesktop =>
      'Keep Tailscale app/service traffic direct so FlClash does not hijack it. Optional embedded nodes still work.';

  @override
  String get tailscaleUsageEmbeddedApplied =>
      'Using FlClash embedded Tailscale.';

  @override
  String get tailscaleUsageSystemApplied =>
      'Preferring the system Tailscale app.';

  @override
  String get tailscaleApiTokenTitle => 'API access token';

  @override
  String get tailscaleApiTokenDesc =>
      'Paste a Tailscale API access token to mint auth keys automatically. You can still paste an auth key by hand on each node.';

  @override
  String get tailscaleApiTokenAdd => 'Add API access token';

  @override
  String get tailscaleApiTokenConfigured => 'API access token saved';

  @override
  String get tailscaleApiTokenConfiguredDesc =>
      'New nodes can generate an auth key from this token.';

  @override
  String get tailscaleApiTokenHint =>
      'From Tailscale admin → Settings → Keys → API access tokens (or a short-lived OAuth access token).';

  @override
  String get tailscaleApiTokenField => 'API access token';

  @override
  String get tailscaleApiTagsField => 'Tags (optional)';

  @override
  String get tailscaleApiTagsHint =>
      'Comma-separated tags such as tag:flclash. Required when using an OAuth client with auth_keys scope.';

  @override
  String get tailscaleApiTokenMissing =>
      'Add an API access token on the Tailscale page first.';

  @override
  String get tailscaleAuthKeyGenerate => 'Generate auth key from API token';

  @override
  String get tailscaleAuthKeyGenerating => 'Generating…';

  @override
  String get tailscaleAuthKeyGenerated =>
      'Auth key generated. You can still edit it before saving.';

  @override
  String get tailscaleAuthKeyOverrideHint =>
      'Leave blank to generate from the API token, or paste your own auth key to override.';

  @override
  String get tailscaleRoutesHintCidr =>
      'Destinations via this node, one per line. Tip: 100.64.0.0/10 already covers all Tailscale CGNAT IPs (including 100.69.x); ts.net covers MagicDNS names. Home LAN via a subnet router still needs its own CIDR (e.g. 192.168.1.0/24) — Bypass private addresses would otherwise keep RFC1918 out of the VPN.';

  @override
  String get tailscaleEnableDescShort =>
      'Inject embedded Tailscale nodes into the active profile.';

  @override
  String get tailscaleAdvancedTitle => 'Advanced';

  @override
  String get appDisplayName => 'Nombre de la app';

  @override
  String get appDisplayNameDefaultTip =>
      'Predeterminado: FlClash (el nombre en la pantalla de inicio depende del lanzador)';

  @override
  String get launcherIconKittyOrange => 'Gatito naranja';

  @override
  String get launcherIconKittyCheese => 'Gatito queso';

  @override
  String get launcherIconKittyBlack => 'Gatito negro';

  @override
  String get launcherIconKittyCalico => 'Gatito calicó';

  @override
  String get launcherIconPuppyDachshund => 'Teckel';

  @override
  String get launcherIconPuppyBulldog => 'Bulldog';

  @override
  String get launcherIconPuppyCorgi => 'Corgi';

  @override
  String get launcherIconBunny => 'Conejito';

  @override
  String get launcherIconHamster => 'Hámster';

  @override
  String get launcherIconOtter => 'Nutria';

  @override
  String get launcherIconSectionBrand => 'Marca';

  @override
  String get launcherIconSectionKitty => 'Gatos';

  @override
  String get launcherIconSectionPuppy => 'Perros';

  @override
  String get launcherIconSectionAnimal => 'Animales';

  @override
  String get liveStatus => 'Estado en vivo';

  @override
  String get coreStopped => 'Núcleo detenido';

  @override
  String get coreStoppedDesc => 'La app perdió la conexión con el núcleo';

  @override
  String coreStoppedWithReason(Object reason) {
    return 'La app perdió la conexión con el núcleo: $reason';
  }

  @override
  String mixedPortReset(Object value, Object port) {
    return 'El puerto mixto no puede ser $value, se restableció a $port';
  }

  @override
  String get restartCore => 'Reiniciar núcleo';

  @override
  String liveStatusPosition(Object index, Object count) {
    return '$index de $count';
  }

  @override
  String get coreStarting => 'Iniciando núcleo';

  @override
  String get coreStartingDesc => 'Conectando con el núcleo';

  @override
  String get coreRunning => 'Núcleo en ejecución';

  @override
  String get coreRunningDesc => 'La app está conectada al núcleo';

  @override
  String get forceRestartCore => 'Forzar reinicio';

  @override
  String get vpnPermissionNotGranted =>
      'No se concedió el permiso de VPN, así que la VPN no se inició. Una VPN siempre activa configurada en otra app también lo impide.';

  @override
  String get vpnServiceStartFailed => 'No se pudo iniciar el servicio VPN.';

  @override
  String get findProcessMode => 'Buscar proceso';
}
