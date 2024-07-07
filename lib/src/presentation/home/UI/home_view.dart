import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisteps/src/presentation/home/UI/widgets/user_tile.dart';

import '../../../di.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    locator<UsersBloc>().add(LoadUserList());

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      locator<UsersBloc>().add(LoadUserList());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TISTEPS TASK"),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersInitialLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersInitialError) {
            return Center(child: Text(state.message));
          } else if (state is UsersLoaded) {
            final users = state.users.data;
            return ListView.builder(
              controller: _scrollController,
              itemCount: users?.length ??
                  0 + 1, // Add one more for the loading indicator or "No more data" message
              padding: const EdgeInsets.all(18),
              itemBuilder: (BuildContext context, int index) {
                if (index == users!.length) {
                  // Last item in the list
                  if (state.isLoadingMore) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!state.hasMoreData) {
                    return const Center(child: Text('No more data'));
                  } else {
                    return Container(); // Empty container if no loading or no more data
                  }
                }
                final user = users[index];
                return UserTile(user: user);
              },
            );
          } else if (state is UsersEmpty) {
            return const Center(child: Text('No Users found'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
