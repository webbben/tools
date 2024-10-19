# Ben's scripts and stuff!

I made this repo to store tools I've built for fun. Quick description of how this repo works:

## Installation
To install these tools, do the following:

- `cd` to a directory where you'd like to clone this repo. you'll want it in a place you don't mind keeping the repo, as installation basically just makes pointers to the source files in here in your .zshrc profile.
- `git clone https://github.com/webbben/tools.git`, and `cd` into the project directory
- `./install.sh` - this will run a script that adds lines to your zsh profile. it does the following:
  - adds a line to include this `/bin` directory in the `PATH`.
  - adds a line to source all the files in this `/src` directory.
- restart the terminal. It should work now!

## directories

`/bin` - contains individual executable files which can be called as commands in the terminal.

`/src` - contains bash scripts that can contain function definitions, variables, etc which will be sourced and usable in the terminal.
- Note: when new files are added, you need to manually update `index.sh` to source it.
