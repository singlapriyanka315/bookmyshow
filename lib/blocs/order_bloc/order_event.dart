part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable{
  const OrderEvent();
  @override
  List<Object> get props => [];

}

class FetchOrder extends OrderEvent{
  FetchOrder();
  @override
  List<Object> get props => [];

}


