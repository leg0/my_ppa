#!/bin/bash
while (( "$#" )); do
    case $1 in
        --email )
            shift
            EMAIL=$1
            ;;
    esac
    shift
done

: ${EMAIL? email is required, provide with --email your@email.com}

gpg --full-gen-key
gpg --armor --export "${EMAIL}" > ./KEY.gpg
