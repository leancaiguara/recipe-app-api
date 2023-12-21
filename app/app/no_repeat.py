"""
No repeat function.
"""
from collections import Counter


def del_repeat(arreglo: list[int]):
    resultado = set(arreglo)
    return [*resultado]


def most_common(phrase: str):
    result = Counter(phrase.split(' '))
    return [elem[0] for elem in result.most_common(3)]
