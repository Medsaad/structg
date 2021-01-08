#!/usr/bin/env bash

srcDir="${PWD}/src"

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
componentTemp=$(cat ./templates/reactComponent.txt)
componentTemp=${componentTemp//"[compName]"/"$compName"}
echo "$componentTemp" >> ${innerPath}/${compName}/${compName}.page.js

echo ""
echo "${entity^} has been created"