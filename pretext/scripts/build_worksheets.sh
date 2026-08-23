#!/bin/zsh

# 05-01 05-05 06-01 06-02a 06-02b
for sec in $@
    do for fmt in tex pdf scorm
        do pretext build ws-$sec-$fmt
        pretext build ws-$sec-$fmt-sols
    done
done