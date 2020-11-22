module.exports = {
  "parser": "@babel/eslint-parser",
  "env": {
    "browser": true,
    "node": true
  },
  "plugins": [
    "coffee",
    "import"
  ],
  "settings": {
    "import/resolver": [
      "babel-module"
    ]
  },
  "globals": {
    "define": true,
    "$": true,
  },
  "rules": {
    "no-unused-vars": [
      "warn",
      {
        "argsIgnorePattern": "^_"
      }
    ],
    "import/no-unresolved": [
      2,
      {
        "ignore": [
          "\\.scss$"
        ]
      }
    ],
    "no-console": process.env.NODE_ENV === 'development' ? 0 : 2
  },
  "overrides": [
    {
      "files": ["**/*.coffee"],
      "parser": "eslint-plugin-coffee",
      "plugins": ["coffee"],
      "extends": [
        "plugin:coffee/eslint-recommended"
      ],
      "rules": {
        "coffee/no-unused-vars": [
          "warn",
          {
            "argsIgnorePattern": "^_"
          }
        ],
      }
    }
  ]
}
