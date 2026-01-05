import 'package:dio_contact/model/contact_model.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
	final ContactResponse ctRes;
	final VoidCallback onDismissed;

	const ContactCard({required this.ctRes, required this.onDismissed, Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Card(
			color: Colors.green[50],
			child: ListTile(
				title: Text(ctRes.message),
				subtitle: Text('Status: ${ctRes.status}'),
				trailing: IconButton(
					icon: const Icon(Icons.close),
					onPressed: onDismissed,
				),
			),
		);
	}
}
