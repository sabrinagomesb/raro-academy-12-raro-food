# frozen_string_literal: true

module ApplicationHelper
  include TailwindHelpers

  # Format to dolar currency
  def usa_currancy(number)
    number_to_currency(number, unit: '$', precision: 2, delimiter: ',', format: '%u%n')
  end

  # Returns the address in a single line
  def address_in_one_line(address)
    "#{address.public_place}, #{address.number} - #{address.zip_code}. #{address.city.name}/#{address.city.state.acronym}"
  end

  # SVG
  def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    asset = assets.find_asset(filename)

    if asset
      file = asset.source.force_encoding('UTF-8')
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css 'svg'
      svg['class'] = options[:class] if options[:class].present?
    else
      doc = "<!-- SVG #{filename} not found -->"
    end

    raw doc
  end
end
