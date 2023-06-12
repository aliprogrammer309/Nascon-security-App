import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nascon_security_app/core/form_submission_status.dart';
import 'package:nascon_security_app/features/home/food%20details/bloc/food_details_bloc.dart';
import 'package:nascon_security_app/features/home/food%20details/bloc/food_details_event.dart';
import 'package:nascon_security_app/features/home/food%20details/bloc/food_details_state.dart';

class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage({Key? key}) : super(key: key);

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<FoodDetailsBloc>().add(FetchFoodDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Details'),
      ),
      body: BlocBuilder<FoodDetailsBloc, FoodDetailsState>(
        builder: (context, state) {
          if (state is FoodDetailsStateImp) {
            return state.formState is LoadingFormSubmissionState
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : state.events == null
                ? Center(
              child: Text(
                'No details found',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            )
                : ListView(
              padding:
              const EdgeInsets.only(top: 30, left: 20, right: 20),
              children: [
                Text('Name: ${state.events!.name}'),
                const SizedBox(height: 20),
                Text('Remaining Food Coupons: ${state.events!.food_count}'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: state.events!.food_count > 0? Colors.greenAccent : Colors.redAccent,
                  ),
                  child: Text(state.events!.food_count > 0? 'Food ALLOWED' : 'Food NOT Allowed'),
                ),

              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
