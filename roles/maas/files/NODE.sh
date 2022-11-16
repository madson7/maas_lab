NODE=node-40

sudo maas root machines create \
    architecture="amd64/generic" \
    mac_addresses="ac:1f:6b:6a:7d:0d" \
    hostname=${NODE} \
    power_type=ipmi \
    power_parameters_power_driver=LAN_2_0 \
    power_parameters_power_user=ADMIN \
    power_parameters_power_pass=ADMIN \
    power_parameters_power_address="192.168.100.40"

NODE=node-45

sudo maas root machines create \
    architecture="amd64/generic" \
    mac_addresses="00:25:90:5f:ca:c7" \
    hostname=${NODE} \
    power_type=ipmi \
    power_parameters_power_driver=LAN_2_0 \
    power_parameters_power_user=ADMIN \
    power_parameters_power_pass=ADMIN \
    power_parameters_power_address="192.168.100.45"


NODE=node-41

sudo maas root machines create \
    architecture="amd64/generic" \
    mac_addresses="10:98:36:A2:8A:B1" \
    hostname=${NODE} \
    power_type=ipmi \
    power_parameters_power_driver=LAN_2_0 \
    power_parameters_power_user=root \
    power_parameters_power_pass=root \
    power_parameters_power_address="192.168.100.41"

NODE=node-42

sudo maas root machines create \
    architecture="amd64/generic" \
    mac_addresses="18:66:DA:63:28:CB" \
    hostname=${NODE} \
    power_type=ipmi \
    power_parameters_power_driver=LAN_2_0 \
    power_parameters_power_user=root \
    power_parameters_power_pass=root \
    power_parameters_power_address="192.168.100.42"

NODE=node-43

sudo maas root machines create \
    architecture="amd64/generic" \
    mac_addresses="18:66:DA:64:76:1E" \
    hostname=${NODE} \
    power_type=ipmi \
    power_parameters_power_driver=LAN_2_0 \
    power_parameters_power_user=root \
    power_parameters_power_pass=root \
    power_parameters_power_address="192.168.100.43"

NODE=node-44

sudo maas root machines create \
    architecture="amd64/generic" \
    mac_addresses="f4:02:70:d2:53:94" \
    hostname=${NODE} \
    power_type=ipmi \
    power_parameters_power_driver=LAN_2_0 \
    power_parameters_power_user=root \
    power_parameters_power_pass=root \
    power_parameters_power_address="192.168.100.44"


NODE=storage-46

sudo maas root machines create \
    architecture="amd64/generic" \
    mac_addresses="18:66:DA:9A:7D:F5" \
    hostname=${NODE} \
    power_type=ipmi \
    power_parameters_power_driver=LAN_2_0 \
    power_parameters_power_user=root \
    power_parameters_power_pass=root \
    power_parameters_power_address="192.168.100.46"