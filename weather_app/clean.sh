#!/bin/bash

weekly=7
monthly=28

keep_data=()
modify_data=()

for i in $(seq 0 $monthly); do
        date_now=$(date --date "today - $i day" "+%Y%m%d")
        if [ $weekly -ge $i ]; then
                keep_data+=($date_now)
        else
                modify_data+=($date_now)
        fi
done

echo ${keep_data[@]}
echo ${modify_data[@]}

for filename in data_logs/*; do
        year="${filename:10:4}"
        month="${filename:14:2}"
        day="${filename:16:2}"
        datetime_log="$year$month$day"
        delete_bool=1
        for allowed_date in ${modify_data[@]}; do
                if [[ $datetime_log == $allowed_date ]]; then
                        # echo 'Modify'
                        sed -n -i '$p' $filename
                        delete_bool=0
                        break
                fi
        done
        for allowed_date in ${keep_data[@]}; do
                if [[ $datetime_log == $allowed_date ]]; then
                        # echo 'Keep'
                        delete_bool=0
                        break
                fi
        done
        if [[ $delete_bool == 1 ]]; then 
                # echo 'Delete'
                rm $filename
        fi
done