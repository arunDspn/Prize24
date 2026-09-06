import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/view_profile/ui/profile_page.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/view_profile/view_models/update_user_phone_number_controller.dart';
import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/repository/user/user_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const phoneChannel = MethodChannel('plugin.libphonenumber');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(phoneChannel, null);
  });

  test('phone controller persists E.164 values and clearing', () async {
    final user = _appUser();
    final userRepository = _FakeUserRepository(user);
    final container = _container(user, userRepository);
    addTearDown(container.dispose);
    await container.read(authControllerProvider.future);

    final subscription = container.listen(
      updateUserPhoneNumberControllerProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    await container
        .read(updateUserPhoneNumberControllerProvider.notifier)
        .updateUserPhoneNumber(' +919878987678 ');

    expect(userRepository.lastPhoneNumber, '+919878987678');
    expect(
      container.read(updateUserPhoneNumberControllerProvider).requireValue,
      '+919878987678',
    );

    await container
        .read(updateUserPhoneNumberControllerProvider.notifier)
        .updateUserPhoneNumber('');

    expect(userRepository.lastPhoneNumber, '');
  });

  test('auth controller updates the locally displayed phone number', () async {
    final user = _appUser();
    final container = _container(user, _FakeUserRepository(user));
    addTearDown(container.dispose);
    await container.read(authControllerProvider.future);

    container
        .read(authControllerProvider.notifier)
        .updateUserPhoneNumber('+919878987678');

    expect(
      container.read(authControllerProvider).requireValue?.userPhoneNumber,
      '+919878987678',
    );
  });

  testWidgets('shows user phone for every user and vendor phone for vendors', (
    tester,
  ) async {
    final standardUser = _appUser();
    final standardContainer = await _pumpUserDetails(tester, standardUser);

    expect(find.text('USER PHONE'), findsOneWidget);
    expect(find.text('VENDOR PHONE'), findsNothing);
    expect(find.byKey(const Key('edit-user-phone-button')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const Key('user-phone-row')),
        matching: find.text(''),
      ),
      findsOneWidget,
    );

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    standardContainer.dispose();

    final vendor = _appUser(isVendor: true, vendorPhoneNumber: '+919999999999');
    final vendorContainer = await _pumpUserDetails(tester, vendor);

    expect(find.text('USER PHONE'), findsOneWidget);
    expect(find.text('VENDOR PHONE'), findsOneWidget);
    expect(find.text('+919999999999'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    vendorContainer.dispose();
  });

  testWidgets('normalizes and saves a valid user phone number', (tester) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(phoneChannel, (methodCall) async {
          final arguments = methodCall.arguments! as Map<Object?, Object?>;
          final phoneNumber = arguments['phoneNumber'] as String?;
          final isoCode = arguments['isoCode'] as String?;
          if (phoneNumber == '9878987678' && isoCode == 'IN') {
            if (methodCall.method == 'isValidPhoneNumber') return true;
            if (methodCall.method == 'normalizePhoneNumber') {
              return '+919878987678';
            }
          }
          return false;
        });

    final user = _appUser();
    final repository = _FakeUserRepository(user);
    final container = await _pumpUserDetails(
      tester,
      user,
      repository: repository,
    );
    await tester.tap(find.byKey(const Key('edit-user-phone-button')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('user-phone-input')),
      '9878987678',
    );
    await tester.tap(find.byKey(const Key('save-user-phone-button')));
    await tester.pumpAndSettle();

    expect(repository.lastPhoneNumber, '+919878987678');
    expect(find.text('Edit User Phone Number'), findsNothing);
    expect(
      container.read(authControllerProvider).requireValue?.userPhoneNumber,
      '+919878987678',
    );

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    container.dispose();
  });

  testWidgets('keeps the dialog open when persistence fails', (tester) async {
    final user = _appUser();
    final repository = _FakeUserRepository(user)..shouldFail = true;
    final container = await _pumpUserDetails(
      tester,
      user,
      repository: repository,
    );
    await tester.tap(find.byKey(const Key('edit-user-phone-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('save-user-phone-button')));
    await tester.pumpAndSettle();

    expect(find.text('Edit User Phone Number'), findsOneWidget);
    expect(
      find.text('Failed to update phone number. Please try again.'),
      findsOneWidget,
    );

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    container.dispose();
  });

  testWidgets('prefills an existing E.164 phone number', (tester) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(phoneChannel, (methodCall) async {
          if (methodCall.method == 'isValidPhoneNumber') return true;
          return null;
        });

    final user = _appUser(userPhoneNumber: '+919878987678');
    final container = await _pumpUserDetails(tester, user);

    await tester.tap(find.byKey(const Key('edit-user-phone-button')));
    await tester.pumpAndSettle();

    final phoneField = tester.widget<TextField>(
      find.byKey(const Key('user-phone-input')),
    );
    expect(phoneField.controller?.text, '9878987678');

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    container.dispose();
  });

  testWidgets('rejects an invalid non-empty phone number', (tester) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(phoneChannel, (methodCall) async => false);

    final user = _appUser();
    final repository = _FakeUserRepository(user);
    final container = await _pumpUserDetails(
      tester,
      user,
      repository: repository,
    );

    await tester.tap(find.byKey(const Key('edit-user-phone-button')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('user-phone-input')), '123');
    await tester.tap(find.byKey(const Key('save-user-phone-button')));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a valid phone number'), findsOneWidget);
    expect(repository.lastPhoneNumber, isNull);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    container.dispose();
  });
}

ProviderContainer _container(AppUser user, _FakeUserRepository userRepository) {
  return ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(_FakeAuthRepository(user)),
      userRepositoryProvider.overrideWithValue(userRepository),
    ],
  );
}

Future<ProviderContainer> _pumpUserDetails(
  WidgetTester tester,
  AppUser user, {
  _FakeUserRepository? repository,
}) async {
  final container = _container(user, repository ?? _FakeUserRepository(user));
  await container.read(authControllerProvider.future);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: Scaffold(body: UserDetailsSection())),
    ),
  );
  await tester.pump();
  return container;
}

AppUser _appUser({
  bool isVendor = false,
  String userPhoneNumber = '',
  String? vendorPhoneNumber,
}) {
  return AppUser(
    userId: 'user-1',
    userEmail: 'user@example.com',
    userName: 'Test User',
    isVendor: isVendor,
    fcmToken: '',
    referralCode: 'REF12345',
    userPhoneNumber: userPhoneNumber,
    vendorPhoneNumber: vendorPhoneNumber,
  );
}

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository(this.user);

  final AppUser user;

  @override
  Future<AppUser?> checkAuth() async => user;

  @override
  Stream<AppUser?> onAuthChange() => Stream.value(user);

  @override
  Future<void> setReferrerCode(String referralCode) async {}

  @override
  Future<AppUser?> signInWithApple() async => user;

  @override
  Future<AppUser?> signInWithGoogle() async => user;

  @override
  Future<void> signOut() async {}
}

class _FakeUserRepository implements UserRepository {
  _FakeUserRepository(this.user);

  final AppUser user;
  String? lastPhoneNumber;
  bool shouldFail = false;

  @override
  Future<void> editUserProfile({
    required String userId,
    required String? userName,
    required String? imageUrl,
  }) async {}

  @override
  Future<AppUser> getUserProfile() async => user;

  @override
  Future<String?> getUserNameById(String userId) async => user.userName;

  @override
  Future<void> updateUserName({
    required String userId,
    required String newUserName,
  }) async {}

  @override
  Future<void> updateUserPhoneNumber({
    required String userId,
    required String userPhoneNumber,
  }) async {
    if (shouldFail) throw Exception('write failed');
    lastPhoneNumber = userPhoneNumber;
  }
}
