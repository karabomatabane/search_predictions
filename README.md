# Predictive Search Widget

A Flutter widget for implementing predictive search functionality with customizable predictions list.

## Installation

Add the `predictive_search` package to your `pubspec.yaml` file:

```yaml
dependencies:
  predictive_search: ^1.0.0
```

Replace `^1.0.0` with the latest version and run `flutter pub get` to install the package.

## Usage

Import the `PredictiveSearch` widget:

```dart
import 'package:predictive_search/predictive_search.dart';
```

Use the `PredictiveSearch` widget in your Flutter app:

```dart
PredictiveSearch(
  objs: yourListOfSearchObjects,
  onTap: () {
    // Handle tap event
  },
  placeholder: 'Search something...',
)
```

## Parameters

- **objs**: List of `SearchObject` instances used for predictions.
- **onTap**: Callback function triggered when a prediction is tapped.
- **placeholder**: (Optional) Placeholder text for the search input.

## Example

```dart
PredictiveSearch(
  objs: yourListOfSearchObjects,
  onTap: () {
    // Handle tap event
  },
  placeholder: 'Search something...',
)
```

## Customization

The widget supports customization of the placeholder, appearance, and more. Refer to the parameters section for details.

## Screenshots
</br>
</br>
<img src="https://github.com/karabomatabane/search_predictions/assets/83251573/c33d0768-7ec9-4bfd-90e7-40377200b1b0" alt="drawing" width="200"/>

## Contributions

Contributions are welcome! If you find any issues or have suggestions for improvements, please create an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Author

- Karabo Matabane
    - Email: karaboramakau@gmail.com

