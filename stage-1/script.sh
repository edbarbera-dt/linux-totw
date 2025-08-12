#!/bin/bash

# Function to display usage
# show_usage() {
#     echo "Usage: $0 <number_of_files> [target_directory] [-subdirs <num_subdirs>]"
#     echo "  number_of_files: Number of random files to generate"
#     echo "  target_directory: Directory where files will be created (default: current directory)"
#     echo "  -subdirs: Number of subdirectories to create for distributing files"
#     echo ""
#     echo "Examples:"
#     echo "  $0 10                    # Create 10 files in current directory"
#     echo "  $0 20 /tmp/test         # Create 20 files in /tmp/test"
#     echo "  $0 15 ./output -subdirs 3  # Create 15 files distributed across 3 subdirectories in ./output"
# }

# Initialize variables
num_files="ya"
target_dir="count-me/"
num_subdirs=6

# Parse arguments
# while [[ $# -gt 0 ]]; do
#     case $1 in
#         -subdirs)
#             if [[ -z "$2" ]] || [[ "$2" =~ ^- ]]; then
#                 echo "Error: -subdirs requires a number"
#                 show_usage
#                 exit 1
#             fi
#             num_subdirs=$2
#             shift 2
#             ;;
#         -h|--help)
#             show_usage
#             exit 0
#             ;;
#         *)
#             if [[ -z "$num_files" ]]; then
#                 num_files=$1
#             elif [[ -z "$target_dir" ]] || [[ "$target_dir" == "." ]]; then
#                 target_dir=$1
#             else
#                 echo "Error: Unexpected argument '$1'"
#                 show_usage
#                 exit 1
#             fi
#             shift
#             ;;
#     esac
# done

# # Validate required arguments
# if [[ -z "$num_files" ]]; then
#     echo "Error: Number of files is required"
#     show_usage
#     exit 1
# fi

# # Validate numeric inputs
# if ! [[ "$num_files" =~ ^[0-9]+$ ]]; then
#     echo "Error: Number of files must be a positive integer"
#     exit 1
# fi

# if ! [[ "$num_subdirs" =~ ^[0-9]+$ ]]; then
#     echo "Error: Number of subdirectories must be a non-negative integer"
#     exit 1
# fi

# Check if target directory exists, create if it doesn't
if [ ! -d "$target_dir" ]; then
    echo "Directory '$target_dir' does not exist. Creating it..."
    mkdir -p "$target_dir"
fi

# Array of possible file extensions
extensions=(".txt" ".md" ".json" ".xml" ".log" ".cfg" ".yml" ".csv" ".dat" ".conf")

# Create subdirectories if specified
subdirs=()
if [ "$num_subdirs" -gt 0 ]; then
    echo "Creating $num_subdirs subdirectories..."
    for ((i=1; i<=$num_subdirs; i++)); do
        subdir_name="subdir_$(printf "%02d" $i)"
        subdir_path="$target_dir/$subdir_name"
        mkdir -p "$subdir_path"
        subdirs+=("$subdir_path")
        echo "Created subdirectory: $subdir_path"
    done
fi

# Create array of all possible directories (main + subdirectories)
all_dirs=("$target_dir")
if [ "$num_subdirs" -gt 0 ]; then
    all_dirs+=("${subdirs[@]}")
fi

total_dirs=${#all_dirs[@]}

echo "Generating $num_files files distributed across $total_dirs directories..."

# Function to generate random filename using bash built-ins
generate_random_filename() {
    local chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local filename=""
    for ((j=0; j<8; j++)); do
        filename+="${chars:$((RANDOM % ${#chars})):1}"
    done
    echo "$filename"
}

# Pre-calculate file distribution to avoid repetitive calculations
declare -a file_dirs
for ((i=1; i<=$((36#$num_files)); i++)); do
    dir_index=$(((i-1) % total_dirs))
    file_dirs[i]=${all_dirs[$dir_index]}
done

echo "Generating files..."

# Generate the files (batch creation for better performance)
filenames=()
for ((i=1; i<=$((36#$num_files)); i++)); do
    # Generate random filename using bash built-ins
    filename=$(generate_random_filename)

    # Pick random extension
    extension=${extensions[$RANDOM % ${#extensions[@]}]}

    # Get pre-calculated directory
    chosen_dir=${file_dirs[i]}

    # Store full file path
    full_path="${chosen_dir}/${filename}${extension}"
    filenames+=("$full_path")
done

# Create all files at once using touch
touch "${filenames[@]}"

# # Show creation messages (optional - can be disabled for even faster execution)
# if [ "$num_files" -le 100 ]; then
#     for filepath in "${filenames[@]}"; do
#         echo "Created file: $filepath"
#     done
# else
#     echo "Created $num_files files (file list suppressed for performance)"
# fi

# # Summary
# echo ""
# echo "=== Summary ==="
# echo "Successfully created $num_files random files!"
# echo "Target directory: $target_dir"
# if [ "$num_subdirs" -gt 0 ]; then
#     echo "Subdirectories created: $num_subdirs"
#     echo "Files distributed across: main directory + $num_subdirs subdirectories"

#     # Show file distribution
#     echo ""
#     echo "File distribution:"
#     for dir in "${all_dirs[@]}"; do
#         file_count=$(find "$dir" -maxdepth 1 -type f | wc -l)
#         if [ "$dir" == "$target_dir" ]; then
#             echo "  Main directory: $file_count files"
#         else
#             echo "  $(basename "$dir"): $file_count files"
#         fi
#     done
# else
#     echo "All files created in main directory"
# fi
