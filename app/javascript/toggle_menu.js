document.addEventListener("turbo:load", function() {
    const openMenuButton = document.getElementById("open-menu");
    const closeMenuButton = document.getElementById("close-menu");
    const mobileMenu = document.getElementById("mobile-menu");
  
    // Function to open the mobile menu
    openMenuButton.addEventListener("click", function() {
      mobileMenu.classList.remove("hidden");
    });
  
    // Function to close the mobile menu
    closeMenuButton.addEventListener("click", function() {
      mobileMenu.classList.add("hidden");
    });
  
    // Optional: Close the menu when clicking outside of it
    mobileMenu.addEventListener("click", function(event) {
      if (event.target === mobileMenu) {
        mobileMenu.classList.add("hidden");
      }
    });
  });