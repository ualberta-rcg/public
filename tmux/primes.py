import numba as nb
import numpy as np
from math import sqrt, ceil

def main():
    print(find_primes(12_000_000))

@nb.vectorize(['int32(int32)'], target='cuda')
def check_prime_gpu(num):
    for i in range(2, (num // 2) + 1):
       if (num % i) == 0:
           return 0
    return num

def find_primes(num):
    batch = 100_000
    lowest = 2
    highest = min(batch, num)
    primes = []
    while lowest <= num:
        numbers = np.arange(lowest, highest, dtype=np.int32)
        lowest = highest
        highest = min(highest + batch, num + 1)
        out = check_prime_gpu(numbers)
        primes += [x for x in out if x > 0]
    return primes

main()
