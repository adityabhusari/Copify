abstract class FavButtonState{}

class FavButtonInitial extends FavButtonState{}

class FavButtonUpdated extends FavButtonState{
  final bool isFav;

  FavButtonUpdated({required this.isFav});
}