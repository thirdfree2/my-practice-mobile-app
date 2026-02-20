########################################################################
### 1. Patterns Goal
########################################################################
- แยกโค้ดตาม feature (เช่น counter, home, booking)
- ในแต่ละ feature แยกตาม “ชั้น”
    - view/bloc = UI & state management
    - domain = กฎธุรกิจ (Entity, Repository interface)
    - data = เรียก API/DB + แปลงข้อมูล (DataSource, Model, Repository impl)
- เปลี่ยน API/Mock ได้โดยไม่แตะ UI มาก
########################################################################

########################################################################
### 2. Workspace
########################################################################
lib/
  bootstrap/              // init app, env, logger, flavor
  core/                   // shared: network, errors, utils, constants
  features/
    <feature_name>/
      bloc/               // Bloc + event/state
      view/               // Page/Widget ของ feature
      domain/
        entities/         // Entity (business object)
        repositories/     // abstract repository (interface)
      data/
        datasources/      // remote/local datasource
        models/           // DTO/Model + fromJson/toJson
        repositories/     // impl ของ repository
  app_dependencies.dart   // DI wiring (ApiClient, repos, blocs)
  app.dart                // MaterialApp + routes
  main.dart               // entry point
########################################################################

########################################################################
### 3. Rules
########################################################################
- domain ห้าม import จาก data หรือ view/bloc
- data import domain ได้
- bloc import domain ได้ (และบางที import model ไม่ควร)
- view import bloc ได้
########################################################################

########################################################################
### 4.Naming Convention
########################################################################
[bloc]:
    - <feature>_bloc.dart
    - <feature>_event.dart
    - <feature>_state.dart

[domain]:
    - entities/<feature>_<thing>.dart (เช่น counter_summary.dart)
    - repositories/<feature>_repository.dart

[data]:
    - models/<feature>_<thing>_model.dart
    - datasources/<feature>_remote_data_source.dart
    - repositories/<feature>_repository_impl.dart

[view]:
    - <feature>_page.dart หรือ <feature>.dart (เลือกแบบเดียวทั้งโปรเจกต์)

[ชื่อคลาส]
    - Repository interface: CounterRepository
    - Repository impl: CounterRepositoryImpl
    - Remote DS: CounterRemoteDataSource

[Model]: 
    - CounterSummaryModel

[Entity]: 
    - CounterSummary
########################################################################

########################################################################
### 5. ขั้นตอนเพิ่ม Feature ใหม่ (Checklist)
########################################################################

[Step A]: สร้างโฟลเดอร์
    features/booking/
        bloc/
        view/
        domain/entities/
        domain/repositories/
        data/datasources/
        data/models/
        data/repositories/

[Step B]: Domain (เริ่มจาก interface ก่อน)

# Entity
    // features/booking/domain/entities/booking.dart
    class Booking {
        final String id;
        final String title;

        Booking({required this.id, required this.title});
    }

# Repository interface
    // features/booking/domain/repositories/booking_repository.dart
    abstract class BookingRepository {
        Future<List<Booking>> getBookings();
    }

[Step C]: Data (ทำ model + datasource + impl)
    1. Model
    // features/booking/data/models/booking_model.dart
    import '../../domain/entities/booking.dart';

    class BookingModel {
        final String id;
        final String title;

        BookingModel({required this.id, required this.title});

        factory BookingModel.fromJson(Map<String, dynamic> json) {
            return BookingModel(id: json['id'], title: json['title']);
        }

        Booking toEntity() => Booking(id: id, title: title);
    }

    2. RemoteDataSource
    // features/booking/data/datasources/booking_remote_data_source.dart
    class BookingRemoteDataSource {
        final ApiClient api;

        BookingRemoteDataSource(this.api);

        Future<List<BookingModel>> fetchBookings() async {
            final res = await api.get('/bookings');
            return (res as List).map((e) => BookingModel.fromJson(e)).toList();
        }
    }

    3. Repository Impl
    // features/booking/data/repositories/booking_repository_impl.dart
    import '../../domain/repositories/booking_repository.dart';
    import '../../domain/entities/booking.dart';
    import '../datasources/booking_remote_data_source.dart';

    class BookingRepositoryImpl implements BookingRepository {
    final BookingRemoteDataSource remote;

    BookingRepositoryImpl(this.remote);

    @override
    Future<List<Booking>> getBookings() async {
            final models = await remote.fetchBookings();
            return models.map((m) => m.toEntity()).toList();
        }
    }

[Step D]: Bloc (presentation logic)

// features/booking/bloc/booking_event.dart
    sealed class BookingEvent {}
    class BookingStarted extends BookingEvent {}

// features/booking/bloc/booking_state.dart
    sealed class BookingState {}
    class BookingInitial extends BookingState {}
    class BookingLoading extends BookingState {}
    class BookingLoaded extends BookingState {
    final List<Booking> items;
    BookingLoaded(this.items);
    }
    class BookingError extends BookingState {
    final String message;
    BookingError(this.message);
    }

// features/booking/bloc/booking_bloc.dart
    class BookingBloc extends Bloc<BookingEvent, BookingState> {
    final BookingRepository repo;

    BookingBloc({required this.repo}) : super(BookingInitial()) {
        on<BookingStarted>((event, emit) async {
        emit(BookingLoading());
                try {
                    final items = await repo.getBookings();
                    emit(BookingLoaded(items));
                } catch (e) {
                    emit(BookingError(e.toString()));
                }
            });
        }
    }

[Step E]: View
// features/booking/view/booking_page.dart
    class BookingPage extends StatelessWidget {
    const BookingPage({super.key});

    @override
    Widget build(BuildContext context) {
        return BlocProvider(
        create: (ctx) => BookingBloc(repo: ctx.read<BookingRepository>())..add(BookingStarted()),
        child: Scaffold(
            appBar: AppBar(title: const Text('Booking')),
            body: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
                            if (state is BookingLoading) return const Center(child: CircularProgressIndicator());
                            if (state is BookingLoaded) return ListView(
                            children: state.items.map((e) => ListTile(title: Text(e.title))).toList(),
                            );
                            if (state is BookingError) return Center(child: Text(state.message));
                            return const SizedBox();
                        },
                    ),
                ),
            );
        }
    }

[Step F]: DI wiring[Step F]: DI wiring (จุดที่คนมักพลาด)
    - ใน app_dependencies.dart ให้ register repo/dataSource ไว้ที่เดียว เช่น
        BookingRemoteDataSource
        BookingRepositoryImpl as BookingRepository
    แล้วใน Bloc ค่อย read<BookingRepository>()
########################################################################

########################################################################
### 5. ขั้นตอนเพิ่ม Feature ใหม่ (Checklist)
########################################################################
    ✅ Domain ห้ามมี dio, flutter, bloc
    ✅ Model ต้องมี toEntity() เสมอ
    ✅ RepositoryImpl ต้อง return Entity ไม่ return Model
    ✅ View ห้ามเรียก ApiClient ตรง ๆ
    ✅ ทุก feature ต้องมี 4 โฟลเดอร์หลัก: bloc/ view/ domain/ data/
########################################################################