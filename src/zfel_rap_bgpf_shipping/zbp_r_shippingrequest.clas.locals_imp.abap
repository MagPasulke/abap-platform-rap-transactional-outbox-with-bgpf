CLASS lhc_zr_shippingrequest DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ShippingRequest
        RESULT result,
      determineEstDeliveryDate FOR DETERMINE ON SAVE
        IMPORTING keys FOR ShippingRequest~determineEstDeliveryDate.
ENDCLASS.

CLASS lhc_zr_shippingrequest IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD determineEstDeliveryDate.

    READ ENTITIES OF zr_shippingrequest IN LOCAL MODE
      ENTITY ShippingRequest
        FIELDS ( EstimatedDeliveryDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    LOOP AT entities INTO DATA(entity).
      DATA(lv_estimated_delivery_date) = cl_abap_context_info=>get_system_date( ) + 14.
      MODIFY ENTITIES OF zr_shippingrequest IN LOCAL MODE
        ENTITY ShippingRequest
          UPDATE FIELDS ( EstimatedDeliveryDate )
          WITH VALUE #( (
            %tky                  = entity-%tky
            EstimatedDeliveryDate = lv_estimated_delivery_date
         ) ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
