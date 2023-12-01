#!/bin/bash

set -eu

tc() { set ${*,,} ; echo ${*^} ; }

# items in those subcategories have a special header with a 'Size' column
wearable=("shoes" "boots" "vests")

for file in $(find ./db/ -name *.csv); do
    printf "db file is %s\n" "$file"

    tfile="${file//csv/md}"
    tfile="${tfile//db/src}"
    printf "target file is %s\n" "$tfile"

    # find metadata based on the file content
    cat=$(dirname "$tfile" | cut -d '/' -f 3)
    sub=$(basename "$tfile" .md)
    title=$(tc "$sub" | sed 's/_/ /g')
    printf "category is %s and subcategory is %s\n" "$cat" "$sub"

    # create folder and empty md files
    mkdir -p "$(dirname "$tfile")"
    touch "$tfile"

    if [[ ${wearable[*]} =~ $sub ]]; then
        # add headers to md file
        cat > "$tfile" << HEADER
# ${title}

<br>

|    Brand    |      Model       | Size | Weight (g) |
| :---------: | :--------------: | :--: | :--------: |
HEADER

        # read csv content and add it to md table
        while IFS= read -r line || [ -n "$line" ]; do
            brand=$(echo "$line" | cut -d ',' -f 1)
            model=$(echo "$line" | cut -d ',' -f 2)
            size=$(echo "$line" | cut -d ',' -f 3)
            weight=$(echo "$line" | cut -d ',' -f 4)
            printf "| %s | %s | %s | %s |\n" "$brand" "$model" "$size" "$weight" >> "$tfile"
        done <  <(tail -n+2 "$file")
        printf "\n_Sizes are given following the EU standard._" >> "$tfile"
    elif [[ "$sub" == "skis" ]]; then
        # add headers to md file
        cat > "$tfile" << HEADER
# ${title}

<br>

|    Brand    |      Model       | Length | Bindings | Weight (g) |
| :---------: | :--------------: | :----: | :------: | :--------: |
HEADER

        # read csv content and add it to md table
        while IFS= read -r line || [ -n "$line" ]; do
            brand=$(echo "$line" | cut -d ',' -f 1)
            model=$(echo "$line" | cut -d ',' -f 2)
            length=$(echo "$line" | cut -d ',' -f 3)
            bindings=$(echo "$line" | cut -d ',' -f 4)
            weight=$(echo "$line" | cut -d ',' -f 5)
            printf "| %s | %s | %s | %s | %s |\n" "$brand" "$model" "$length" "$bindings" "$weight" >> "$tfile"
        done <  <(tail -n+2 "$file")
    else
        # override title in special cases
        if [ "$title" == "Plates mugs co" ]; then
            title="Plates, mugs & co."
        fi

        # override title in special cases
        if [ "$title" == "Gps" ]; then
            title="GPS"
        fi

        # add headers to md file
        cat > "$tfile" << HEADER
# ${title}

<br>

|    Brand    |      Model       | Weight (g) |
| :---------: | :--------------: | :--------: |
HEADER

        # read csv content and add it to md table
        while IFS= read -r line || [ -n "$line" ]; do
            brand=$(echo "$line" | cut -d ',' -f 1)
            model=$(echo "$line" | cut -d ',' -f 2)
            weight=$(echo "$line" | cut -d ',' -f 3)
            printf "| %s | %s | %s |\n" "$brand" "$model" "$weight" >> "$tfile"
        done <  <(tail -n+2 "$file")

        if [ "$cat" == "electronics" ]; then
            printf "\n_Weights indicated are without batteries, if they are removable._" >> "$tfile"
        fi
    fi
done