# BJC Original Author, 01/18/2024
# Please enter your working directory in the line below between the quote marks, then save and quit.
cd ''

read -p "Enter the file name of which you would like to perform this script on: " original_file

# Reports number of samples, creates or overwrites log.txt
echo "The total number of samples: " > log.txt
grep -c "^>" $original_file >> log.txt

# Reports number of samples with unique dates
echo "Number of unique sampling dates: " >> log.txt
awk -F_ '/_[0-9]{1,2}-[[:alpha:]]{3}/{dates[$2]} END {print length(dates)}' $original_file >> log.txt

# Pass file to python script, outputs the amount of variant sites for the DNA sequence and the Amino Acid Sequence
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

    # Save the DNA sequence to the dna_sequence file
    sed -n "/$header/,/>/p" $original_file | sed '1d;$d' > "Separated_Output/$sequence_id/dna_sequence"

    # Translate the DNA sequence to amino acid sequence and save to the
    # protein_sequence file
    sed -n "/$header/,/>/p" "$protein_fasta_file" | sed '1d;$d' | tr -d '\n' > "Separated_Output/$sequence_id/protein_sequence"
done < $original_file

# Optional Preference
rm -r Separated_Output/dna_sequence.fasta Separated_Output/protein_sequence.fasta

# User friendly output
echo -e "Output Successful"
echo -e "\n1. Please see log.txt for: \n  A. The number of samples. \n  B. The number of unique sampling dates.\n  C. The number of variant sites in the DNA sequence. \n  D. The number of variant sites in the protein sequence."
echo -e "\n2. The amino acid alignment was generated, and is called 'Amino_Translation.fasta'"
echo -e "\n3. The directory that contains directories for each sequence with \n   individual dna sequences and protein sequences is in 'Separated_Output'"
