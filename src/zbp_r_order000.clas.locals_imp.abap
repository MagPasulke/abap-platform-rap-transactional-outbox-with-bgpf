class lsc_zr_order000 definition inheriting from cl_abap_behavior_saver.

  protected section.

    methods save_modified redefinition.

endclass.

class lsc_zr_order000 implementation.

  method save_modified.

    if create-order000 is not initial.
      loop at create-order000 assigning field-symbol(<ls_order>).

        try.
            data(lo_factory) = cl_bgmc_process_factory=>get_default( ).
            data(lo_process) = lo_factory->create( ).

            lo_process->set_name( 'Request shipping' )->set_operation(
              zcl_rap_bgpf_request_shipping=>create_instance(
                is_order = corresponding #( <ls_order> )
              )
            ).

            lo_process->save_for_execution( ).

          catch cx_bgmc into data(lx_previous).
            "handle exception
        endtry.

      endloop.
    endif.

  endmethod.

endclass.

class lhc_zr_order000 definition inheriting from cl_abap_behavior_handler.
  private section.
    methods:
      get_global_authorizations for global authorization
        importing
        request requested_authorizations for Order000
        result result.
endclass.

class lhc_zr_order000 implementation.
  method get_global_authorizations.
  endmethod.

endclass.
