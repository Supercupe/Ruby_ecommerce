import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {
  static values = { url: String }

  async connect() {
    console.log("Stripe controller connected");
    const publicKey = document.head.querySelector("meta[name='stripe-pk']").content;
    const stripe = Stripe(publicKey);

    const fetchClientSecret = async () => {
      const response = await post(this.urlValue);
      const { clientSecret } = await response.json();
      console.log("Fetched clientSecret:", clientSecret);
      return clientSecret;
    };

    const checkout = await stripe.initEmbeddedCheckout({
      fetchClientSecret,
    });

    checkout.mount(this.element);
    console.log("Embedded checkout mounted");
  }
}
