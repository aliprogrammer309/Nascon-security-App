import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nascon_security_app/core/form_submission_status.dart';
import 'package:nascon_security_app/features/home/user%20details/bloc/user_details_bloc.dart';
import 'package:nascon_security_app/features/home/user%20details/bloc/user_details_event.dart';
import 'package:nascon_security_app/features/home/user%20details/bloc/user_details_state.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserDetailsBloc>().add(FetchUserDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
          if (state is UserDetailsStateImp) {
            return state.formState is LoadingFormSubmissionState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.events == null || state.events!.isEmpty
                    ? Center(
                        child: Text(
                          'No events found',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      )
                    : ListView.builder(
                        padding:
                            const EdgeInsets.only(top: 30, left: 20, right: 20),
                        itemCount: state.events!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 2,
                                  color:
                                      state.events![index].status == 'Pending'
                                          ? Colors.red
                                          : Colors.green,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Name: ${(state).events![index].name}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    'Phone number: ${(state).events![index].ph}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    'Email: ${(state).events![index].email}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    'Cnic: ${(state).events![index].cnic}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    'Event Name: ${(state).events![index].eventName}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    'Fee: ${(state).events![index].fee}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    'Payment Status: ${(state).events![index].status}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
