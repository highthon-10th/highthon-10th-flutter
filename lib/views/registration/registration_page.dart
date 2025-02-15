import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/views/registration/providers/category_provider.dart';
import 'package:highthon_10th/views/registration/providers/image_picker_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:highthon_10th/views/registration/providers/text_controller_provider.dart';
import 'package:highthon_10th/views/registration/widgets/textfield_item.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitleText('아이유(IU)'),
              const SizedBox(height: 40),
              buildCategorySelection(ref),
              const SizedBox(height: 32),
              buildTextFieldSection(
                  '장소 이름', ref.watch(name), '지도상의 이름을 입력해주세요'),
              const SizedBox(height: 32),
              buildTextFieldSection('주소', ref.watch(address), '정확한 주소를 입력해주세요'),
              const SizedBox(height: 32),
              buildTextFieldSection(
                  '소개', ref.watch(description), '아티스트와 장소에 관한 이야기를 적어 주세요!'),
              const SizedBox(height: 32),
              buildPlaceCategorySelection(ref),
              const SizedBox(height: 32),
              buildPhotoUploadSection(ref),
              const SizedBox(height: 32),
              buildRegisterButton(ref), // ✅ 버튼 추가
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRegisterButton(WidgetRef ref) {
    final isFormValid = _isFormValid(ref);

    return GestureDetector(
      onTap: isFormValid
          ? () {
              // 등록하기 버튼 클릭 시 실행할 동작 추가
              print('등록 버튼 클릭됨!');
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 143, vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isFormValid ? const Color(0xffB051FB) : Color(0xffd0d0d0),
          // ✅ 활성화 여부에 따라 색 변경
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '등록하기',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Wanted',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// ✅ 모든 필수 입력이 완료되었는지 확인하는 함수
  bool _isFormValid(WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final placeName = ref.watch(name).text.trim();
    final placeAddress = ref.watch(address).text.trim();
    final placeDescription = ref.watch(description).text.trim();
    final selectedPlaceCategory = ref.watch(selectedPlaceCategoryProvider);
    final imageFile = ref.watch(selectedImageProvider);

    return selectedCategory != null &&
        placeName.isNotEmpty &&
        placeAddress.isNotEmpty &&
        placeDescription.isNotEmpty &&
        selectedPlaceCategory != null &&
        imageFile != null;
  }
}

Widget buildTitleText(String name) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '새로운 장소 등록하기',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Wanted',
          color: Colors.black,
        ),
      ),
      Row(
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Wanted',
              color: Color(0xffB051FB),
            ),
          ),
          const Text(
            '와 관련된 장소 또는 이벤트를 등록해주세요!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Wanted',
              color: Colors.black,
            ),
          ),
        ],
      )
    ],
  );
}

Widget buildCategorySelection(WidgetRef ref) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('등록 구분'),
      const SizedBox(height: 12),
      Row(
        children: [
          buildSelectableContainer(ref, '장소', selectedCategoryProvider),
          const SizedBox(width: 8),
          buildSelectableContainer(ref, '이벤트', selectedCategoryProvider),
        ],
      ),
    ],
  );
}

Widget buildTextFieldSection(
    String title, TextEditingController controller, String hintText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(title),
      const SizedBox(height: 12),
      TextFieldComponent(controller: controller, hintText: hintText),
    ],
  );
}

Widget buildPlaceCategorySelection(WidgetRef ref) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('카테고리'),
      const SizedBox(height: 12),
      Row(
        children: [
          buildSelectableContainer(ref, '식당', selectedPlaceCategoryProvider),
          const SizedBox(width: 8),
          buildSelectableContainer(ref, '공원', selectedPlaceCategoryProvider),
          const SizedBox(width: 8),
          buildSelectableContainer(ref, '카페', selectedPlaceCategoryProvider),
          const SizedBox(width: 8),
          buildSelectableContainer(ref, '기타', selectedPlaceCategoryProvider),
        ],
      ),
    ],
  );
}

Widget buildPhotoUploadSection(WidgetRef ref) {
  final imageFile = ref.watch(selectedImageProvider);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('사진 업로드'),
      const Text(
        '장소일 경우 아티스트가 포함된 이미지를 업로드 해주세요.',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          fontFamily: 'Wanted',
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 12),
      GestureDetector(
        onTap: () async {
          final picker = ImagePicker();
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            ref.read(selectedImageProvider.notifier).state =
                File(pickedFile.path);
          }
        },
        child: imageFile == null
            ? Container(
                width: double.infinity,
                height: 150,
                padding:
                    const EdgeInsets.symmetric(horizontal: 72, vertical: 42),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Image.asset('assets/image/add_image.png'))
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(imageFile,
                    fit: BoxFit.cover, width: double.infinity, height: 150),
              ),
      ),
    ],
  );
}

Widget buildSectionTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'Wanted',
      color: Colors.black,
    ),
  );
}

Widget buildSelectableContainer(
    WidgetRef ref, String text, StateProvider<String?> provider) {
  final selected = ref.watch(provider);
  final isSelected = selected == text;

  return GestureDetector(
    onTap: () {
      ref.read(provider.notifier).state = text;
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xffB051FB) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
