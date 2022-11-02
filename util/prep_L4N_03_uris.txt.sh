#!/bin/bash

mv uris.txt uris.txt.old

sed -e 's@MD5(@https://www.nemotos.net/l4n-abis/L4N-2204-ABIS-20221102-split/@' -e 's@)@\r  check-integrity=true\n@' -e 's@= @  checksum=md5=@' md5list.txt > uris.txt

