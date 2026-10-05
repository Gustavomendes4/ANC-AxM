
from model.filters.PFilter import PFilter

filterP = PFilter()

data = filterP.filter( [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] )

for i in data:
    print(i)
