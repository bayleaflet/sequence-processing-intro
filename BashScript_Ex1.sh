# BJC Original Author, 01/18/2024

cd '/Users/bayleechristensen/OneDrive - Utah Tech University/SpringClasses2024/Adv_Bioinfo/Week_2/sequence-processing-intro'

# Reports number of samples
grep -c "^>" 10ExampleAlignment.fasta > log.txt

# Reports number of samples with unique dates
awk -F_ '/_[0-9]{1,2}-[[:alpha:]]{3}/{dates[$2]} END {print length(dates)}' 10ExampleAlignment.fasta >> log.txt

# Pass file to python script, outputs the amount of variant sites for the DNA
# sequence and the Amino Acid Sequence
python V2_PyScript.py 10ExampleAlignment.fasta >> log.txt
# Generates amino acid fasta file
python3 Fasta_Generator.py 10ExampleAlignment.fasta Amino_Fasta_file.fasta

# Create a directory for each sequence and save individual DNA and protein sequence files
while read -r header; do
    # Extract the sequence ID from the header
    sequence_id=$(echo "$header" | sed -n 's/^>\(.*\)/\1/p')

    # Create a directory for each sequence
    mkdir -p "$sequence_id"

    # Save the DNA sequence to a file
    sed -n "/$header/,/>/p" 10ExampleAlignment.fasta | sed '1d;$d' > "$sequence_id/dna_sequence.fasta"

    # Translate the DNA sequence to amino acid sequence and save to a file
    # Does not yet work
    #
    # python V2_PyScript.py <(echo -e "$header\n$(sed -n "/$header/,/>/p" 10ExampleAlignment.fasta | sed '1d;$d')") > "$sequence_id/protein_sequence.fasta"
done < 10ExampleAlignment.fasta
