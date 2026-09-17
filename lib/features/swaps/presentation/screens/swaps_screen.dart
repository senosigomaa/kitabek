import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/swaps_bloc.dart';
import '../../data/models/swap_request_model.dart';
import '../widgets/swap_card.dart';

class SwapsScreen extends StatelessWidget {
  const SwapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المقايضات النشطة 🔄', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<SwapsBloc, SwapsState>(
        builder: (context, state) {
          if (state is SwapsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SwapsLoadedState) {
            if (state.requests.isEmpty) {
              return const Center(child: Text('لا توجد مقايضات نشطة حالياً'));
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
              itemCount: state.requests.length,
              itemBuilder: (context, index) {
                final req = state.requests[index];
                return SwapCard(
                  request: req,
                  onAccept: () {
                    context.read<SwapsBloc>().add(
                          UpdateSwapStatusEvent(
                            id: req.id,
                            newStatus: SwapStatus.accepted,
                          ),
                        );
                  },
                  onReject: () {
                    context.read<SwapsBloc>().add(
                          UpdateSwapStatusEvent(
                            id: req.id,
                            newStatus: SwapStatus.rejected,
                          ),
                        );
                  },
                );
              },
            );
          }
          return const Center(child: Text('خطأ في تحميل المعاملات'));
        },
      ),
    );
  }
}
