# ATMega development with arduino-cli

This directory provides a Docker-based Arduino IDE 1.8.19 environment targeting ATmega boards (Diecimila, Nano, Pro).

Below is the equivalent workflow using [`arduino-cli`](https://arduino.github.io/arduino-cli/) directly on your host machine.

## Install arduino-cli

```bash
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
```

Or via Homebrew:

```bash
brew install arduino-cli
```

## Initial setup

```bash
# Create config (answers "yes" to prompts automatically)
arduino-cli config init

# Enable git/zip library install (disabled by default)
arduino-cli config set library.enable_unsafe_install true

# Install AVR core
arduino-cli core update-index
arduino-cli core install arduino:avr
```

## Install libraries

```bash
arduino-cli lib install \
  "RFM69_LowPowerLab" \
  "SPIFlash_LowPowerLab" \
  "LowPower_LowPowerLab" \
  "Adafruit Circuit Playground" \
  "Adafruit Unified Sensor" \
  "Adafruit BusIO" \
  "Adafruit INA219" \
  "Adafruit HTU21DF Library" \
  "DHT sensor library" \
  "Adafruit BME280 Library" \
  "OneWire" \
  "DallasTemperature" \
  "Adafruit TSL2561" \
  "FastLED" \
  "WebSockets" \
  "ArduinoJson" \
  "AccelStepper"
```

Some libraries are not in the official index and must be installed from Git:

```bash
arduino-cli lib install --git-url https://github.com/jeelabs/jeelib.git
arduino-cli lib install --git-url https://github.com/hallard/LibTeleinfo.git
```

> **Note:** The `boards-atmega.txt` file is only relevant for the Arduino IDE GUI (it hides unused board entries from the menu). With `arduino-cli` you select the board explicitly by FQBN – no hiding is needed.

## Search for boards

```bash
# List all supported boards and search for a keyword
% arduino-cli board listall | grep -i nano

# Search the board index for a specific model
% arduino-cli board listall nano          
Board Name            FQBN
Arduino Nano          arduino:avr:nano
Arduino Nano ESP32    esp32:esp32:nano_nora
Geekble nano ESP32-S3 esp32:esp32:Geekble_Nano_ESP32S3
M5NanoC6              esp32:esp32:m5stack_nanoc6
Nano32                esp32:esp32:nano32
UM NanoS3             esp32:esp32:um_nanos3

# For Arduino Nano (ATmega328P, old bootloader)
% export BOARD=arduino:avr:nano:cpu=atmega328old

# For Arduino Pro/Pro Mini (ATmega328P, 16 MHz)
% export BOARD=arduino:avr:pro:cpu=16MHzatmega328

# For ESP32 Wemos
% export BOARD=esp32:esp32:d1_mini32
```

## Compile a sketch

```bash
% export SKETCH=./src/main/sketches/Blink
% arduino-cli compile --fqbn ${BOARD} ${SKETCH}
```

## Upload to a board

```bash
# List connected boards to find the port
arduino-cli board list

# Upload (replace /dev/cu.usbserial-XXXX with your port)
arduino-cli upload --fqbn arduino:avr:nano:cpu=atmega328old --port /dev/cu.usbserial-110 ./src/main/sketches/Blink
```

### Common FQBNs for the visible boards

| Board                | FQBN                                                    |
|----------------------|---------------------------------------------------------|
| Diecimila            | `arduino:avr:diecimila`                                 |
| Nano (old bootloader)| `arduino:avr:nano:cpu=atmega328old`                     |
| Nano (new bootloader)| `arduino:avr:nano`                                      |
| Pro Mini 16 MHz      | `arduino:avr:pro:cpu=16MHzatmega328`                    |
| Pro Mini 8 MHz       | `arduino:avr:pro:cpu=8MHzatmega328`                     |

## Full example (one-liner)

```bash
arduino-cli compile --fqbn arduino:avr:nano:cpu=atmega328old ./src/main/sketches/Blink \
  && arduino-cli upload --fqbn arduino:avr:nano:cpu=atmega328old --port /dev/cu.usbserial-110 ./src/main/sketches/Blink
```
