Translation hacks for data sent **only** to child GBAs in Single Pak Versus mode.

The Kurukuru Kururin payload is compressed using a routine from the GBA BIOS, so I am required to decompress it, insert my binaries/hacks, re-compress it, and re-insert it into the main ROM.

The main Minigame Paradise payload is *not* compressed, and I can simply navigate to that data in the main ROM. Some VRAM data (payload3) is compressed and has to be modified as such.
