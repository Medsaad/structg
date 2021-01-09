#!/usr/bin/env bash

# gstruct generate atomic
# /src
#    /pages
#    /components
#         /atoms
#         /molecules
#         /organisms

srcDir="${PWD}/src"
subCommand=${1?"Run 'structg generate [page|atomic|atom|molecule|organism]' to start the app"}

if [ $subCommand != 'generate' ]; then
    echo "Error: Undefined command: $subCommand"
    exit 1
fi

entity=${2?"Missing third argument [page|atomic|atom|molecule|organism]"}

case $entity in
    atomic)
        #checking if directories already created
        if ( ls $srcDir | grep -qe 'pages\|components' ); then
            echo "Atomic pattern already established or some folders already exist!"
            exit 1
        else
            #make atomic directory structure 
            mkdir ${srcDir}/{pages,components}
            mkdir ${srcDir}/components/{atoms,molecules,organisms}
        fi
    ;;
    page)
        if ( ls $srcDir | grep -q pages ); then
            ./lib/create-component.sh $entity
        else
            echo "Run: 'structg generate atomic' first"
            exit 1
        fi
    ;;
    atom | molecule | organism)
        if ( ls $srcDir | grep -q 'components' ); then
            if ( ls ${srcDir}/components | grep -q 'atom\|organism\|molecules' ); then        
                ./lib/create-component.sh $entity
            else
                echo "Run: 'structg generate atomic' first"
                exit 1
            fi
        else
            echo "Run: 'structg generate atomic' first"
            exit 1
        fi
    ;;
    *)
        echo -n "Error: Undefined argument: $entity"
        exit 1
    ;;
esac