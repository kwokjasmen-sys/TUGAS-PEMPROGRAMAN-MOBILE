import 'package:flutter/material.dart';

void main() {
  runApp(const ELibraryApp());
}

class ELibraryApp extends StatelessWidget {
  const ELibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Library Express',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

// ==================== LOGIN PAGE ====================
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Map<String, Map<String, String>> _demoAccounts = {
    'admin@elibrary.com': {'password': 'admin123', 'role': 'admin'},
    'student@elibrary.com': {'password': 'student123', 'role': 'student'},
  };

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Login Gagal'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(), child: const Text('OK'))
        ],
      ),
    );
  }

  void _attemptLogin() {
    final email = emailController.text.trim();
    final pwd = passwordController.text;

    if (email.isEmpty || pwd.isEmpty) {
      _showError('Email dan password harus diisi.');
      return;
    }

    final account = _demoAccounts[email];
    if (account == null) {
      _showError(
          'Akun tidak ditemukan.  Gunakan akun demo atau daftar dahulu.');
      return;
    }

    if (account['password'] != pwd) {
      _showError('Password salah.');
      return;
    }

    final role = account['role'] ?? 'student';
    if (role == 'admin') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AdminDashboardPage()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const StudentDashboardPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2563EB),
                    Color(0xFF3B82F6),
                    Color(0xFF06B6D4)
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.menu_book, size: 100, color: Colors.white),
                    SizedBox(height: 24),
                    Text('E-Library',
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 8),
                    Text('Perpustakaan Premium School',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: Center(
                child: Container(
                  width: 450,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(0, 10))
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Masuk ke Perpustakaan Premium School',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 16)),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 16)),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _attemptLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('LOGIN',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage())),
                        child: const Text('Register Akun Baru',
                            style: TextStyle(
                                color: Color(0xFF2563EB), fontSize: 16)),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                          'Akun demo:\nadmin@elibrary.com / admin123\nstudent@elibrary.com / student123',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== REGISTER PAGE ====================
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF9333EA),
                    Color(0xFFEC4899),
                    Color(0xFFEF4444)
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person_add, size: 100, color: Colors.white),
                    SizedBox(height: 24),
                    Text('Bergabung Dengan E-Library',
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center),
                    SizedBox(height: 8),
                    Text('Perpustakaan Premium School',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: 450,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(0, 10))
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Daftar Anggota Baru',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                labelText: 'Nama Lengkap',
                                border: UnderlineInputBorder())),
                        const SizedBox(height: 12),
                        TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                border: UnderlineInputBorder())),
                        const SizedBox(height: 12),
                        TextField(
                            controller: phoneController,
                            decoration: const InputDecoration(
                                labelText: 'No.  Telepon',
                                border: UnderlineInputBorder())),
                        const SizedBox(height: 12),
                        TextField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                                border: UnderlineInputBorder())),
                        const SizedBox(height: 12),
                        TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                border: UnderlineInputBorder())),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9333EA),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            minimumSize: const Size(double.infinity, 46),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('DAFTAR',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Sudah punya akun? Login',
                              style: TextStyle(
                                  color: Color(0xFF9333EA), fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== ADMIN DASHBOARD ====================
class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  String selectedMenu = 'Dashboard';
  bool sidebarExpanded = true;

  List<Map<String, dynamic>> books = [
    {
      'id': 1,
      'title': 'Pemrograman Web',
      'author': 'John Doe',
      'stock': 15,
      'borrowed': 5,
      'price': 50000
    },
    {
      'id': 2,
      'title': 'Database MySQL',
      'author': 'Jane Smith',
      'stock': 20,
      'borrowed': 8,
      'price': 75000
    },
    {
      'id': 3,
      'title': 'Algoritma Pemrograman',
      'author': 'Bob Wilson',
      'stock': 12,
      'borrowed': 3,
      'price': 60000
    },
  ];

  List<Map<String, dynamic>> borrowings = [
    {
      'id': 1,
      'bookTitle': 'Pemrograman Web',
      'borrower': 'Ahmad',
      'date': '2026-01-10',
      'status': 'Dipinjam'
    },
    {
      'id': 2,
      'bookTitle': 'Database MySQL',
      'borrower': 'Siti',
      'date': '2026-01-12',
      'status': 'Dipinjam'
    },
    {
      'id': 3,
      'bookTitle': 'Algoritma Pemrograman',
      'borrower': 'Budi',
      'date': '2026-01-13',
      'status': 'Dikembalikan'
    },
  ];

  List<Map<String, dynamic>> employees = [
    {
      'id': 1,
      'name': 'JASMEN',
      'role': 'Admin',
      'email': 'jasmen@elibrary.com',
      'status': 'Active'
    },
    {
      'id': 2,
      'name': 'Rina',
      'role': 'Librarian',
      'email': 'rina@elibrary.com',
      'status': 'Active'
    },
    {
      'id': 3,
      'name': 'Doni',
      'role': 'Staff',
      'email': 'doni@elibrary.com',
      'status': 'Active'
    },
  ];

  int get totalBooks =>
      books.fold(0, (sum, book) => sum + (book['stock'] as int));
  int get totalBorrowed =>
      books.fold(0, (sum, book) => sum + (book['borrowed'] as int));
  int get totalIncome =>
      borrowings.where((b) => b['status'] == 'Dikembalikan').length * 5000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: sidebarExpanded ? 250 : 70,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10)
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]!))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (sidebarExpanded)
                        Row(
                          children: const [
                            Icon(Icons.menu_book, color: Colors.blue, size: 32),
                            SizedBox(width: 8),
                            Text('E-Library',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      IconButton(
                        icon: Icon(sidebarExpanded ? Icons.close : Icons.menu),
                        onPressed: () =>
                            setState(() => sidebarExpanded = !sidebarExpanded),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (sidebarExpanded)
                        Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text('MENU',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[700]))),
                      _buildMenuItem(Icons.dashboard, 'Dashboard'),
                      _buildMenuItem(Icons.book, 'Daftar Buku'),
                      _buildMenuItem(Icons.calendar_today, 'Peminjaman'),
                      _buildMenuItem(Icons.people, 'Employee'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text('A',
                                  style: TextStyle(color: Colors.white))),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Selamat Datang, Admin!',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('E-Library - Perpustakaan Premium School',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.search), onPressed: () {}),
                          IconButton(
                              icon: const Icon(Icons.logout, color: Colors.red),
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginPage()))),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                        color: Colors.grey[100], child: _buildContent())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    bool isSelected = selectedMenu == title;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(icon,
            color: isSelected ? Colors.white : Colors.grey[700], size: 20),
        title: sidebarExpanded
            ? Text(title,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal))
            : null,
        onTap: () => setState(() => selectedMenu = title),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedMenu) {
      case 'Dashboard':
        return _buildBeautifulDashboard();
      case 'Daftar Buku':
        return _buildBookList();
      case 'Peminjaman':
        return _buildBorrowingList();
      case 'Employee':
        return _buildEmployeeList();
      default:
        return _buildBeautifulDashboard();
    }
  }

  Widget _buildBeautifulDashboard() {
    final adminMenus = [
      {'icon': Icons.attach_money, 'label': 'Pemasukan'},
      {'icon': Icons.swap_horiz, 'label': 'Peminjaman'},
      {'icon': Icons.book, 'label': 'Total Buku'},
      {'icon': Icons.people, 'label': 'Pelanggan'},
      {'icon': Icons.history, 'label': 'Riwayat Buku'},
    ];

    return Container(
      color: Colors.grey[50],
      child: ListView(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutQuad,
            builder: (context, value, child) => Transform.translate(
              offset: Offset(0, 50 * (1 - value)),
              child: Opacity(opacity: value, child: child),
            ),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFFFF800B), Color(0xFFFFC872)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.admin_panel_settings,
                        color: Colors.orange.shade700, size: 38),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Hello, ADMIN',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(height: 6),
                        Text('Perpustakaan Premium School',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 15))
                      ],
                    ),
                  ),
                  Icon(Icons.notifications_active,
                      color: Colors.white, size: 30)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 900),
            curve: Curves.decelerate,
            builder: (context, value, child) =>
                Transform.scale(scale: 0.96 + 0.04 * value, child: child),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 5,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: adminMenus
                    .map((item) => Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          elevation: 3,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {},
                            splashColor:
                                Colors.orangeAccent.withValues(alpha: 0.12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.orange.shade50,
                                    child: Icon(item['icon'] as IconData,
                                        color: Colors.orange, size: 28),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(item['label'] as String,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          letterSpacing: 0.05))
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildAdminStatCard(
                        icon: Icons.attach_money,
                        color: Colors.orange,
                        value: 'Rp 7.250. 000',
                        label: 'Total Pemasukan',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildAdminStatCard(
                        icon: Icons.swap_horiz,
                        color: Colors.blue,
                        value: '$totalBorrowed',
                        label: 'Peminjaman',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildAdminStatCard(
                        icon: Icons.book,
                        color: Colors.green,
                        value: '$totalBooks',
                        label: 'Total Buku',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _buildAdminStatCard(
                        icon: Icons.people,
                        color: Colors.purple,
                        value: '${employees.length}',
                        label: 'Pelanggan',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildAdminStatCard(
                        icon: Icons.history,
                        color: Colors.teal,
                        value: '${borrowings.length}',
                        label: 'Riwayat Buku',
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(child: SizedBox.shrink()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAdminStatCard({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.7, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, anim, child) =>
          Transform.scale(scale: anim, child: child),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(icon, color: color, size: 24)),
            const SizedBox(height: 12),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: color),
                textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _buildBookList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Daftar Buku',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: _showAddBookDialog,
                icon: const Icon(Icons.add),
                label: const Text('Tambah Buku'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text('ID',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Judul Buku',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Penulis',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Stok',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Dipinjam',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Harga',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Aksi',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: books
                  .map((book) => DataRow(cells: [
                        DataCell(Text(book['id'].toString())),
                        DataCell(Text(book['title'])),
                        DataCell(Text(book['author'])),
                        DataCell(Text(book['stock'].toString())),
                        DataCell(Text(book['borrowed'].toString())),
                        DataCell(Text('Rp ${book['price']}')),
                        DataCell(Row(
                          children: [
                            IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showEditBookDialog(book)),
                            IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteBook(book['id'])),
                          ],
                        )),
                      ]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBorrowingList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Data Peminjaman',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text('ID',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Judul Buku',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Peminjam',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Tanggal',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Status',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: borrowings
                  .map((borrow) => DataRow(cells: [
                        DataCell(Text(borrow['id'].toString())),
                        DataCell(Text(borrow['bookTitle'])),
                        DataCell(Text(borrow['borrower'])),
                        DataCell(Text(borrow['date'])),
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: borrow['status'] == 'Dipinjam'
                                ? Colors.yellow[100]
                                : Colors.green[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(borrow['status'],
                              style: TextStyle(
                                  color: borrow['status'] == 'Dipinjam'
                                      ? Colors.yellow[800]
                                      : Colors.green[800],
                                  fontSize: 12)),
                        )),
                      ]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Data Employee',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text('ID',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Nama',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Role',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Email',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Status',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Aksi',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: employees
                  .map((emp) => DataRow(cells: [
                        DataCell(Text(emp['id'].toString())),
                        DataCell(Text(emp['name'])),
                        DataCell(Text(emp['role'])),
                        DataCell(Text(emp['email'])),
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(emp['status'],
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 12)),
                        )),
                        DataCell(IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditEmployeeDialog(emp))),
                      ]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddBookDialog() {
    final titleController = TextEditingController();
    final authorController = TextEditingController();
    final stockController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Buku Baru'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      labelText: 'Judul Buku', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: authorController,
                  decoration: const InputDecoration(
                      labelText: 'Penulis', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: stockController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Stok', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Harga', border: OutlineInputBorder())),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              titleController.dispose();
              authorController.dispose();
              stockController.dispose();
              priceController.dispose();
              Navigator.pop(context);
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  authorController.text.isNotEmpty &&
                  stockController.text.isNotEmpty &&
                  priceController.text.isNotEmpty) {
                setState(() {
                  books.add({
                    'id': books.length + 1,
                    'title': titleController.text,
                    'author': authorController.text,
                    'stock': int.tryParse(stockController.text) ?? 0,
                    'borrowed': 0,
                    'price': int.tryParse(priceController.text) ?? 0,
                  });
                });
                titleController.dispose();
                authorController.dispose();
                stockController.dispose();
                priceController.dispose();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditBookDialog(Map<String, dynamic> book) {
    final titleController = TextEditingController(text: book['title']);
    final authorController = TextEditingController(text: book['author']);
    final stockController =
        TextEditingController(text: book['stock'].toString());
    final priceController =
        TextEditingController(text: book['price'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Buku'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      labelText: 'Judul Buku', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: authorController,
                  decoration: const InputDecoration(
                      labelText: 'Penulis', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: stockController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Stok', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Harga', border: OutlineInputBorder())),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              titleController.dispose();
              authorController.dispose();
              stockController.dispose();
              priceController.dispose();
              Navigator.pop(context);
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                book['title'] = titleController.text;
                book['author'] = authorController.text;
                book['stock'] =
                    int.tryParse(stockController.text) ?? book['stock'];
                book['price'] =
                    int.tryParse(priceController.text) ?? book['price'];
              });
              titleController.dispose();
              authorController.dispose();
              stockController.dispose();
              priceController.dispose();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _deleteBook(int id) {
    setState(() {
      books.removeWhere((book) => book['id'] == id);
    });
  }

  void _showEditEmployeeDialog(Map<String, dynamic> emp) {
    final nameController = TextEditingController(text: emp['name']);
    final roleController = TextEditingController(text: emp['role']);
    final emailController = TextEditingController(text: emp['email']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Karyawan'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: 'Nama', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: roleController,
                  decoration: const InputDecoration(
                      labelText: 'Role', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder())),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              nameController.dispose();
              roleController.dispose();
              emailController.dispose();
              Navigator.pop(context);
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                emp['name'] = nameController.text;
                emp['role'] = roleController.text;
                emp['email'] = emailController.text;
              });
              nameController.dispose();
              roleController.dispose();
              emailController.dispose();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ==================== STUDENT DASHBOARD ====================
class StudentDashboardPage extends StatefulWidget {
  const StudentDashboardPage({Key? key}) : super(key: key);

  @override
  _StudentDashboardPageState createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  String selectedMenu = 'Dashboard';
  bool sidebarExpanded = true;

  List<Map<String, dynamic>> books = [];
  List<Map<String, dynamic>> myBorrowings = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    books = [
      {
        'id': 1,
        'title': 'Pemrograman Web',
        'author': 'John Doe',
        'stock': 15,
        'borrowed': 5,
        'price': 50000
      },
      {
        'id': 2,
        'title': 'Database MySQL',
        'author': 'Jane Smith',
        'stock': 20,
        'borrowed': 8,
        'price': 75000
      },
      {
        'id': 3,
        'title': 'Algoritma Pemrograman',
        'author': 'Bob Wilson',
        'stock': 12,
        'borrowed': 3,
        'price': 60000
      },
    ];
    myBorrowings = [
      {
        'id': 1,
        'bookTitle': 'Pemrograman Web',
        'borrower': 'Siswa A',
        'date': '2026-01-10',
        'status': 'Dipinjam'
      },
    ];
    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: sidebarExpanded ? 250 : 70,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10)
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]!))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (sidebarExpanded)
                        Row(
                          children: const [
                            Icon(Icons.menu_book, color: Colors.blue, size: 32),
                            SizedBox(width: 8),
                            Text('E-Library',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      IconButton(
                          icon:
                              Icon(sidebarExpanded ? Icons.close : Icons.menu),
                          onPressed: () => setState(
                              () => sidebarExpanded = !sidebarExpanded)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (sidebarExpanded)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text('MENU',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[700])),
                        ),
                      _buildMenuItem(Icons.dashboard, 'Dashboard'),
                      _buildMenuItem(Icons.book, 'Katalog Buku'),
                      _buildMenuItem(Icons.calendar_today, 'Peminjaman Saya'),
                      _buildMenuItem(Icons.search, 'Cari Buku'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text('S',
                                  style: TextStyle(color: Colors.white))),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Selamat Datang, Siswa! ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('E-Library - Perpustakaan Premium School',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () =>
                                  setState(() => selectedMenu = 'Cari Buku')),
                          IconButton(
                              icon: const Icon(Icons.logout, color: Colors.red),
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginPage()))),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                        color: Colors.grey[100], child: _buildContent())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    bool isSelected = selectedMenu == title;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(icon,
            color: isSelected ? Colors.white : Colors.grey[700], size: 20),
        title: sidebarExpanded
            ? Text(title,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal))
            : null,
        onTap: () => setState(() => selectedMenu = title),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedMenu) {
      case 'Dashboard':
        return _buildBeautifulStudentDashboard();
      case 'Katalog Buku':
        return _buildBookCatalog();
      case 'Peminjaman Saya':
        return _buildMyBorrowings();
      case 'Cari Buku':
        return _buildSearch();
      default:
        return _buildBeautifulStudentDashboard();
    }
  }

  Widget _buildBeautifulStudentDashboard() {
    final userMenus = [
      {'icon': Icons.request_page, 'label': 'Ajukan Pinjaman'},
      {'icon': Icons.book, 'label': 'Buku'},
      {'icon': Icons.history, 'label': 'Riwayat Pinjaman'},
      {'icon': Icons.chrome_reader_mode, 'label': 'Membaca Buku'},
    ];

    return Container(
      color: Colors.grey[50],
      child: ListView(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutQuad,
            builder: (context, value, child) => Transform.translate(
              offset: Offset(0, 50 * (1 - value)),
              child: Opacity(opacity: value, child: child),
            ),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFFFF800B), Color(0xFFFFC872)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.school,
                        color: Colors.orange.shade700, size: 38),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Hello, Student',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(height: 6),
                        Text('Perpustakaan Premium School',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 15))
                      ],
                    ),
                  ),
                  Icon(Icons.notifications_active,
                      color: Colors.white, size: 30)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 900),
            curve: Curves.decelerate,
            builder: (context, value, child) =>
                Transform.scale(scale: 0.96 + 0.04 * value, child: child),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                children: userMenus
                    .map((item) => Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          elevation: 3,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {},
                            splashColor:
                                Colors.orangeAccent.withValues(alpha: 0.12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.orange.shade50,
                                    child: Icon(item['icon'] as IconData,
                                        color: Colors.orange, size: 28),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(item['label'] as String,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          letterSpacing: 0.05))
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildStudentStatCard(
                    icon: Icons.chrome_reader_mode,
                    color: Colors.blue,
                    value: '${books.length}',
                    label: 'Buku Dibaca',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStudentStatCard(
                    icon: Icons.book,
                    color: Colors.green,
                    value: '${myBorrowings.length}',
                    label: 'Buku Pinjaman',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStudentStatCard(
                    icon: Icons.history,
                    color: Colors.deepOrange,
                    value: '5',
                    label: 'Riwayat Pinjaman',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStudentStatCard({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.7, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, anim, child) =>
          Transform.scale(scale: anim, child: child),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(icon, color: color, size: 24)),
            const SizedBox(height: 12),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 22, color: color),
                textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _buildBookCatalog() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Katalog Buku',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text('ID',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Judul Buku',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Penulis',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Stok',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Harga',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: books
                  .map((book) => DataRow(cells: [
                        DataCell(Text(book['id'].toString())),
                        DataCell(Text(book['title'])),
                        DataCell(Text(book['author'])),
                        DataCell(Text(book['stock'].toString())),
                        DataCell(Text('Rp ${book['price']}')),
                      ]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyBorrowings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Riwayat Peminjaman Saya',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text('ID',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Judul Buku',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Tanggal',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Status',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: myBorrowings
                  .map((borrow) => DataRow(cells: [
                        DataCell(Text(borrow['id'].toString())),
                        DataCell(Text(borrow['bookTitle'])),
                        DataCell(Text(borrow['date'])),
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: borrow['status'] == 'Dipinjam'
                                ? Colors.yellow[100]
                                : Colors.green[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(borrow['status'],
                              style: TextStyle(
                                  color: borrow['status'] == 'Dipinjam'
                                      ? Colors.yellow[800]
                                      : Colors.green[800],
                                  fontSize: 12)),
                        )),
                      ]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Cari Buku',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Ketik judul buku...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text('ID',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Judul Buku',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Penulis',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Stok',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Harga',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: books
                  .map((book) => DataRow(cells: [
                        DataCell(Text(book['id'].toString())),
                        DataCell(Text(book['title'])),
                        DataCell(Text(book['author'])),
                        DataCell(Text(book['stock'].toString())),
                        DataCell(Text('Rp ${book['price']}')),
                      ]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
