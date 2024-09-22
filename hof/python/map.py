# Simple map function implementation
def map1(fn, list):
    if list == []:
        return []

    return [fn(list[0])] + map1(fn, list[1:])

# Map function using list comprehension
def map2(fn, list):
    return [fn(x) for x in list]

print(map1(lambda x: x + 2, [1, 2, 3]))
print(map2(lambda x: x + 2, [1, 2, 3]))
