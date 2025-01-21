module Products
    class PurchasesController < ApplicationController
        before_action :set_product
        def new; end
        def success; end
        def create
          custom_field = params[:custom_field]
          custom_field_1 = params[:custom_field_1]
        
          session = Stripe::Checkout::Session.create({
            ui_mode: "embedded",
            line_items: [{
              price_data: {
                currency: "eur",
                unit_amount: (@product.price * 100).to_i,
                product_data: {
                  name: @product.name,
                  description: @product.description.to_plain_text,
                },
              },
              quantity: 1,
            }],
            mode: "payment",
            return_url: success_product_purchases_url(@product),
            metadata: {
              custom_field: custom_field,
              custom_field_1: custom_field_1,
            }, 
          })
        
          render json: { clientSecret: session.client_secret }
        end
        

        private
        def set_product
            @product = Product.find(params[:product_id])
        end
    end
end
