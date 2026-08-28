/// Catalog of HTTP probes used to gauge current-node reachability.
///
/// These are latency/reachability checks via the Clash `URLTest` path — not
/// streaming unlock or account-region tests.
enum ServiceProbeCategory {
  search,
  social,
  ai,
  streaming,
  general,
}

class ServiceProbe {
  final String id;
  final ServiceProbeCategory category;
  final String url;
  final String brand;

  const ServiceProbe({
    required this.id,
    required this.category,
    required this.url,
    required this.brand,
  });
}

const serviceProbes = <ServiceProbe>[
  // Search
  ServiceProbe(
    id: 'google',
    category: ServiceProbeCategory.search,
    url: 'https://www.gstatic.com/generate_204',
    brand: 'Google',
  ),
  ServiceProbe(
    id: 'bing',
    category: ServiceProbeCategory.search,
    url: 'https://www.bing.com/',
    brand: 'Bing',
  ),
  ServiceProbe(
    id: 'wikipedia',
    category: ServiceProbeCategory.search,
    url: 'https://www.wikipedia.org/',
    brand: 'Wikipedia',
  ),
  // Social / forums
  ServiceProbe(
    id: 'reddit',
    category: ServiceProbeCategory.social,
    url: 'https://www.reddit.com/',
    brand: 'Reddit',
  ),
  ServiceProbe(
    id: 'discord',
    category: ServiceProbeCategory.social,
    url: 'https://discord.com/api/v9/gateway',
    brand: 'Discord',
  ),
  ServiceProbe(
    id: 'x',
    category: ServiceProbeCategory.social,
    url: 'https://x.com/',
    brand: 'X',
  ),
  // AI
  ServiceProbe(
    id: 'chatgpt',
    category: ServiceProbeCategory.ai,
    url: 'https://chatgpt.com/',
    brand: 'ChatGPT',
  ),
  ServiceProbe(
    id: 'claude',
    category: ServiceProbeCategory.ai,
    url: 'https://claude.ai/',
    brand: 'Claude',
  ),
  ServiceProbe(
    id: 'gemini',
    category: ServiceProbeCategory.ai,
    url: 'https://gemini.google.com/',
    brand: 'Gemini',
  ),
  // Streaming
  ServiceProbe(
    id: 'youtube',
    category: ServiceProbeCategory.streaming,
    url: 'https://www.youtube.com/generate_204',
    brand: 'YouTube',
  ),
  ServiceProbe(
    id: 'netflix',
    category: ServiceProbeCategory.streaming,
    url: 'https://www.netflix.com/title/80018499',
    brand: 'Netflix',
  ),
  ServiceProbe(
    id: 'appletv',
    category: ServiceProbeCategory.streaming,
    url: 'https://tv.apple.com/',
    brand: 'Apple TV',
  ),
  ServiceProbe(
    id: 'disney',
    category: ServiceProbeCategory.streaming,
    url: 'https://www.disneyplus.com/',
    brand: 'Disney+',
  ),
  // General
  ServiceProbe(
    id: 'github',
    category: ServiceProbeCategory.general,
    url: 'https://github.com/',
    brand: 'GitHub',
  ),
  ServiceProbe(
    id: 'cloudflare',
    category: ServiceProbeCategory.general,
    url: 'https://www.cloudflare.com/cdn-cgi/trace',
    brand: 'Cloudflare',
  ),
];

const maxConcurrentServiceProbes = 4;

const flClashAutoGroupName = 'FlClash Auto';
const flClashProxyGroupName = 'PROXY';

extension ServiceProbeCategoryExt on ServiceProbeCategory {
  List<ServiceProbe> get probes =>
      serviceProbes.where((item) => item.category == this).toList();
}
