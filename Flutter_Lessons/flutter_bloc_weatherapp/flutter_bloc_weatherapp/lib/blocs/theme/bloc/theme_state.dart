part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeApplication extends ThemeState {
  final ThemeData theme;
  final MaterialColor color;

  const ThemeApplication({required this.theme, required this.color});
}
