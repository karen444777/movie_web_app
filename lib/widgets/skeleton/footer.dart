import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '© 2024 Movies González7. All rights reserved.',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.facebook,
                  color: Colors.grey[400],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.link,
                ),
                color: Colors.grey[400],
                tooltip: 'Twitter',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.image,
                ),
                color: Colors.grey[400],
                tooltip: 'Instagram',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'About Us',
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Terms of Service',
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
