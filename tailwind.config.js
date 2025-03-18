// tailwind.config.js
module.exports = {
    content: [
      './app/views/**/*.{html,erb}',
      './app/helpers/**/*.rb',
      './app/javascript/**/*.js',
    ],

  theme: {
    extend: {
      colors: {
        surfgreen: '#55DFB8', // custom colors here
      },
    },
  },
  plugins: [],
}

