class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'أثر';
  static const String appTagline = 'منصة التعليم الذكي';
  static const String appDescription = 'نظام إدارة المدارس المتكامل';

  // Splash
  static const String splashWelcome = 'مرحباً بك في أثر';
  static const String splashSubtitle = 'منصة تعليمية شاملة تربط إدارة المدرسة، المعلمين والطلاب';

  // Auth – Login
  static const String loginTitle = 'تسجيل الدخول';
  static const String loginSubtitle = 'أهلاً بعودتك! سجّل دخولك للمتابعة';
  static const String emailLabel = 'البريد الإلكتروني';
  static const String emailHint = 'أدخل بريدك الإلكتروني';
  static const String passwordLabel = 'كلمة المرور';
  static const String passwordHint = 'أدخل كلمة المرور';
  static const String loginButton = 'تسجيل الدخول';
  static const String forgotPassword = 'نسيت كلمة المرور؟';
  static const String selectRole = 'اختر دورك في المنصة';
  static const String loginSuccess = 'تم تسجيل الدخول بنجاح';

  // Roles
  static const String roleAdmin = 'المدير العام';
  static const String rolePrincipal = 'مدير المدرسة';
  static const String roleTeacher = 'المعلم';
  static const String roleStudent = 'الطالب';

  static const String roleAdminDesc = 'إدارة شاملة للنظام';
  static const String rolePrincipalDesc = 'إدارة المدرسة والكوادر';
  static const String roleTeacherDesc = 'تدريس وإدارة الفصول';
  static const String roleStudentDesc = 'متابعة الدراسة والنشاطات';

  // Errors
  static const String errorWrongPassword = 'كلمة المرور غير صحيحة';
  static const String errorUserNotFound = 'المستخدم غير موجود';
  static const String errorNetworkError = 'خطأ في الاتصال بالشبكة، تحقق من اتصالك بالإنترنت';
  static const String errorEmailInvalid = 'البريد الإلكتروني غير صحيح';
  static const String errorEmailRequired = 'البريد الإلكتروني مطلوب';
  static const String errorPasswordRequired = 'كلمة المرور مطلوبة';
  static const String errorPasswordTooShort = 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
  static const String errorRoleRequired = 'الرجاء اختيار دورك في المنصة';
  static const String errorRoleMismatch = 'الدور المختار لا يتطابق مع حسابك';
  static const String errorUnknown = 'حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى';
  static const String errorEmailAlreadyInUse = 'البريد الإلكتروني مستخدم بالفعل';
  static const String errorWeakPassword = 'كلمة المرور ضعيفة جداً';

  // Dashboard
  static const String adminDashboard = 'لوحة المدير العام';
  static const String principalDashboard = 'لوحة مدير المدرسة';
  static const String teacherDashboard = 'لوحة المعلم';
  static const String studentDashboard = 'لوحة الطالب';

  static const String welcomeAdmin = 'مرحباً، أيها المدير';
  static const String welcomePrincipal = 'مرحباً، أيها الناظر';
  static const String welcomeTeacher = 'مرحباً، أيها المعلم';
  static const String welcomeStudent = 'مرحباً، أيها الطالب';

  static const String dashboardComingSoon = 'قريباً';
  static const String dashboardPhase2 = 'هذا القسم سيكون متاحاً في المرحلة القادمة';

  // Common
  static const String logout = 'تسجيل الخروج';
  static const String logoutConfirm = 'هل أنت متأكد من تسجيل الخروج؟';
  static const String yes = 'نعم';
  static const String no = 'لا';
  static const String ok = 'حسناً';
  static const String cancel = 'إلغاء';
  static const String loading = 'جاري التحميل...';
  static const String retry = 'إعادة المحاولة';
  static const String settings = 'الإعدادات';
  static const String profile = 'الملف الشخصي';
  static const String notifications = 'الإشعارات';
  static const String search = 'بحث...';

  // Quick Stats labels (placeholder)
  static const String totalStudents = 'إجمالي الطلاب';
  static const String totalTeachers = 'إجمالي المعلمين';
  static const String totalClasses = 'عدد الفصول';
  static const String attendanceRate = 'معدل الحضور';

  // Firestore Collections
  static const String usersCollection = 'users';
}
