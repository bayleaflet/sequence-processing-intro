import Bio
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import sys

def main():

    DNA_sequences = []
    variant_sites_count = 0
    # could tie this into a function
    for line in sys.stdin:
        #Process each sequence line from stdin and make each sequence a list
        DNA_sequences.append(list(line.strip()))

    # Since all sequences have same length, we find the sequence length for later reference
    sequence_length = len(DNA_sequences[0])

    # iterate over each position in the sequences
    for i in range(sequence_length):
        # Looks at every sequence position i for every sequence
        current_positions = [seq[i] for seq in DNA_sequences]

        # Checks if there is more than one unique character at that position
        if len(set(current_positions)) > 1:
            variant_sites_count += 1

    print("Number of variant sites: ", variant_sites_count)

#
#
# Stopped here, will need to review more tomorrow
#
#
def TranslateFile(list_of_sequences):
    for nuc in range(sequence_length):
        protein_seq = dna_record.seq.translate()


    # write translated protein sequences to a new fasta file
    SeqIO.write(protein_sequences, output_fasta, "fasta")

    return protein_sequences


if __name__== "__main__":
    main()




