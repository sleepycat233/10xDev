/* Pro Micro Test Code
   by: Nathan Seidle
   modified by: Jim Lindblom
   SparkFun Electronics
   date: September 16, 2013
   license: Public Domain - please use this code however you'd like.
   It's provided as a learning tool.

   This code is provided to show how to control the SparkFun
   ProMicro's TX and RX LEDs within a sketch. It also serves
   to explain the difference between Serial.print() and
   Serial1.print().
*/

#include <Arduino.h>

const int PWM_LED = 10;
uint8_t brightness = 0;

void setup() {
    pinMode(PWM_LED, OUTPUT);
    Serial.begin(9600);
}

void loop() {
    Serial.println(brightness);
    brightness++;
    analogWrite(PWM_LED, brightness);
    delay(3);
}
