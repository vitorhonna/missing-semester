if [[ -f log-execution.txt && -f log-error.txt ]]; then
    echo -e "Removing old logs...\n"
    rm log-execution.txt log-error.txt
fi

echo -e "Running test...\n"

scriptHasNotFailed=1
counter=0

while [[ $scriptHasNotFailed -eq 1 ]]; do
    ((counter++))

    sh script.sh >> log-execution.txt 2>> log-error.txt

    exec_status="$?"

    echo "(run #$counter)" >> log-execution.txt
    echo --------------------------------- >> log-execution.txt

    if [[ $exec_status -ne 0 ]]; then
        echo "(run #$counter)" >> log-error.txt
        echo -e "Script has failed on run #$counter. Stopping test...\n"
        echo --------------------------------- >> log-error.txt
        scriptHasNotFailed=0
    fi
done

echo -e "Printing results...\n"

echo -e "# Execution:\n"

cat log-execution.txt

echo -e "\n# Error:\n"

cat log-error.txt