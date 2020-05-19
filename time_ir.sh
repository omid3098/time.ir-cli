#!/bin/bash

url=https://www.time.ir/
shamsi_div_id_numeral="ctl00_cphTop_Sampa_Web_View_TimeUI_ShowDate00cphTop_3734_lblShamsiNumeral"
hijri_div_id_numeral="ctl00_cphTop_Sampa_Web_View_TimeUI_ShowDate00cphTop_3734_lblHijriNumeral"
georgian_div_id_numeral="ctl00_cphTop_Sampa_Web_View_TimeUI_ShowDate00cphTop_3734_lblGregorianNumeral"

# Download time.ir into a file
curl ${url} -o time_ir -s

function get_clean_time() {
    echo $(cat time_ir | egrep $1 | egrep '>([^<]*)<' -o | tr -d '><')
}

function usage() {
    echo "\

A terminal usage for Time.ir website to get current date.

Usage: ./time_ir.sh [options]

-hs     --shamsi        Shows hijri shamsi date\n
-hg     --qamari        Shows hijri ghamari date\n
-g      --georgian      Shows georgian date\n
    "
}

while [ "$1" != "" ]; do
    case $1 in
    -hs | --shamsi)
        get_clean_time $shamsi_div_id_numeral
        ;;
    -hq | --qamari)
        get_clean_time $hijri_div_id_numeral
        ;;
    -g | --georgian)
        get_clean_time $georgian_div_id_numeral
        ;;
    -h | --help)
        usage
        exit
        ;;
    *)
        usage
        exit 1
        ;;
    esac
    shift
done
