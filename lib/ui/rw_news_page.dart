import 'package:flutter/material.dart';

class RwNewsPage extends StatelessWidget {
  const RwNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle,
              color: Colors.green,
              size: 18,
            ),
            Text(
              'RW NEWS',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Image.network(
                    "https://i1-kinhdoanh.vnecdn.net/2024/10/13/2022-05-23t134115z-886798033-r-8448-3570-1728753591.jpg?w=380&h=228&q=100&dpr=1&fit=crop&s=42WEVsfNp72cj23VP02nEw",
                  ),
                  title: const Text('Headline of the first news article'),
                  subtitle: const Text('Short summary of the article'),
                  isThreeLine: true,
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}