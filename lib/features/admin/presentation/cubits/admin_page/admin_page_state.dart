part of 'admin_page_cubit.dart';

abstract class AdminPageState extends Equatable {
  const AdminPageState();

  @override
  List<Object> get props => [];
}

class AdminPageInitial extends AdminPageState {}

///Nova pagina da view
class NewPageState extends AdminPageState {
  final PageModel pageWidget;
  final double paddingSize;

  NewPageState({required this.pageWidget, required this.paddingSize});

  @override
  List<Object> get props => [this.pageWidget, this.paddingSize];
}

///Quando o sidebar muda de tamanho
class ResizePage extends AdminPageState {
  final double paddingSize;
  final PageModel pageWidget;

  ResizePage({required this.paddingSize, required this.pageWidget});

  List<Object> get props => [this.paddingSize, this.pageWidget];
}
