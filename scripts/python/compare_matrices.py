#import pandas as pd
import numpy as np
import sys

def check_equal(l_file, r_file):
    """ Read in matrices generated by print() in Daphne.
    Assumes the first line contains meta data like: DenseMatrix(2048x2048, double)."""
    with open(l_file, "rt") as left:
        line = left.readline()
        size = int(line.split("(")[-1].split("x")[0])
        with open(r_file, "rt") as right: 
            right.readline()
            equal_so_far = True
            line_number = 0
            while (equal_so_far and line_number < size):
                l_line = [np.float64(e) for e in left.readline().split(" ")]
                r_line = [np.float64(e) for e in right.readline().split(" ")]
                equal_so_far = np.allclose(l_line, r_line)
                line_number += 1
            return equal_so_far
    """left = pd.read_csv(l_file, skiprows=1, header=None, sep=" ", nrows=size)
    right = pd.read_csv(r_file, skiprows=1, header=None, sep=" ", nrows=size)
    if left.equals(right):
        print("Matrices are equal.")
        return True
    else:
        print("Matrices are NOT equal.")
        return False"""

if __name__ == "__main__":
    if len(sys.argv) == 3:
        if check_equal(sys.argv[1], sys.argv[2]):
            print("equal:True")
        else:
            print("equal:False")
    else:
        print(f"Incorrect number of command line arguments {len(sys.argv)}. Should be 2.")