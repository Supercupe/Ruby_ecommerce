import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

// Connects to data-controller="stripe-checkout"
export default class extends Controller {
  static values = { url: String}
    async connect() {
      const publicKey = document.head.querySelector("meta[name='stripe-pk']").content;
      const stripe = Stripe (publicKey)
      const fetchClientSecret = async ()=>{
        const response = await post(this.urlValue)
        const { clientSecret } = await response.json;
        return clientSecret;
    };

    // Fetch the session ID from the server
    const checkout = await stripe.initEmbeddedCheckout({
      fetchClientSecret,
    });

    checkout.mount(this.element);
  }
}
