import 'package:flutter/material.dart';

void main() => runApp(FooterWidget());

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/page-1/images/whatsappimage2023-05-18at1912-1-7j4.png',
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'KuyTopUp',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'KUY TOP UP adalah tempat Top Up Games yang aman, murah, dan terpercaya. Proses cepat 1-3 detik, buka 24/7, dan memiliki payment terlengkap. Jika ada kendala silahkan hubungi Customer Service dengan menekan tombol di pojok kanan atas.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Text(
                '© Copyright KuyTopUp. All Rights Reserved\n'
                'Designed by Kelompok 3',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}