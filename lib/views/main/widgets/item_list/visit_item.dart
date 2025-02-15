import 'package:flutter/material.dart';
import 'package:highthon_10th/models/visit_model.dart';
import 'package:highthon_10th/views/main/providers/visit_tags_type_provider.dart';
import 'package:highthon_10th/views/main/widgets/modal/visit_dialog_modal.dart';

class VisitItem extends StatelessWidget {
  const VisitItem({
    super.key,
    required this.visit,
    required this.locate,
    required this.fullLocate,
  });

  final VisitModel visit;
  final String locate;
  final String fullLocate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return VisitDialogModal(visit: visit);
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF7A618D).withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 236,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(visit.photoUrl), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              visit.name,
                              style: TextStyle(
                                color: Color(0xFF3B3B3B),
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Wanted',
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              VisitTagsType.values
                                  .firstWhere((e) => e.name == visit.placeType)
                                  .text,
                              style: TextStyle(
                                color: VisitTagsType.values
                                    .firstWhere(
                                        (e) => e.name == visit.placeType)
                                    .color,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Wanted',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          visit.description,
                          style: TextStyle(
                            color: Color(0xFF6E6E6E),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Wanted',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
