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

  x_cursor = 0.2.in
  y_cursor = 10.05.in

  x_interval = 1.in
  y_interval = 2.25.in

  x_label_max = 8
  y_label_max = 4

  label_width = 1.01.in
  label_height = 0.77.in

  barcode_width = 0.8.in
  barcode_height = 0.55.in

  # USER EDITABLE END

  page_count = 0

  x_label_count = 1
  y_label_count = 1

  x_margin = x_cursor

  barcode_pngs.each do |barcode_path|
    image_side_margin = (label_width - barcode_width) / 2
    image_top_bottom_margin = 0

    image barcode_path, at: [x_cursor + image_side_margin, y_cursor - image_top_bottom_margin],
      width: barcode_width, height: barcode_height

    # Insert a text label of the barcode number for manual entry
    text = File.basename(barcode_path, ".png").to_s.gsub("barcode_", "")
    draw_text text.to_s, at: [x_cursor + image_side_margin + 0.05.in, y_cursor - barcode_height - image_top_bottom_margin - 0.16.in]

    # Move onto next label
    x_label_count += 1
    x_cursor += x_interval

    page_count += 1

    # If we're at maximum across X axis, reset to left-hand side and move down
    if x_label_count > x_label_max
      x_label_count = 1
      x_cursor = x_margin

      y_cursor -= y_interval

      if page_count == x_label_max * y_label_max
        page_count = 0

        start_new_page
        y_cursor = 10.05.in
      end
    end
  end
end
