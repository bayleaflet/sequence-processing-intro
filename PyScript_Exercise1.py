import Bio
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import sys

def read_dna_sequences():
    dna_sequences = []
    for line in sys.stdin:
        if line[0] != '>':
        # Puts all sequences in a List
            dna_sequences.append(list(line.strip()))
    return dna_sequences

def translate_to_amino(dna_sequences):
    # Had help with this step, I think it puts everything from the list back
    # into a string, which makes me think twice about putting everything in a
    # list in the first place. Regardless, Seq makes a Seq object, in which
    # Bipython's magic turns it into a special object that can be translated.
    dna_seqs = [Seq(''.join(seq)) for seq in dna_sequences]
    amino_acid_sequences = [seq.translate() for seq in dna_seqs]
    return amino_acid_sequences

def count_variant_sites(sequence_list):
    variant_sites_count =0
    sequence_length = len(sequence_list[0])
    for i in range(sequence_length):
        # Creates a list of current_positions containing ith character for each
        # sequence in sequence_list. Then extracts character at position i in
        # each sequence.
        current_positions = [seq[i] for seq in sequence_list]
        if len(set(current_positions)) > 1:
            variant_sites_count += 1
    return variant_sites_count

def main():
    dna_sequences = read_dna_sequences()
    amino_acid_sequences = translate_to_amino(dna_sequences)
    variant_sites_dna = count_variant_sites(dna_sequences)
    variant_sites_aa = count_variant_sites(amino_acid_sequences)
    print("Num of variant sites in DNA seq:", variant_sites_dna)
    print("Num of varaint sites in amino acid seq:", variant_sites_aa)
    # Pass protein sequence into each line of the fasta file instead of the DNA
    # sequence. (I believe this is what we are supposed to do?)

if __name__== "__main__":
    main()




