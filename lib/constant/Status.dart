class OrderStatusCode {
  static const paymentsettled = "PaymentSettled"; // new & process
  static const shipped = "Shipped"; //deliver
  static const delivered = "Delivered"; //complete
  static const cancelled = "Cancelled"; // cancel
  static const all = "all"; // all
}

class HistoryType {
  static const orderCreated = 'ORDER_CREATED';
  static const paymentTransition = 'ORDER_PAYMENT_TRANSITION';
  static const stateTransition = 'ORDER_STATE_TRANSITION';
  static const fulfillTransition = 'ORDER_FULFILLMENT_TRANSITION';
  static const orderFulfill = 'ORDER_FULFILLMENT';
  static const orderNote = 'ORDER_NOTE';
  static const orderCancel = 'ORDER_CANCELLATION';
  static const coupon = 'ORDER_COUPON_APPLIED';
}
