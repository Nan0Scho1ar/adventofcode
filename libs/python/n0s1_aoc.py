
def file_to_strings(fname):
    with open(fname) as f:
        return f.readlines()

def file_to_string(fname):
    with open(fname) as f:
        return f.read()
