import 'package:flutter/material.dart';

void main() => runApp(const PluggyGoApp());

class PluggyGoApp extends StatelessWidget {
  const PluggyGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF10231F);
    const green = Color(0xFF18A879);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PluggyGo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: green, brightness: Brightness.light),
        scaffoldBackgroundColor: const Color(0xFFF5F8F6),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class Station {
  final String name, address, power, distance, status;
  final double price;
  const Station(this.name, this.address, this.power, this.distance, this.price, this.status);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  String filter = 'All';
  final stations = const [
    Station('ChargePoint Hub', 'Wright Town, Jabalpur', '60 kW · CCS2', '1.2 km', 18, 'Available'),
    Station('GreenVolt Station', 'Napier Town, Jabalpur', '30 kW · CCS2', '2.8 km', 16, 'Available'),
    Station('CityCharge Point', 'Vijay Nagar, Jabalpur', '7.4 kW · Type 2', '4.1 km', 14, 'Busy'),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = stations.where((s) => filter == 'All' || s.status == filter).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F8F6),
        title: const Row(children: [
          Icon(Icons.bolt_rounded, color: Color(0xFF18A879), size: 30),
          SizedBox(width: 7),
          Text('PluggyGo', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.6)),
        ]),
        actions: [
          IconButton(onPressed: () => _message('Notifications will be available after backend integration.'), icon: const Icon(Icons.notifications_none_rounded)),
          const Padding(padding: EdgeInsets.only(right: 16), child: CircleAvatar(backgroundColor: Color(0xFFD9EEE6), child: Icon(Icons.person_outline, color: Color(0xFF167A5A)))),
        ],
      ),
      body: IndexedStack(index: tab, children: [
        _home(visible),
        _simplePage('Explore stations', 'Search charging stations and filter by connector, speed and availability.'),
        _simplePage('My bookings', 'Your upcoming and past charging bookings will appear here.'),
        _simplePage('Profile', 'Manage your account, vehicles and payment preferences.'),
      ]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map_outlined), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _home(List<Station> visible) => ListView(
    padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF123C30), Color(0xFF147A58)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('POWER YOUR JOURNEY', style: TextStyle(color: Color(0xFFB9E9D5), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.4)),
          const SizedBox(height: 10),
          const Text('Find a charger.\nKeep moving.', style: TextStyle(color: Colors.white, fontSize: 27, height: 1.12, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF126347)),
            onPressed: () => setState(() => tab = 1),
            icon: const Icon(Icons.near_me_outlined), label: const Text('Explore nearby stations'),
          ),
        ]),
      ),
      const SizedBox(height: 20),
      const Text('Quick overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      Row(children: [
        _metric('Stations', '12', Icons.ev_station),
        const SizedBox(width: 10),
        _metric('Available', '08', Icons.bolt),
        const SizedBox(width: 10),
        _metric('Your vehicle', 'EV', Icons.directions_car),
      ]),
      const SizedBox(height: 22),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Nearby charging stations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        TextButton(onPressed: () => setState(() => tab = 1), child: const Text('View all')),
      ]),
      Wrap(spacing: 8, children: ['All', 'Available', 'Busy'].map((f) => ChoiceChip(label: Text(f), selected: filter == f, onSelected: (_) => setState(() => filter = f))).toList()),
      const SizedBox(height: 8),
      ...visible.map(_stationCard),
      const SizedBox(height: 12),
      const Text('Demo data only · Live station availability requires partner API integration.', style: TextStyle(color: Colors.black54, fontSize: 11)),
    ],
  );

  Widget _metric(String label, String value, IconData icon) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFE7EEEA))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: const Color(0xFF16835F), size: 20),
      const SizedBox(height: 8),
      Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
    ]),
  ));

  Widget _stationCard(Station s) => Container(
    margin: const EdgeInsets.only(bottom: 11),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE6EDE9))),
    child: Column(children: [
      Row(children: [
        Container(width: 46, height: 46, decoration: BoxDecoration(color: const Color(0xFFE7F5EF), borderRadius: BorderRadius.circular(13)), child: const Icon(Icons.ev_station, color: Color(0xFF16835F), size: 25)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(s.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          Text(s.address, style: const TextStyle(color: Colors.black54, fontSize: 12)),
        ])),
        Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: s.status == 'Available' ? const Color(0xFFE4F6EC) : const Color(0xFFFFF1DC), borderRadius: BorderRadius.circular(20)), child: Text(s.status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: s.status == 'Available' ? const Color(0xFF167A4D) : const Color(0xFF9A6417)))),
      ]),
      const Divider(height: 22),
      Row(children: [
        _detail(Icons.bolt, s.power), _detail(Icons.location_on_outlined, s.distance),
        const Spacer(), Text('₹${s.price.toStringAsFixed(0)}/kWh', style: const TextStyle(fontWeight: FontWeight.w900)),
      ]),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => _message('Station details and booking will be enabled with live partner integration.'), child: const Text('View station'))),
    ]),
  );

  Widget _detail(IconData icon, String text) => Padding(padding: const EdgeInsets.only(right: 13), child: Row(children: [Icon(icon, size: 14, color: Colors.black54), const SizedBox(width: 4), Text(text, style: const TextStyle(fontSize: 11, color: Colors.black87))]));

  Widget _simplePage(String title, String subtitle) => Center(child: Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Icon(Icons.electric_car_outlined, size: 58, color: Color(0xFF18A879)),
    const SizedBox(height: 14), Text(title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
    const SizedBox(height: 8), Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
    const SizedBox(height: 18), const Chip(label: Text('Starter version')),
  ])));

  void _message(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
