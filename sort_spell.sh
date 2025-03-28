#! /bin/bash

sort ./spell/en.utf-8.add | uniq > ./spell/en.utf-8.add.sorted
rm ./spell/en.utf-8.add
mv ./spell/en.utf-8.add.sorted ./spell/en.utf-8.add

echo "Success!"
