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

## Compile a sketch

```bash
# For Arduino Nano (ATmega328P, old bootloader)
arduino-cli compile --fqbn arduino:avr:nano:cpu=atmega328old ./src/main/sketches/Blink

# For Arduino Nano (ATmega328P, new bootloader)
arduino-cli compile --fqbn arduino:avr:nano ./src/main/sketches/Blink

# For Arduino Pro/Pro Mini (ATmega328P, 16 MHz)
arduino-cli compile --fqbn arduino:avr:pro:cpu=16MHzatmega328 ./src/main/sketches/Blink

# For Arduino Diecimila
arduino-cli compile --fqbn arduino:avr:diecimila ./src/main/sketches/Blink
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
