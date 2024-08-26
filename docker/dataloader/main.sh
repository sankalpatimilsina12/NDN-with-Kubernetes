: '
This script is responsible for following tasks:
1. Loading sample Fastq files
2. Loading human genome reference and building reference database for BLAST 
'

#!/bin/bash

echo "Loading sample Fastq files..."
source ./samples_fastq.sh "$@"

echo "Loading human genome reference and building reference database for BLAST..."
source ./db.sh

echo "Loaded sample Fastq files and human genome reference..."
