#!/usr/bin/env bash

messages=(
    "Wake up! The AI finished doing your job for you."
    "Agent complete. I hope it didn't delete the database this time."
    "Ding! Your freshly baked code is ready."
    "The agent has stopped thinking. It claims to have reached enlightenment."
    "Task finished! The robot uprising has been delayed by another day."
    "All done! You can stop pretending to look busy now."
)

# Pick a random message
rand_msg=${messages[$RANDOM % ${#messages[@]}]}

# Use kitten notify to show the toast
/opt/homebrew/bin/kitty +kitten notify "Agent Status" "$rand_msg"
