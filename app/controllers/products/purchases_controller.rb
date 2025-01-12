module Products
    class PurchasesController < ApplicationController
        before_action :set_product
        def new; end
        def success; end
        def create
            custom_field = params[:custom_field]
            session = Stripe::Checkout::Session.create({
                ui_mode: "embedded",
                line_items: [{
                    price_data: {
                        currency:"CZK",
                        unit_amount: (@product.price*100).to_i,
                        product_data: {
                            name: @product.name,
                        },
                    metadata: {
                        custom_field: custom_field, # Attach the custom field to the session metadata
                      },
                    },
                    quantity: 1,
                }],
                mode:"payment",
                return_url: success_product_purchases_url(@product),
                custom_fields: [
                    {
                      key: 'engraving',
                      label: {
                        type: 'custom',
                        custom: 'Personalized engraving',
                      },
                      type: 'text',
                      text: {
                        default_value: 'Stella',
                      },
                    },
                    {
                      key: 'size',
                      label: {
                        type: 'custom',
                        custom: 'Size',
                      },
                      type: 'text',
                      text: {
                        default_value: 'small',
                      },
                    },
                  ],
                             
            })
            render json: { clientSecret: session.client_secret }
        end

        private
        def set_product
            @product = Product.find(params[:product_id])
        end
    end
end
