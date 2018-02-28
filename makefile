display: convert
	display image.png

all: Main.rb
	ruby Main.rb

cat: all
	cat image.ppm

convert: all
	convert image.ppm image.png
	rm image.ppm

clean:
	rm *~ *.ppm *.png
