#!/bin/bash

scriptUsage() {
    echo "This script is used to run convert File Type from CSV/TSV to XLS/XLSX"
    echo "Usage: ./tsv_csv2xls_xlsx.sh <inputFile> [outFile] [xls|xlsx]"
}

# if no input, print usage
if [ $# -eq 0 ]; then
    scriptUsage
    exit 1
fi

inputFile=$1
outFile=$2
outFileType=$3



# if output file name has xls/xlsx, use it as output file type
if [[ $outFile==*".xls"* ]]; then
    # assign the output file type
    outFileType="xls"
elif [[ $outFile==*".xlsx"* ]]; then
    outFileType="xlsx"
fi

# if no output file name, use the input file name
if [ -z $outFile ]; then
    $outFile=$inputFile
fi

# remove the file type extension from output file name
if [ $outFileType=="xls" ]; then
    outFile=${outFile%.xls}
elif [ $outFileType=="xlsx" ]; then
    outFile=${outFile%.xlsx}
fi

# if no output file type, use xls as default
if [ -z $outFileType ]; then
    outFileType="xlsx"
fi

# convert csv/tsv to xls/xlsx

unix2dos $inputFile
if [ $outFileType=="xls" ]; then
    ssconvert $inputFile $outFile.xls
else
    ssconvert $inputFile $outFile.xlsx
fi