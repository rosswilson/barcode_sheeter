Barcode Sheeter
===============

I wanted an easy, scriptable way to generate a sheet of barcode labels suitable for printing. This repo contains two scripts. The first `barby.rb` outputs a collection of PNG barcode images based on a sequential numerical range. This range can have an alphanumeric prefix and the sequential number is zero-padded (currently to 5 digits).

The second script: `generator.rb` takes the generated PNG barcodes and arranges them on a PDF page based on a supplied measurements like page margin, distance between labels, number of labels on X and Y axis ect. You get a nice PDF output ready for printing.

This script is under development but forms the basis for an automated barcode label generation feature for [KitScan](https://kitscan.com) - an online asset tracking and management tool.

## TODO

- Support multiple pages: use Prawn's `start_new_page` method
- Pass PNG data blobs straight from Barby to Prawn without having to write and then read from disk
- Take list of barcodes to generate from STDIN pipe or simple text file (one per line)
- Introduce template files that contain the page layout measurements, extracting them from the actual .rb file and allowing different sheet label types to be swapped out rapidly.
- Error checking! And status reporting so calling processes are notified of success/failure 
