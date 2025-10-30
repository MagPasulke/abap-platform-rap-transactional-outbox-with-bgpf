class zcl_rap_bgpf_request_shipping definition
  public
  final
  create private .

  public section.

    class-methods create_instance
      importing
        is_order           type zr_order000
      returning
        value(ro_instance) type ref to if_bgmc_op_single.

    interfaces if_bgmc_op_single.

  protected section.
  private section.

    methods constructor
      importing
        is_order type zr_order000.

    data ms_order type zr_order000.

endclass.

class zcl_rap_bgpf_request_shipping implementation.

  method if_bgmc_op_single~execute.
    assert 1 = 2.
    "implement outbound call or system local processing
    modify entity zr_shippingrequest
      create
        set fields auto fill cid
          with value #(
            ( %data = value #(
              OrderReference = ms_order-uuid
              ShippingStatus = 'Ordered'
            )
            )
          )
      mapped data(mapped)
      failed data(failed)
      reported data(reported).

  endmethod.


  method create_instance.
    return new zcl_rap_bgpf_request_shipping( is_order ).
  endmethod.

  method constructor.
    ms_order = is_order.
  endmethod.
endclass.
