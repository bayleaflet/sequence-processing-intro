# BJC Original Author, 01/18/2024

cd '/Users/bayleechristensen/OneDrive - Utah Tech University/SpringClasses2024/Adv_Bioinfo/Week_2/sequence-processing-intro'
read -p "Enter the file name of which you would like to perform this script on: " original_file

# Reports number of samples
grep -c "^>" $original_file > log.txt

# Reports number of samples with unique dates
awk -F_ '/_[0-9]{1,2}-[[:alpha:]]{3}/{dates[$2]} END {print length(dates)}' $original_file >> log.txt

# Pass file to python script, outputs the amount of variant sites for the DNA
# sequence and the Amino Acid Sequence
python DNA_Processing.py $original_file >> log.txt
# Generates amino acid fasta file
python3 Fasta_Generator.py $original_file Amino_Translation.fasta

protein_fasta_file="Amino_Translation.fasta"

# Create a directory for each sequence and save individual DNA and protein sequence files
while read -r header; do
    # Extract the sequence ID from the header
    sequence_id=$(echo "$header" | sed -n 's/^>\(.*\)/\1/p')

    # Create a directory for each sequence
    mkdir -p "Separated_Output/$sequence_id"

    # Save the DNA sequence to a file
    sed -n "/$header/,/>/p" $original_file | sed '1d;$d' > "Separated_Output/$sequence_id/dna_sequence.fasta"

    # Translate the DNA sequence to amino acid sequence and save to a file
    sed -n "/$header/,/>/p" "$protein_fasta_file" | sed '1d;$d' | tr -d '\n' > "Separated_Output/$sequence_id/protein_sequence.fasta"
done < $original_file
rm -r Separated_Output/dna_sequence.fasta Separated_Output/protein_sequence.fasta
echo -e "Output Successful"
echo -e "\n1. Please see log.txt for: \n  A. The number of samples. \n  B. The number of unique sampling dates.\n  C. The number of variant sites in the DNA sequence. \n  D. The number of variant sites in the protein sequence."
echo -e "\n2. The amino acid alignment was generated, and is called 'Amino_Translation.fasta'"
echo -e "\n3. The directory that contains directories for each sequence with \n   individual dna sequences and protein sequences is in 'Separated_Output'"
