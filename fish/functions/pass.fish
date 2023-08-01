function pass -d "Get password from Bitwarden" --argument-names 'item'
    bw get password "$item" | wl-copy -p && echo "Password to primary clipboard"
end
