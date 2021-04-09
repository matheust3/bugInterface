import 'package:assist_agro/features/admin/presentation/pages/add_user_page.dart';
import 'package:assist_agro/features/admin/presentation/widgets/page_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_page_state.dart';

class AdminPageCubit extends Cubit<AdminPageState> {
  late PageModel lastPage;
  double paddingSize;
  AdminPageCubit({required this.paddingSize}) : super(AdminPageInitial()) {
    /// Para nao ser null
    lastPage = AddUserPage();
    newPage(lastPage);
  }

  /// Emite uma nova pagina para a view
  void newPage(PageModel page) {
    lastPage = page;
    emit(NewPageState(pageWidget: page, paddingSize: this.paddingSize));
  }

  void resizeEvent(double newSidebarWidth) {
    paddingSize = newSidebarWidth;
    emit(ResizePage(paddingSize: paddingSize, pageWidget: lastPage));
  }
}
