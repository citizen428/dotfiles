# Set ipython prompt to ">>> " for easier copying
try:
    from IPython import get_ipython

    get_ipython().run_line_magic("doctest_mode", "")
    get_ipython().run_line_magic("load_ext", "ipython_autoimport")
except:
    pass


# Aliases to allow copying JSON and get Python objects
null = None
true = True
false = False

def perc(n):
    return format(n, '.2%')
