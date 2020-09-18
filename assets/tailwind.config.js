const openColor = require('open-color')

module.exports = {
  purge: [
    '../**/*.html.eex',
    '../**/*.html.leex',
    '../**/views/**/*.ex',
    '../**/live/**/*.ex',
    '../js/**/*.js'
  ],
  theme: {
    extend: {
      colors: () => {
        const shadeIndices = [
          '50',
          '100',
          '200',
          '300',
          '400',
          '500',
          '600',
          '700',
          '800',
          '900'
        ]

        return Object.entries(openColor).reduce((colors, [name, shades]) => {
          if (['white', 'black'].includes(name)) {
            colors[name] = {default: shades}
          } else {
            colors[name] = Object.values(shades).reduce((shades, shade, i) => {
              shades[shadeIndices[i]] = shade
              return shades
            }, {})
          }

          return colors
        }, {})
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif']
      }
    }
  },
  variants: {},
  plugins: [require('@tailwindcss/custom-forms')]
}
