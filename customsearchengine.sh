#!/bin/bash

# Google Custom Search API Key
API_KEY="YOUR_API_KEY"

# Custom Search Engine ID
CX="YOUR_CX"

# Prompt user for search keyword
read -p "Enter the search keyword: " keyword

# Prompt user for languages to search
read -p "Enter the languages to search (comma-separated, e.g., en,es,fr): " languages

# Split the languages into an array
IFS=',' read -ra lang_array <<< "$languages"

# Iterate over the languages and perform the search
for lang in "${lang_array[@]}"; do
    echo "Searching in $lang language..."
    
    # Encode the keyword and language in the URL
    encoded_keyword=$(echo "$keyword" | sed -e 's/ /%20/g')
    url="https://www.googleapis.com/customsearch/v1?key=$API_KEY&cx=$CX&q=$encoded_keyword&lr=lang_$lang"
    
    # Make the API request and store the response in a variable
    response=$(curl -s "$url")
    
    # Extract and display the search results
    echo "Results in $lang language:"
    echo "$response" | grep -o "\"title\": \"[^\"]*\"" | sed -e 's/"title": "//' -e 's/"//'
    echo
done
