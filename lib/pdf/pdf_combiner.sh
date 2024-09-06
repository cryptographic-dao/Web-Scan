#!/bin/bash

source ./assets/set_color.sh

source ./lib/scan/helpers/inputs.sh

source ./validators/domain_validator.sh
source ./validators/paths_validator.sh


function pdf_combiner()
{
    file_input

    paths_input
    if [ $? -ne 0 ]; then
        return 1
    fi

    # Define the output file path in the user's home directory
    output_file="$HOME/$file_name.nmap"

    # Create or clear the target .nmap file
    > "$output_file"

    echo "Combining files into $output_file..."

    for path in "${path_array[@]}"; do
        # Check if the file exists and is readable
        if [[ -f "$path" && -r "$path" ]]; then
            echo -e "\n# File: $path" >> "$output_file"  # Append a header for each file
            cat "$path" >> "$output_file"                # Append the file content
            echo -e "\n" >> "$output_file"               # Add spacing between files
        else
            echo "$(set_color "red")Error:$(set_color "*") Cannot read file $path. Skipping..."
        fi
    done

    # Check if the resulting file was created and contains data
    if [[ -s "$output_file" ]]; then
        echo "$(set_color "green")Success ✓$(set_color "*") Output saved to $output_file"
    else
        echo "$(set_color "red")Error:$(set_color "*") No data combined into $output_file. Please check the paths."
        return 1
    fi
}
