
openssl genrsa -out rancher.slundercloud.com.key -des 2048

openssl req -new -x509 -key rancher.slundercloud.com.key -out rancher.slundercloud.com.crt -days 365 -subj /CN=rancher.slundercloud.com
