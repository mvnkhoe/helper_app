import 'package:flutter/material.dart';

class BuildTile extends StatelessWidget {
  const BuildTile({
    super.key,
    required this.context,
    required this.title,
    required this.icon,
    required this.route,
  });

  final BuildContext context;
  final String title;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.indigo),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width > 600 ? 18 : 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
