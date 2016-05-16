DriVR Autonomous Car Parking Script
=================

This is a script that allows our model of car to check the size of parking space and perform autonomous parking based on distances measured by ultrasonic sensors.

The parking is initialized by running the following script:

```
./park.sh
```

Dependecies
-----------

There are some dependecies. The presences of `/etc/rc.local` script that is part of [udpmotorcontrol repository](https://github.com/FIIT-TNL/udpmotorcontrol) is assumed. 

To control DC motors **(pi-blaster)[https://github.com/sarfata/pi-blaster]** is used.

To control servos (steering) **[ServoBlaster project](https://github.com/richardghirst/PiBits/tree/master/ServoBlaster) is used.

Files
-----
Additional scripts are present to make solution more modular and reusabled and allow easier configuration for specific actions.

### Anticrash
Files `anticrash.sh` and `anticrush_run.sh` implements simple algorithm for prevention from hitting obstacles detected by sensors. If obstacle is too close `go.sh` script is used to stop the vehicle.

### Distance measurements
`dist.sh` - reads the distance using `getdist2` for sensors specified in arguments. Arguments can have following values: `FRONT`, `BACK`, `SIDEFRONT` or `SIDEBACK`.

`repdist.sh` - script to repeatedly read all distances using `getdist2` once per second.

### Low level car control
Separate commands are created to control car in the following directions:

`forward.sh` - turn on DC motor to move forward (pwm speed = 0.5).

`backward.sh` - turn on DC motor to move forward (pwm speed = 0.5).

`stop.sh` - turn off DC motor to stop the vehicle.

`left.sh` - steer front wheels left (for used servo this is 890us).

`right.sh` - steer front wheels right (for used servo this is 670us).

`straight.sh` - steer front wheels left (for used servo this is 768us).

`straight_fw.sh` - The exact direction of our vehicle was influenced by previous steering position of front wheels. To eliminate this effect, this script first steers right, then left and finally centers the the wheels.

### Hi level car control
`go.sh` - script to set the speed of vehicle. First argument values: `forward`, `backward` or `stop`.
`steer.sh` - script to steer front wheels of car to change the direction. First argument values: `straight`, `left` or `right`.

### Simples parking script
`hardcoded_park.sh` - script to park the vehicle with 3 times specified by parameters - reverse right, reverse left, straight forward.

`hardcoded_park_run.sh` - run previous script using correct parameters to park and to get back to the original position.

### Setup
`setup.sh` - calls `/etc/rc.local` to setup pins, pi-blaster & servoblaster. The presences of `/etc/rc.local` script that is part of [udpmotorcontrol repository](https://github.com/FIIT-TNL/udpmotorcontrol) is assumed. 

Author
------

Team TechNoLogic <teamtechnologic@googlegroups.com>

License (MIT)
-------------

Copyright (c) 2014 Team TechNoLogic

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
