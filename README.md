# Liquidoc

Bring the power of [Liquid template language](https://github.com/Shopify/liquid) to your documents!
Liquidoc gives you ability to easily create documents from templates.
Only `.txt` and `.docx` templates are currently supported.

Liquidoc is super-easy to use so even your customers can create their own templates.

![Liquidoc demo](https://raw.githubusercontent.com/railscard/liquidoc/master/misc/before-after.gif)

## Installation

Add this line to your application's Gemfile:

    gem 'liquidoc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liquidoc

## Usage

To get started you need to create a template:

```ruby
require 'liquidoc'

template = Liquidoc.template('/path/to/file')
```
Then you need a context, it is just a plain ruby hash:

```ruby
context = { "name" => "Max", "hobby" => "Music" }
```
Now you can create the final document:
```ruby
template.render_to_file("/tmp/document_demo.docx", context)
```

## Rails
`config/initializers/mime_types.rb`
```ruby
Mime::Type.register 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', :docx
```
`app/drops/invoice_drop.rb`
```ruby
class InvoiceDrop < Liquid::Drop
  def initialize(invoice)
    @invoice = invoice
  end

  def date
    @invoice.date
  end

  # And you can just proxy every method call directly to invoice (may be dangerous!)
  def before_method(method_name)
    if @invoice.respond_to?(method_name)
      @invoice.public_send(method_name)
    else
      "Unknown method: #{method_name}"
    end
  end
end
```
`app/controllers/invoices_controller.rb`
```ruby
class InvoiceController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html
      format.docx {
        template = Liquidoc.template(@invoice.template)
        content  = { 'invoice' => InvoiceDrop.new(@invoice) }
        send_data template.render_to_string(content), filename: 'invoice.docx'
      }
    end
  end
end
```

## Contributing

1. Fork it ( http://github.com/railscard/liquidoc/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Special thanks to [Shopify](https://github.com/Shopify)!
