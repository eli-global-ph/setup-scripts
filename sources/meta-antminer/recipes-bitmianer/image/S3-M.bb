require recipes-bitmianer/image/S3.bb

IMAGE_INSTALL += " \
	minermonitor \
	monitor-ipsig \
	"
#IMAGE_INSTALL += "monitor-ipsig"
#IMAGE_INSTALL += "d-ddos"

export IMAGE_BASENAME = "antminer_m"

