# Phoenix Template

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This repository contains the template I use for deploying Phoenix
applications.

## Changes

This template is optimized for deploying to Heroku. It contains the basic
application generated with these `mix phx.new` flags:

```
--live --app=app --module=App --database=postgresql --binary-id
```

For the most part, it's a standard Phoenix application with a few small
tweaks and extra modules:

### Elixir/Phoenix

- [`App.Context`](/lib/app/context.ex) helps set up application context modules.
- [`App.Schema`](/lib/app/schema.ex) helps set up application schemata with common options.
- [`AppWeb`](lib/app_web.ex#L78) contains a `:plug` macro for building plugs.

### Assets

- Styling is provided by [Tailwind](https://tailwindcss.com) and [Open
  Color](https://yeun.github.io/open-color/). Tailwind utility class purging is
  preconfigured.
- [postcss-nested](https://npm.im/postcss-nested) is provided for nested CSS rules.

### Deployment

Deployment can be done via the "Deploy to Heroku" button above (although you
[must provide a `template` query parameter for private
repositories](https://devcenter.heroku.com/articles/heroku-button#private-github-repos)).

The buildpacks are configured in
[`elixir_buildpack.config`](/elixir_buildpack.config) and
[`phoenix_static_buildpack.config`](/phoenix_static_buildpack.config). If you
are manually creating an application on Heroku, see [app.json](/app.json) for
required environment variables and add-ons.

## Development

To start your Phoenix server:

- Setup the project with `mix setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
