import 'package:flutter/material.dart';

class NewContactTile extends StatelessWidget {
  final String btnName;
  final IconData icon;
  final VoidCallback onTap;
  const NewContactTile({super.key, required this.btnName, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              child: Icon(icon, size: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(width: 20,),
            Text(btnName,style: Theme.of(context).textTheme.bodyLarge,)
          ],
        ),
      ),
    );
  }
}
