# ruff: noqa: F401, F403
import json
import sys
from typing import *

# Aliases to allow copying JSON into the REPL
null = None
true = True
false = False


def perc(n):
    return format(n, ".2%")


def mro(cls):
    print(", ".join(c.__name__ for c in cls.__mro__))
