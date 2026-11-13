# LIX

LIX is a Flutter AI assistant with a lavender glass interface, voice mode, chat, and OpenStreetMap place recommendations.

## Run

1. Install Flutter stable and an Android SDK.
2. Run `flutter pub get`.
3. Run `flutter analyze` and `flutter test`.
4. Launch with `flutter run`.

## AI service integration

All provider seams live in `lib/core/ai/`. Replace the implementations registered in
`providers.dart` without changing the screens. `AiPlace` serializes the following
backend shape:

```json
{
  "id": "patan-durbar",
  "name": "Patan Durbar Square",
  "category": "Heritage",
  "lat": 27.6728,
  "lng": 85.3255,
  "address": "Mangal Bazaar, Lalitpur",
  "rating": 4.7
}
```

Attach a `List<AiPlace>` to `ChatMessage.places` to render an inline map card.
Implement `PlaceAiService.recommendPlaces` for the real recommendation API and
register it as `placeAiServiceProvider`.

## Maps and OpenStreetMap

Map configuration is centralized in `lib/core/config/map_config.dart`. The public
OpenStreetMap tile server is intended for light development traffic only. Before
production, use a self-hosted or commercial OSM tile provider and update the
template there. The app displays OpenStreetMap attribution and sends a User-Agent
package name to the tile layer. Location permissions are declared but should only
be requested after the user explicitly enables a location-dependent feature.

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
