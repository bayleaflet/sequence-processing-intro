# BJC, Original Author, 1/28/24
import Bio
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO
import sys
import argparse

def read_fasta_file(input_file):
    # Reads fasta file, returns sequences as a list of SeqRecord objects. In
    # hindsight, I should have started with this. It would have saved me a ton
    # of trouble. Instead I was sending each sequence in to a python list as a
    # string. If I do seqrecord objects I could have figured this out
    # earlier...
    dna_sequences = []
    with open(input_file, "r") as file:
        for record in SeqIO.parse(file, "fasta"):
              dna_sequences.append(record)
    return dna_sequences

def translate_to_amino(seq_objs):
    amino_acid_seqs = []
    for record in seq_objs:
        try:
            amino_acid_seqs.append(str(record.seq.translate()))
        except Exception as e:
            print(f" Error translating sequence for record with ID {record.id}: {e}")
            amino_acid_seqs.append("N/A")
    return amino_acid_seqs

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
    parser = argparse.ArgumentParser(description = "Count variant sites of dna and amino acid chains")
    parser.add_argument("input_file", help="Path to fasta file")
    args = parser.parse_args()


    dna_seqs = read_fasta_file(args.input_file)
    amino_acid_seqs = translate_to_amino(dna_seqs)
    dna_seqs_as_str = []
    for record in dna_seqs:
        dna_seqs_as_str.append(str(record.seq))
    variant_sites_dna = count_variant_sites(dna_seqs_as_str)
    variant_sites_aa = count_variant_sites(amino_acid_seqs)
    print("Number of variant sites in DNA seq:", variant_sites_dna)
    print("Number of variant sites in amino acid seq:", variant_sites_aa)

if __name__== "__main__":
    main()
