#!/usr/bin/env bash

srcDir="${PWD}/src"

entity=$1
#accept component name
read -p "Enter $entity name: " compName
compName=${compName^}

innerPath=${srcDir}/pages
if [ $entity != 'page' ]; then
    innerPath="${srcDir}/components/${entity}s"
fi

#creating files
mkdir ${innerPath}/${compName}
touch ${innerPath}/${compName}/${compName}.component.{js,css}

#populating component with default data
componentTemp=$(cat ./templates/react-component.txt)
componentTemp=${componentTemp//"[compName]"/"$compName"}
echo "$componentTemp" >> ${innerPath}/${compName}/${compName}.component.js

echo ""
echo "${entity^} has been created"