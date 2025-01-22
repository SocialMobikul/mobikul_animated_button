# MobiKul Animated Button Flutter Package

The MobiKul Animated Button is a customizable Flutter widget designed to create visually appealing and animated buttons with various customization options. It supports color animations, gradients, scaling effects, and border animations, making it ideal for modern UI design.

To find out more: https://mobikul.com/

## Features
 - **Border Animations**: Smooth scaling effects for button interactions.

 - **Wave Animations**: Smooth scaling effects for button interactions.

 - **Slider Animations**: Smooth scaling effects for button interactions.

 - **Scale Animations**: Smooth scaling effects for button interactions.

 - **Fade Animations**: Fading transitions for the button's appearance.

 - **Loading State**: Show a loading indicator when the button is pressed.

 - **Sliding Color Animation**: Dynamic slide-in color transitions based on the button's position.

 - **Animated Color Text**: Change text color with smooth transitions.


## Getting started

Add the latest version of package to your pubspec.yaml (and run dart pub get):

```yaml
 dependencies:
  flutter:
    sdk: flutter
  mobikul_animated_button: ^0.0.1 # Replace with the latest version
```

## Usage

```dart
import 'package:mobikul_animated_button/mobikul_animated_button.dart';
```

After importing the above line into your code.The usage is quite straightforward. Simply use the name of the button in Pascal Case.

**you can use the MobiKul Border Button just like any other widget.**

```dart
MobiKulBorderButton(
onPressed: () {},
text: 'Border Animated Button',
);
```

**you can use the MobiKul Wave Button just like any other widget.**

```dart
MobiKulWaveButton(
onPressed: () {},
text: 'Wave Button',
),
```

**you can use the MobiKul Slider Button just like any other widget.**

```dart
MobiKulSliderButton(
onPressed: () {},
text: 'Wave Button',
),
```

**you can use the MobiKul Animated Button just like any other widget.**

```dart
MobiKulAnimatedButton(
onPressed: () {},
text: 'Color Slider Button',
),
```

The properties **onPressed** and **text** are both required.

## Properties

Here are several key properties supported by the package:

<!-- TABLE_GENERATE_START -->

| Properties | Description                                                                                |
|--|--------------------------------------------------------------------------------------------|
| **text**                | The text displayed on the button. |
| **onPressed**           | The callback function that is triggered when the button is tapped.                         |
| **backgroundColor**     | The default background color of the button.                                                |
| **selectedColor**       | The color of the button when it is in the selected state.                                  |
| **textFirstColor**      | The color of the button text when it's in its first state.                                 |
| **textSecondColor**     | The color of the button text when it's in its second state.                                |
| **finalScale**          | The scale factor for the button's animation when in the selected state.                    |
| **initialScale**        | The scale factor for the button's animation when in the unselected state.                  |
| **opacity**             | The opacity of the button (affects the button's visibility).                               |
| **fadeStart**           | The starting opacity for the fade animation.                                               |
| **fadeEnd**             | The ending opacity for the fade animation.                                                 |
| **position**            | Defines where the text is positioned relative to the button (e.g., top, left).             |
| **enableColorAnimation**| A boolean flag to enable or disable the color animation.                                   |
| **isReverse**           | A boolean flag to reverse the animation when completed.                                    |
| **icon**                | (Optional) An icon that can be displayed alongside the text.                               |
<!-- TABLE_GENERATE_END -->

## Sample Usage
```dart
MobiKulAnimatedButton(
text: 'Click Me',
onPressed: () {
print('Button pressed');
},
enableColorAnimation: true,
),      
```
## Output 

Here is a video showcasing the MobiKul Animated Button in action:

## Border Animated Button
![Border Animated Button](https://raw.githubusercontent.com/SocialMobikul/mobikul_animated_button/main/border_animation.gif)

## Wave Animated Button
![Wave Animated Button](https://raw.githubusercontent.com/SocialMobikul/mobikul_animated_button/main/Wave.gif)

## Slider Animated Button
![Slider Animated Button](https://raw.githubusercontent.com/SocialMobikul/mobikul_animated_button/main/slider.gif)

## MobiKul Animated Button
![MobiKul Animated Button](https://raw.githubusercontent.com/SocialMobikul/mobikul_animated_button/main/Mobikul_animated.gif)




























