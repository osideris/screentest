#!/bin/sh
find $data -type f -name "*.csv" -exec mv -i {} /csvdata \;

total=0

find /csvdata/ -type f -exec wc -l {} \; | awk '{total += $1} END{print total}'

find /csvdata/ -type f -name "*.csv*" -exec wc -w {} + >> files_wc.csv

for f in *.csv; do 
	awk -F, '{ exit (NF < 1? 0:1) }' "$f" && mv "$f" "${f}.bad"
done

awk '{print NF}' *.csv | sort -nu | tail -n 1

awk '{sum+=$2}END{printf "Sum=%d\nCount=%d\nAve=%.2f\n",sum,NR,sum/NR}' *.csv

#total word count=find /csvdata/ -type f -exec wc -l {} \; | awk '{total += $1} END{print total}'

#total row number = -2147483647
#total word count = 3027535
#Average=NAN(not a real number)

