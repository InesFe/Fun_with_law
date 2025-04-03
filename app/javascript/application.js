// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import confetti from 'canvas-confetti'

function launchConfetti() {
    confetti({
      particleCount: 300,  // Increase the number of particles
      spread: 120,         // Increase spread for wider dispersion
      angle: 90,           // Adjust angle for more centered bursts
      startVelocity: 40,   // Adjust velocity for slower or faster movement
      origin: { x: 0.5, y: 0.6 }
    });
  }

  document.addEventListener("DOMContentLoaded", function() {
    // Check if you are on the correct page by inspecting DOM elements or page-specific classes
    if (document.querySelector("#confetti-container")) {
      launchConfetti();
    }
  });

  document.addEventListener("turbo:load", function() {
    if (document.querySelector("#confetti-container")) {
      launchConfetti();
    }
  });
