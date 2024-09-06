#!/bin/bash

source ./assets/set_color.sh

source ./pkg/inputs/inputs.sh
source ./pkg/validators/paths_validator.sh
source ./pkg/validators/domain_validator.sh


function pdf_combiner()
{
    file_input

    if ! paths_input; then
        return 1
    fi

    # Define the output file path in the user's home directory
    output_file="$HOME/$file_name.nmap"

    # Create or clear the target .nmap file
    : > "$output_file"  # Use ':' as a no-op command to clear the file

    echo "Combining files into $output_file..."

    {
        for path in "${path_array[@]}"; do
            # Check if the file exists and is readable
            if [[ -f "$path" && -r "$path" ]]; then
                echo -e "\n# File: $path"  # Append a header for each file
                cat "$path"              # Append the file content
                echo -e "\n"             # Add spacing between files
            else
                echo "$(set_color "red")Error:$(set_color "*") Cannot read file $path. Skipping..."
            fi
        done
    } >> "$output_file"

    # Check if the resulting file was created and contains data
    if [[ -s "$output_file" ]]; then
        echo "$(set_color "green")Success ✓$(set_color "*") Output saved to $output_file"
    else
        echo "$(set_color "red")Error:$(set_color "*") No data combined into $output_file. Please check the paths."
        return 1
    fi
}
