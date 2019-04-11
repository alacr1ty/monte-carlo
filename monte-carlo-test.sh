#!/bin/bash

threads=(1 2 4 8 16)
execution=()
cpus=$(grep -c ^processor /proc/cpuinfo)

for t in ${threads[@]}
do
	echo "*	NUMT:	$t"

	g++ -DNUMT=$t monte-carlo.cpp -o monte-carlo -lm -fopenmp
	execution=($(./monte-carlo) "${execution[@]}")
done

for t in $(seq 1 $((${#threads[@]}-1)))
do
	speedup=$(echo "${execution[$t]} / ${execution[0]}" | bc -l)
	echo "*	${threads[$t]} to 1 thread Speedup:	$speedup"

	fp=$(echo "(${threads[$t]}.0 / (${threads[$t]}.0 - 1.0)) * (1.0 - (1.0 / $speedup))" | bc -l)
	echo "*	${threads[$t]} to 1 thread Parallel Fraction:	$fp"
done

echo "*	Number of CPUs:	$cpus"
echo "*	System Load:	$(uptime)"