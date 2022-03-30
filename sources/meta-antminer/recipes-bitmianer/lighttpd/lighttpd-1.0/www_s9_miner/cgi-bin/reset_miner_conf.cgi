#!/bin/sh
#set -x
create_default_conf_file()
{
(
cat <<'EOF'
{
"pools" : [
{
"url" : "stratum+tcp://stratum.antpool.com:3333",
"user" : "antminer_1",
"pass" : "123"
},
{
"url" : "stratum+tcp://stratum.antpool.com:443",
"user" : "antminer_1",
"pass" : "123"
},
{
"url" : "stratum+tcp://stratum.antpool.com:25",
"user" : "antminer_1",
"pass" : "123"
}
]
,
"api-listen" : true,
"api-network" : true,
"api-groups" : "A:stats:pools:devs:summary:version",
"api-allow" : "A:0/0,W:*",
"bitmain-fan-ctrl" : false,
"bitmain-fan-pwm" : "100",
"bitmain-use-vil" : true,
"bitmain-economic-mode" : true,
"bitmain-freq" : "250",
"bitmain-voltage" : "1650"

}

EOF
) > /config/cgminer.conf
}

rm -rf /config/cgminer.conf
create_default_conf_file
killall -9 monitorcg
/etc/init.d/cgminer.sh restart >/dev/null 2>&1
cat /config/cgminer.conf


