
import sys

from filters.PFilter import PFilter


filter = PFilter()

data = filter.filter( [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] )


from tqdm import tqdm
import time

for i in data:
    print(i)

