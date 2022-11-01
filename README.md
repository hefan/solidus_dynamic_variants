# Solidus Dynamic Variants

[![CircleCI](https://circleci.com/gh/hefan/solidus_dynamic_variants.svg?style=shield)](https://circleci.com/gh/hefan/solidus_dynamic_variants)
[![codecov](https://codecov.io/gh/hefan/solidus_dynamic_variants/branch/master/graph/badge.svg)](https://codecov.io/gh/hefan/solidus_dynamic_variants)

This gem creates variants in the solidus shop frontend on the fly when the cart is populated.
It is meant to be useful for products with many, many options (like Options for lenses), when dynamic variant creation is a better alternative than creating multimillion variant entries for each possible option combination. The Option Values can alter prices as well.

#### 1. Backend Products: Adds a "Dynamic Variants" checkbox to products which makes the variant creation for the product dynamic.

![Backend Products](https://hefan.github.io/images/be_products_2.png)


#### 2. Backend Options: Adds a "Surcharge" field to option values which contains optional surcharges for specific options.

![Backend Options](https://hefan.github.io/images/be_options_2.png)


#### 3. Frontend Product Detail Screen: Renders Select Boxes for each Option instead of Radio Buttons for each Variant

![Frontend Products](https://hefan.github.io/images/fe_products_2.png)


The process of dynamic variant creation in the frontend works like this:
- Shows all available options as dropdowns in product screen (see above).
- When product is put in cart, the correct variant is created if it doesn't exist yet.
- The variant will have the price of the product plus the surcharges of its selected option values
- Existence of a products variant is checked by options and price (if the price is altered a new variant will be created).


Installation
------------

Add solidus_dynamic_variants to your Gemfile:

For Solidus with classic solidus_frontend https://github.com/solidusio/solidus_frontend/ use v1.0 branch.
Solidus until v3.1.x uses solidus_frontend as default

```ruby
gem 'solidus_dynamic_variants', github: 'hefan/solidus_dynamic_variants', branch: 'v1.0'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g solidus_dynamic_variants:install
```


-------------------------

## SOLIDUS STARTER FRONTEND

For Solidus with solidus_starter_frontend https://github.com/solidusio/solidus_starter_frontend use master branch.
Starting from Solidus v3.2.0 solidus_starter_frontend is used as default.

```ruby
gem 'solidus_dynamic_variants', github: 'hefan/solidus_dynamic_variants', branch: 'master'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g solidus_dynamic_variants:install
```

Form override for product form for solidus_starter_frontend
-----------------------------------------------------------

With solidus_starter_frontend you have to override the cart form by hand. The idea is that the frontend code will be customized anyway. There are no more deface hooks. 

For a working example you can put the file in */app/views/cart_line_items/_form.html.erb* in the corresponding place to override the default product form file from solidus_starter_frontend. if you do not use dynamic_variants on a product, the normal form will still work also with this file.

This form view example is tested with solidus_starter_frontend in November 2022.


Principles of view form to work
-------------------------------

The basic principles of the product form will work with every frontend.

* form action for dynamic products should be **/dynamic_cart_line_items**
* each product option type needs to be rendered as select box with the options values id
* you need a hidden_field with the product id

-------------------------


Misc Caveats
-------
Assumes the customized Variant will be created after ordering (or is digital).
This Means: If track inventory is on, the newly created variant will have track_inventory = false.

The newly created variant will have the same SKU like the master variant plus a timestamp.

When you create Orders in the Backend you still need to create variants by hand.



Testing
-------

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs, and [Rubocop](https://github.com/bbatsov/rubocop) static code analysis. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use its factories.
Simply add this require statement to your spec_helper:

```ruby
require 'solidus_dynamic_variants/factories'
```

Copyright (c) 2022 stefan hartmann, released under the New BSD License
