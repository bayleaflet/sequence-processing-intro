# BJC Original Author, 01/18/2024
#
# Should we be setting variables for the alignment name? what about working
# directory?

cd '/Users/bayleechristensen/OneDrive - Utah Tech University/SpringClasses2024/Adv_Bioinfo/Week_2/sequence-processing-intro'

# Reports number of samples
grep -c "^>" ExampleAlignment.fasta >> log.txt

# Reports number of samples with unique dates
awk -F_ '/_[0-9]{1,2}-[[:alpha:]]{3}/{dates[$2]} END {print length(dates)}' ExampleAlignment.fasta >> log.txt

# Pipes sequences to python script
grep -v "^>" ExampleAlignment.fasta | python3 Other.py >> log.txt
