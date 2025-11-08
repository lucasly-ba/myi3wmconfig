import os
import subprocess


def main(args):
    cwd = os.environ.get("KITTY_WINDOW_CWD", os.getcwd())
    subprocess.Popen(["kitty", "--directory", cwd])
    return None
