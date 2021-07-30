echo 1
echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
#echo fd500000.pcie > /sys/bus/platform/drivers/brcm-pcie/unbind
#sleep 3
# change mxl7704 core switching frequency to max to improve voltage stability
i2cset -y 3 0x1d 0x19 0xef
echo 2
# write to undocumented mxl7704 register to bypass all failsafe resets
i2cset -y 3 0x1d 0xa 0xf
#sleep 3
#i2cget -y 3 0x1d 0xb
echo 3
# set core voltage check mxl7704 datasheet for values, never go above 0xc4 or risk burning up pi
i2cset -y 3 0x1d 0x14 0xf2
#sleep 3
#./devmem2 0xfe101008 w 0x5a000251
#./devmem2 0xfe101038 w 0x5a0002D1
echo 4
./devmem2 0xfe1010f0 w 0x5a0002b6
#sleep 3
sleep 0.2
echo 5
./devmem2 0xfe1010f0 w 0x5a000226
#sleep 3
sleep 0.2
echo 6
./devmem2 0xfe1010a0 w 0x5a0000b6
#sleep 3
sleep 0.2
echo 7
./devmem2 0xfe1010a0 w 0x5a000024
#sleep 3
echo 8
./devmem2 0xfe1023e0 w 0x5a000001
#sleep 3
echo 9
# last byte is ARM cpu multiplier
./devmem2 0xfe1021e0 w 0x5a021032
#sleep 3
# fractional and integer V3D PLL divider short, look up BCM2835 registers on google for more info
./devmem2 0xfe10103c w 0x5a001000
# integer V3D Divider
./devmem2 0xfe102400 w 0x5a000002
./devmem2 0xfe102100 w 0x5a021020
#GOOD Value ./devmem2 0xfe102100 w 0x5a021023
#./devmem2 0xfe102120 w 0x5a021028
./devmem2 0xfe102120 w 0x5a021018
#GOOD Value ./devmem2 0xfe102120 w 0x5a021022
./devmem2 0xfe102620 w 0x5a000003
#./devmem2 0xfe102420 w 0x5a000001
#./devmem2 0xfe102320 w 0x5a000001
echo 10
# fractional and integer VPU Core PLL divider short, look up BCM2835 registers on google for more info
./devmem2 0xfe10100c w 0x5a001600
#sleep 3
#./devmem2 0xfe1011c4 w 0x5a003000
# set core voltage check mxl7704 datasheet for values, never go above 0xc4 or risk burning up pi
i2cset -y 3 0x1d 0x14 0xf2
#i2cset -y 3 0x1d 0x14 0xa4
#i2cset -y 3 0x1d 0x14 0xa0
