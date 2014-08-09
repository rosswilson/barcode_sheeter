# Generates individual PNG Code128 barcode images for a range of prefixed barcodes
# Author: Ross Wilson (@rosswilson on GitHub)

require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'
require 'FileUtils'

puts "Optional arguments: barby.rb [PREFIX [START_NUMBER END_NUMBER]]"

DIGIT_PADDING = 5

prefix = ARGV.length >= 1 ? ARGV[0] : "SU"

range = ARGV.length >= 3 ? ARGV[1].to_i .. ARGV[2].to_i : 1..32

puts "Generating #{range.size} Code128 barcodes into ./barcodes"

puts "Removing old .pngs from output directory"
FileUtils.rm_rf(Dir.glob('barcodes/*.png'))

(range).each do |i|
  code = prefix + i.to_s.rjust(DIGIT_PADDING, "0")
  puts "Generating: #{code}"

  barcode = Barby::Code128B.new(code)
  png_data = Barby::PngOutputter.new(barcode).to_png(margin: 0, xdim: 3, height: 280) # Raw PNG data

  # Write raw PNG barcode data to actual file
  File.open("barcodes/#{code}.png", 'w') { |f| f.write png_data }
end
