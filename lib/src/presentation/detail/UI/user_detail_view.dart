import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisteps/src/di.dart';
import 'package:tisteps/src/common/extension.dart';
import 'package:tisteps/src/data/models/user_list.dart';
import 'package:tisteps/src/presentation/detail/bloc/bloc.dart';
import 'package:tisteps/src/presentation/detail/bloc/event.dart';

import '../bloc/state.dart';

class DetailsView extends StatefulWidget {
  final User user;
  const DetailsView({super.key, required this.user});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  void initState() {
    locator<UserDetailBloc>().add(LoadUser(widget.user.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context)),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 350,
                child: CachedNetworkImage(
                  imageUrl: widget.user.avatar!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              )
            ],
          ),
          Positioned.fill(child:
              BlocBuilder<UserDetailBloc, UserState>(builder: (context, state) {
            if (state is UserInitialLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              Color colorCode = (state.user.data?.color ?? "").toColor();

              return Column(
                children: [
                  300.h,
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: colorCode,
                            blurRadius: 20.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: ListView(
                      children: [
                        Text(
                          state.user.data?.name ?? "",
                        ).withStyle(const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700)),
                        10.h,
                        Text(
                          "Year - ${state.user.data?.year ?? 0}",
                        ).withStyle(const TextStyle(
                          fontSize: 17,
                        )),
                        10.h,
                        Text(
                          "Pantone - ${state.user.data?.pantoneValue ?? ""}",
                        ).withStyle(const TextStyle(
                          fontSize: 17,
                        )),
                        10.h,
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: colorCode,
                              radius: 10,
                            ),
                          ],
                        )
                      ],
                    ).paddingSymmetric(horizontal: 26),
                  ))
                ],
              );
            } else {
              return const Center(child: Text('Unknown state'));
            }
          }))
        ],
      ),
    );
  }
}
