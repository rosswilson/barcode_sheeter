require "prawn"
require "prawn/measurement_extensions"

# Embedded within the PDF file
metadata = {
  Title: "Panduit S100X225YAJ Template",
  Author: "Ross Wilson",
  Subject: "Bulk barcode generator",
  Creator: "KitScan Limited",
  Producer: "KitScan Limited",
  CreationDate: Time.now
}

# Get all .png files in the barcodes directory
barcode_pngs = Dir["barcodes/*.png"]

# Announce which barcodes we found
puts "Found the following barcode images:"
puts barcode_pngs

Prawn::Document.generate("output.pdf", page_size: "LETTER", margin: 0, info: metadata) do

  # USER EDITABLE START

  x_cursor = 0.25.in
  y_cursor = 10.in

  x_interval = 1.in
  y_interval = 2.25.in

  x_label_max = 8
  y_label_max = 4

  label_width = 1.in
  label_height = 0.75.in

  barcode_width = 0.9.in
  barcode_height = 0.65.in

  # USER EDITABLE END

  x_label_count = 1
  y_label_count = 1

  x_margin = x_cursor

  barcode_pngs.each do |barcode_path|
    image_side_margin = (label_width - barcode_width) / 2
    # image_width = (image_side_margin * 2) + barcode_width

    image_top_bottom_margin = (label_height - barcode_height) / 2
    # image_height = (image_top_bottom_margin * 2) + barcode_height

    image barcode_path, at: [x_cursor + image_side_margin, y_cursor - image_top_bottom_margin],
      width: barcode_width, height: barcode_height

    # Move onto next label
    x_label_count += 1
    x_cursor += x_interval

    # If we're at maximum across X axis, reset to left-hand side and move down
    if x_label_count > x_label_max
      x_label_count = 1
      x_cursor = x_margin

      y_cursor -= y_interval
    end
  end
end
