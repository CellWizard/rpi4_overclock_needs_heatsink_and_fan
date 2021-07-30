vcgencmd measure_temp
for id in core sdram_c sdram_i sdram_p ; do \
    echo -e "$id:\t$(vcgencmd measure_volts $id)" ; \
done
for src in arm core h264 isp v3d uart pwm emmc pixel vec hdmi dpi ; do \
    echo -e "$src:\t$(vcgencmd measure_clock $src)" ; \
done
