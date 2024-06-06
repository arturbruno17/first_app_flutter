import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String description;
  final GestureTapCallback tapCallback;

  const TodoCard({
    super.key,
    required this.title,
    required this.description,
    required this.tapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
              color: Colors.black,
              width: .5,
              strokeAlign: BorderSide.strokeAlignInside)),
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 0,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          onTap: tapCallback,
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
