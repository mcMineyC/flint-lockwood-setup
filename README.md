# flint-lockwood-setup
This repo contains all resources used to recreate the Flint Lockwood lab computer setup irl

# Inspiration
This project was originally inspired by the movie "Cloudy With a Chance of Meatballs".  I've always thought Flint's setup (using old TVs as one gigantic monitor) was insanely cool and the biggest flex, and now that I know a little bit about Linux I'm trying to recreate it.

![hehe](https://forkleserver.mooo.com/blogAssets/lockwood_setup.jpg)
Picture for reference

# Setup
1. Making the fake EDID binary
- `cd edid-gen`
- `cvt 2732 1536 60 -r > modeline` (don't ask me what the -r flag does, but it makes it work)
- `cat modeline | ./modeline2edid`
- The output file should be called `xResolution`x`yResolution`R.bin (in this case it's 2736x1536R.bin, accomodating a 4x4 array of 1366x768 monitors)
