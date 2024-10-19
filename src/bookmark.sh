#!/bin/bash

BOOKMARK_STORE=~/.bookmarks.txt

if [ ! -f $BOOKMARK_STORE ]; then
    touch $BOOKMARK_STORE
fi

function mark() {
    # if no args, list the bookmarks
    if [ -z "$1" ]; then
        cat $BOOKMARK_STORE
        return 0
    fi

    # if flag -d is passed, delete all bookmarks
    if [[ "$1" == "-d" ]]; then
        echo "Are you sure you want to delete all bookmarks? (y/n)"
        read -r response
        if [ "$response" != "y" ]; then
            return 0
        fi
        rm $BOOKMARK_STORE
        touch $BOOKMARK_STORE
        echo "All bookmarks deleted."
        return 0
    fi

    local name=$1
    local dir=$(pwd)
    
    # check if the bookmark exists
    if grep -q "^$name:" $BOOKMARK_STORE; then
	    echo "Bookmark '$name' already exists."
        echo "Replace it? (y/n)"
        read -r response
        if [ "$response" != "y" ]; then
            return 0
        fi
        sed -i '' "/^$name:.*/d" $BOOKMARK_STORE
    fi

    # create mapping
    printf "%s:%s\n" "$name" "$dir" >> $BOOKMARK_STORE
    echo "Bookmark '$name' set for $dir"
}

function _recall_complete() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local bookmarks=$(awk -F: '{print $1}' $BOOKMARK_STORE)
    COMPREPLY=($(compgen -W "$bookmarks" -- $cur))
}

complete -F _recall_complete recall

function recall() {
    if [ -z "$1" ]; then
        cat $BOOKMARK_STORE
            return 0
    fi
    local name=$1

    dir=$(grep -o "^$name:.*" $BOOKMARK_STORE | cut -d':' -f2-)

    if [ "$dir" ]; then
	    cd $dir
    else
	    echo "Bookmark not found."
    fi
}


