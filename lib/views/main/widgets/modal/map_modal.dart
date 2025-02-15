import 'package:flutter/material.dart';
import 'package:highthon_10th/models/visit_model.dart';
import 'package:highthon_10th/views/main/providers/visit_tags_type_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapModal extends StatelessWidget {
  const MapModal(this.visitModel, this.fulllocation, {super.key});

  final VisitModel visitModel;
  final String fulllocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 120, 24, 0),
      decoration: BoxDecoration(),
      child: Column(
        spacing: 24,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Image.network(visitModel.photoUrl),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      visitModel.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Wanted',
                        color: Colors.black,
                      ),
                    ),
                    visitModel.placeType == 'food'
                        ? Icon(
                            VisitTagsType.food.icon,
                            color: VisitTagsType.food.color,
                          )
                        : visitModel.placeType == 'cafe'
                            ? Icon(
                                VisitTagsType.cafe.icon,
                                color: VisitTagsType.cafe.color,
                              )
                            : visitModel.placeType == 'park'
                                ? Icon(
                                    VisitTagsType.park.icon,
                                    color: VisitTagsType.park.color,
                                  )
                                : Icon(
                                    VisitTagsType.etc.icon,
                                    color: VisitTagsType.etc.color,
                                  ),
                  ],
                ),
                Divider(
                  height: 13,
                  thickness: 1,
                  color: Color(0xffe9e9e9),
                ),
                Text(
                  visitModel.description,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Wanted',
                    color: Colors.black,
                  ),
                ),
                Divider(
                  height: 13,
                  thickness: 1,
                  color: Color(0xffe9e9e9),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      fulllocation,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Wanted',
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async =>
                          await launchUrlString(visitModel.directionsLink),
                      child: Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            border: Border.all(color: Color(0xff3b3b3b))),
                        child: Text('길찾기'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.cancel_rounded,
              size: 52,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
