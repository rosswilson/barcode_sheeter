require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'

DIGIT_PADDING = 5
PREFIX = "SU"

(693..852).each do |i|
  code = PREFIX + i.to_s.rjust(DIGIT_PADDING, "0")

  puts "Generating: #{code}"

  barcode = Barby::Code128B.new(code)

  blob = Barby::PngOutputter.new(barcode).to_png(margin: 0, xdim: 3, height: 280) #Raw PNG data

  File.open("barcodes/barcode_#{code}.png", 'w') { |f| f.write blob }
end
