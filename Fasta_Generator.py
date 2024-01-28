# BJC, original author, 1/28/24
from V2_PyScript import read_fasta_file, translate_to_amino
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import argparse

def main():
    ''' Reads a fasta file, translates the DNA sequence to the amino acid
    sequence, and replaces the dna sequences with amino acid sequences. Then
    writes out the file'''

    parser = argparse.ArgumentParser(description="Writes out fasta file, replacing dna sequence with amino acid sequence")
    parser.add_argument("input_file", help="Path to fasta file")
    parser.add_argument("output_file", help="Path to output fasta file")
    args = parser.parse_args()

    dna_seqs = read_fasta_file(args.input_file)
    amino_acid_seqs = translate_to_amino(dna_seqs)

    # Replace DNA sequences with amino acid sequences with original SeqRecord Object Headers
    for i, record in enumerate(dna_seqs):
        try:
            # Convert the amino acid sequence to a Seq object
            amino_acid_seq = Seq(amino_acid_seqs[i])
            # Create a new SeqRecord with the same ID and description, but updated sequence
            updated_record = SeqRecord(amino_acid_seq, id=record.id, description=record.description)
            dna_seqs[i] = updated_record
        except IndexError as e:
            print(f"Error setting sequence for record with ID {record.id}: {e}")
            print(f"Record information: {record}")

    with open(args.output_file, "w") as output_handle:
        SeqIO.write(dna_seqs, output_handle, "fasta")

if __name__ == "__main__":
    main()

