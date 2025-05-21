// import 'package:flutter/material.dart';

// class InputText extends StatelessWidget {
//   const InputText({
//     super.key,
//     required this.hint,
//     required this.controller,
//     required this.obsecured,
//     required this.lable,
//     this.icon,
//     this.sufixe,
//     this.onTap,
//   });
//   final String hint;
//   final TextEditingController controller;
//   final bool? obsecured;
//   final String lable;
//   final IconData? icon;
//   final IconData? sufixe;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: SizedBox(
//         height: 50,
//         child: TextFormField(
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Field Is Required';
//             }
//             return null;
//           },
//           controller: controller,
//           obscureText: obsecured!,
//           decoration: InputDecoration(
//             suffixIcon: InkWell(
//               onTap: onTap,
//               child: Icon(sufixe, color: Colors.blue),
//             ),
//             prefix: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Icon(icon, color: Colors.blue),
//               ),
//             ),
//             hintText: hint,
//             label: Text(lable),
//             border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required this.hint,
    required this.controller,
    required this.lable,
    this.obsecured = false, // default value
    this.icon,
    this.sufixe,
    this.onTap,
  });

  final String hint;
  final TextEditingController controller;
  final String lable;
  final bool obsecured;
  final IconData? icon;
  final IconData? sufixe;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$lable الزامی است';
            }
            return null;
          },
          controller: controller,
          obscureText: obsecured,
          decoration: InputDecoration(
            suffixIcon:
                sufixe != null
                    ? InkWell(
                      onTap: onTap,
                      child: Icon(sufixe, color: Colors.blue),
                    )
                    : null,
            prefixIcon:
                icon != null
                    ? Padding(
                      padding: const EdgeInsets.only(left: 15, top: 12),
                      child: Icon(icon, color: Colors.blue),
                    )
                    : null,
            hintText: hint,
            labelText: lable,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}
