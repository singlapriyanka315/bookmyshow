part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {
}


class OrderLoading extends OrderState {
}

class  OrderLoaded extends OrderState {
  var orders;
   OrderLoaded(this.orders);
  @override
  // TODO: implement props
  List<Object?> get props => [orders];
}

class  OrderError extends OrderState {
  var error;
 OrderError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}