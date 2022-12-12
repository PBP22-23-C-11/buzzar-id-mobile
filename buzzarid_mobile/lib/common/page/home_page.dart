import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image.asset('assets/images/LOGO3.png'),
              ),
              Text("Buzzar-id adalah sebuah wadah bagi para pemilik UMKM dan pelanggan untuk berinteraksi dan mengenal karya wirausaha. Proyek ini dibuat untuk memenuhi Proyek Tengah Semester Mata Kuliah Pemrograman Berbasis Plaform oleh Fakultas Ilmu Komputer Universitas Indonesia pada Tahun Ajaran 2022/2023."),
            ],
          ),
        ),
        
      ),
    );
  }
}
