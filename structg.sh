#!/usr/bin/env bash

srcDir="${PWD}/src"

subCommand=${1?"Run 'structg generate [page|atomic|atom|molecule|organism]' to start the app"}

function createComponent() {
    entity=$1
    compName=$2
    
    innerPath=${srcDir}/pages
    if [ $entity != 'page' ]; then
        innerPath="${srcDir}/components/${entity}s"
    fi

    #creating files
    mkdir "${innerPath}/${compName}"
    touch ${innerPath}/${compName}/${compName}.page.{js,css}
    
    #populating component with default data
    componentTemp=$(cat ${PWD}/templates/reactComponent.txt)
    componentTemp=${componentTemp//"[compName]"/"$compName"}
    echo "$componentTemp" >> ${innerPath}/${compName}/${compName}.page.js

    echo ""
    echo "${entity^} has been created"
}

if [ $subCommand != 'generate' ]; then
    echo "Error: Undefined command: $subCommand"
    exit 1
fi

entity=${2?"Missing third argument [page|atomic|atom|molecule|organism]"}

case $entity in
    atomic)
        #checking if directories already created
        if ( ls $srcDir | grep -qe 'pages\|components' ); then
            echo "Atomic pattern already established"
            exit 1
        else
            #make atomic directory structure 
            mkdir "${srcDir}/pages"
            mkdir "${srcDir}/components"
            mkdir "${srcDir}/components/atoms"
            mkdir "${srcDir}/components/molecules"
            mkdir "${srcDir}/components/organisms"
        fi
    ;;
    page)
        if ( ls $srcDir | grep -q pages ); then
            #accept component name
            read -p "Enter page name: " pageName
            pageName=${pageName^}
            
            createComponent $entity $pageName
        else
            echo "Run: 'structg generate atomic' first"
            exit 1
        fi
    ;;
    atom | molecule | organism)
        if ( ls $srcDir | grep -q 'components' ); then
            if ( ls ${srcDir}/components | grep -q 'atom\|organism\|molecules' ); then
                #accept component name
                read -p "Enter $entity name: " compName
                compName=${compName^}
            
                createComponent $entity $compName
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